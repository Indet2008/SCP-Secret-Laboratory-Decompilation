using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal sealed class PmpNatDevice : NatDevice
	{
		private readonly IPAddress _publicAddress;

		internal IPAddress LocalAddress { get; private set; }

		internal PmpNatDevice(IPAddress localAddress, IPAddress publicAddress)
		{
			LocalAddress = localAddress;
			_publicAddress = publicAddress;
		}

		public override async Task CreatePortMapAsync(Mapping mapping)
		{
			await InternalCreatePortMapAsync(mapping, create: true).TimeoutAfter(TimeSpan.FromSeconds(4.0));
			RegisterMapping(mapping);
		}

		public override async Task DeletePortMapAsync(Mapping mapping)
		{
			await InternalCreatePortMapAsync(mapping, create: false).TimeoutAfter(TimeSpan.FromSeconds(4.0));
			UnregisterMapping(mapping);
		}

		public override Task<IEnumerable<Mapping>> GetAllMappingsAsync()
		{
			throw new NotSupportedException();
		}

		public override Task<IPAddress> GetExternalIPAsync()
		{
			return Task.Run(() => _publicAddress).TimeoutAfter(TimeSpan.FromSeconds(4.0));
		}

		public override Task<Mapping> GetSpecificMappingAsync(NetworkProtocolType networkProtocolType, int port)
		{
			throw new NotSupportedException("NAT-PMP does not specify a way to get a specific port map");
		}

		private async Task<Mapping> InternalCreatePortMapAsync(Mapping mapping, bool create)
		{
			List<byte> list = new List<byte>();
			list.Add(0);
			list.Add((byte)((mapping.NetworkProtocolType != NetworkProtocolType.Tcp) ? 1 : 2));
			list.Add(0);
			list.Add(0);
			list.AddRange(BitConverter.GetBytes(IPAddress.HostToNetworkOrder((short)mapping.PrivatePort)));
			list.AddRange(BitConverter.GetBytes((short)(create ? IPAddress.HostToNetworkOrder((short)mapping.PublicPort) : 0)));
			list.AddRange(BitConverter.GetBytes(IPAddress.HostToNetworkOrder(mapping.Lifetime)));
			try
			{
				byte[] buffer = list.ToArray();
				int attempt = 0;
				int delay = 250;
				using UdpClient udpClient = new UdpClient();
				CreatePortMapListen(udpClient, mapping);
				while (attempt < 9)
				{
					await udpClient.SendAsync(buffer, buffer.Length, new IPEndPoint(LocalAddress, 5351));
					attempt++;
					delay *= 2;
					Thread.Sleep(delay);
				}
			}
			catch (Exception ex)
			{
				string arg = (create ? "create" : "delete");
				string text = $"Failed to {arg} portmap (protocol={mapping.NetworkProtocolType}, private port={mapping.PrivatePort})";
				NatDiscoverer.TraceSource.LogError(text);
				MappingException innerException = ex as MappingException;
				throw new MappingException(text, innerException);
			}
			return mapping;
		}

		private void CreatePortMapListen(UdpClient udpClient, Mapping mapping)
		{
			IPEndPoint remoteEP = new IPEndPoint(LocalAddress, 5351);
			byte[] array;
			do
			{
				array = udpClient.Receive(ref remoteEP);
			}
			while (array.Length < 16 || array[0] != 0);
			byte num = (byte)(array[1] & 0x7F);
			NetworkProtocolType networkProtocolType = NetworkProtocolType.Tcp;
			if (num == 1)
			{
				networkProtocolType = NetworkProtocolType.Udp;
			}
			short num2 = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(array, 2));
			IPAddress.NetworkToHostOrder(BitConverter.ToInt32(array, 4));
			short num3 = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(array, 8));
			short num4 = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(array, 10));
			uint num5 = (uint)IPAddress.NetworkToHostOrder(BitConverter.ToInt32(array, 12));
			if (num3 < 0 || num4 < 0 || num2 != 0)
			{
				string[] array2 = new string[6] { "Success", "Unsupported Version", "Not Authorized/Refused (e.g. box supports mapping, but user has turned feature off)", "Network Failure (e.g. NAT box itself has not obtained a DHCP lease)", "Out of resources (NAT box cannot create any more mappings at this time)", "Unsupported opcode" };
				throw new MappingException(num2, array2[num2]);
			}
			if (num5 != 0)
			{
				mapping.PublicPort = num4;
				mapping.NetworkProtocolType = networkProtocolType;
				mapping.Expiration = DateTime.Now.AddSeconds(num5);
			}
		}

		public override string ToString()
		{
			return $"Local Address: {LocalAddress}\nPublic IP: {_publicAddress}\nLast Seen: {base.LastSeen}";
		}
	}
}
