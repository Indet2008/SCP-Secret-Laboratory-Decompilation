using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal sealed class UpnpNatDevice : NatDevice
	{
		internal readonly UpnpNatDeviceInfo DeviceInfo;

		private readonly SoapClient _soapClient;

		internal UpnpNatDevice(UpnpNatDeviceInfo deviceInfo)
		{
			Touch();
			DeviceInfo = deviceInfo;
			_soapClient = new SoapClient(DeviceInfo.ServiceControlUri, DeviceInfo.ServiceType);
		}

		public override async Task<IPAddress> GetExternalIPAsync()
		{
			NatDiscoverer.TraceSource.LogInfo("GetExternalIPAsync - Getting external IP address");
			GetExternalIPAddressRequestMessage getExternalIPAddressRequestMessage = new GetExternalIPAddressRequestMessage();
			return new GetExternalIPAddressResponseMessage(await _soapClient.InvokeAsync("GetExternalIPAddress", getExternalIPAddressRequestMessage.ToXml()).TimeoutAfter(TimeSpan.FromSeconds(4.0)), DeviceInfo.ServiceType).ExternalIPAddress;
		}

		public override async Task CreatePortMapAsync(Mapping mapping)
		{
			Guard.IsNotNull(mapping, "mapping");
			if (mapping.PrivateIP.Equals(IPAddress.None))
			{
				mapping.PrivateIP = DeviceInfo.LocalAddress;
			}
			NatDiscoverer.TraceSource.LogInfo("CreatePortMapAsync - Creating port mapping {0}", mapping);
			bool retry = false;
			try
			{
				CreatePortMappingRequestMessage createPortMappingRequestMessage = new CreatePortMappingRequestMessage(mapping);
				await _soapClient.InvokeAsync("AddPortMapping", createPortMappingRequestMessage.ToXml()).TimeoutAfter(TimeSpan.FromSeconds(4.0));
				RegisterMapping(mapping);
			}
			catch (MappingException ex)
			{
				switch (ex.ErrorCode)
				{
				case 725:
					NatDiscoverer.TraceSource.LogWarn("Only Permanent Leases Supported - There is no warranty it will be closed");
					mapping.Lifetime = 0;
					mapping.LifetimeType = MappingLifetime.ForcedSession;
					retry = true;
					break;
				case 724:
					NatDiscoverer.TraceSource.LogWarn("Same Port Values Required - Using internal port {0}", mapping.PrivatePort);
					mapping.PublicPort = mapping.PrivatePort;
					retry = true;
					break;
				case 726:
					NatDiscoverer.TraceSource.LogWarn("Remote Host Only Supports Wildcard");
					mapping.PublicIP = IPAddress.None;
					retry = true;
					break;
				case 727:
					NatDiscoverer.TraceSource.LogWarn("External Port Only Supports Wildcard");
					throw;
				case 718:
					NatDiscoverer.TraceSource.LogWarn("Conflict with an already existing mapping");
					throw;
				default:
					throw;
				}
			}
			if (retry)
			{
				await CreatePortMapAsync(mapping);
			}
		}

		public override async Task DeletePortMapAsync(Mapping mapping)
		{
			Guard.IsNotNull(mapping, "mapping");
			if (mapping.PrivateIP.Equals(IPAddress.None))
			{
				mapping.PrivateIP = DeviceInfo.LocalAddress;
			}
			NatDiscoverer.TraceSource.LogInfo("DeletePortMapAsync - Deleteing port mapping {0}", mapping);
			try
			{
				DeletePortMappingRequestMessage deletePortMappingRequestMessage = new DeletePortMappingRequestMessage(mapping);
				await _soapClient.InvokeAsync("DeletePortMapping", deletePortMappingRequestMessage.ToXml()).TimeoutAfter(TimeSpan.FromSeconds(4.0));
				UnregisterMapping(mapping);
			}
			catch (MappingException ex)
			{
				if (ex.ErrorCode != 714)
				{
					throw;
				}
			}
		}

		public override async Task<IEnumerable<Mapping>> GetAllMappingsAsync()
		{
			int index = 0;
			List<Mapping> mappings = new List<Mapping>();
			NatDiscoverer.TraceSource.LogInfo("GetAllMappingsAsync - Getting all mappings");
			while (true)
			{
				try
				{
					GetGenericPortMappingEntry getGenericPortMappingEntry = new GetGenericPortMappingEntry(index++);
					GetPortMappingEntryResponseMessage getPortMappingEntryResponseMessage = new GetPortMappingEntryResponseMessage(await _soapClient.InvokeAsync("GetGenericPortMappingEntry", getGenericPortMappingEntry.ToXml()).TimeoutAfter(TimeSpan.FromSeconds(4.0)), DeviceInfo.ServiceType, genericMapping: true);
					if (!IPAddress.TryParse(getPortMappingEntryResponseMessage.InternalClient, out var address))
					{
						NatDiscoverer.TraceSource.LogWarn("InternalClient is not an IP address. Mapping ignored!");
						continue;
					}
					Mapping item = new Mapping(getPortMappingEntryResponseMessage.NetworkProtocolType, address, getPortMappingEntryResponseMessage.InternalPort, getPortMappingEntryResponseMessage.ExternalPort, getPortMappingEntryResponseMessage.LeaseDuration, getPortMappingEntryResponseMessage.PortMappingDescription);
					mappings.Add(item);
				}
				catch (MappingException ex)
				{
					if (ex.ErrorCode == 713 || ex.ErrorCode == 714 || ex.ErrorCode == 402 || ex.ErrorCode == 501)
					{
						NatDiscoverer.TraceSource.LogWarn("Router failed with {0}-{1}. No more mappings is assumed.", ex.ErrorCode, ex.ErrorText);
						break;
					}
					throw;
				}
			}
			return mappings.ToArray();
		}

		public override async Task<Mapping> GetSpecificMappingAsync(NetworkProtocolType networkProtocolType, int publicPort)
		{
			Guard.IsTrue(networkProtocolType == NetworkProtocolType.Tcp || networkProtocolType == NetworkProtocolType.Udp, "protocol");
			Guard.IsInRange(publicPort, 0, 65535, "port");
			NatDiscoverer.TraceSource.LogInfo("GetSpecificMappingAsync - Getting mapping for protocol: {0} port: {1}", Enum.GetName(typeof(NetworkProtocolType), networkProtocolType), publicPort);
			try
			{
				GetSpecificPortMappingEntryRequestMessage getSpecificPortMappingEntryRequestMessage = new GetSpecificPortMappingEntryRequestMessage(networkProtocolType, publicPort);
				GetPortMappingEntryResponseMessage getPortMappingEntryResponseMessage = new GetPortMappingEntryResponseMessage(await _soapClient.InvokeAsync("GetSpecificPortMappingEntry", getSpecificPortMappingEntryRequestMessage.ToXml()).TimeoutAfter(TimeSpan.FromSeconds(4.0)), DeviceInfo.ServiceType, genericMapping: false);
				if (getPortMappingEntryResponseMessage.NetworkProtocolType != networkProtocolType)
				{
					NatDiscoverer.TraceSource.LogWarn("Router responded to a protocol {0} query with a protocol {1} answer, work around applied.", networkProtocolType, getPortMappingEntryResponseMessage.NetworkProtocolType);
				}
				return new Mapping(networkProtocolType, IPAddress.Parse(getPortMappingEntryResponseMessage.InternalClient), getPortMappingEntryResponseMessage.InternalPort, publicPort, getPortMappingEntryResponseMessage.LeaseDuration, getPortMappingEntryResponseMessage.PortMappingDescription);
			}
			catch (MappingException ex)
			{
				if (ex.ErrorCode == 713 || ex.ErrorCode == 714 || ex.ErrorCode == 402 || ex.ErrorCode == 501)
				{
					NatDiscoverer.TraceSource.LogWarn("Router failed with {0}-{1}. No more mappings is assumed.", ex.ErrorCode, ex.ErrorText);
					return null;
				}
				throw;
			}
		}

		public override string ToString()
		{
			return $"EndPoint: {DeviceInfo.HostEndPoint}\nControl Url: {DeviceInfo.ServiceControlUri}\nService Type: {DeviceInfo.ServiceType}\nLast Seen: {base.LastSeen}";
		}
	}
}
