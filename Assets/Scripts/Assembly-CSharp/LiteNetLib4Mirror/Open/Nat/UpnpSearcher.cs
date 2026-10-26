using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Xml;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class UpnpSearcher : Searcher
	{
		private readonly IIPAddressesProvider _ipprovider;

		private readonly IDictionary<Uri, NatDevice> _devices;

		private readonly Dictionary<IPAddress, DateTime> _lastFetched;

		private static readonly string[] ServiceTypes = new string[4] { "WANIPConnection:2", "WANPPPConnection:2", "WANIPConnection:1", "WANPPPConnection:1" };

		internal UpnpSearcher(IIPAddressesProvider ipprovider)
		{
			_ipprovider = ipprovider;
			UdpClients = CreateUdpClients();
			_devices = new Dictionary<Uri, NatDevice>();
			_lastFetched = new Dictionary<IPAddress, DateTime>();
		}

		private List<UdpClient> CreateUdpClients()
		{
			List<UdpClient> list = new List<UdpClient>();
			try
			{
				foreach (IPAddress item in _ipprovider.UnicastAddresses())
				{
					try
					{
						list.Add(new UdpClient(new IPEndPoint(item, 0)));
					}
					catch (Exception)
					{
					}
				}
			}
			catch (Exception)
			{
				list.Add(new UdpClient(0));
			}
			return list;
		}

		protected override void Discover(UdpClient client, CancellationToken cancelationToken)
		{
			Discover(client, WellKnownConstants.IPv4MulticastAddress, cancelationToken);
			if (Socket.OSSupportsIPv6)
			{
				Discover(client, WellKnownConstants.IPv6LinkLocalMulticastAddress, cancelationToken);
				Discover(client, WellKnownConstants.IPv6LinkSiteMulticastAddress, cancelationToken);
			}
		}

		private void Discover(UdpClient client, IPAddress address, CancellationToken cancelationToken)
		{
			if (!IsValidClient(client.Client, address))
			{
				return;
			}
			NextSearch = DateTime.UtcNow.AddSeconds(1.0);
			IPEndPoint endPoint = new IPEndPoint(address, 1900);
			string[] serviceTypes = ServiceTypes;
			for (int i = 0; i < serviceTypes.Length; i++)
			{
				string s = DiscoverDeviceMessage.Encode(serviceTypes[i], address);
				byte[] bytes = Encoding.ASCII.GetBytes(s);
				for (int j = 0; j < 3; j++)
				{
					if (cancelationToken.IsCancellationRequested)
					{
						return;
					}
					client.Send(bytes, bytes.Length, endPoint);
				}
			}
		}

		private bool IsValidClient(Socket socket, IPAddress address)
		{
			IPEndPoint iPEndPoint = (IPEndPoint)socket.LocalEndPoint;
			if (socket.AddressFamily != address.AddressFamily)
			{
				return false;
			}
			switch (socket.AddressFamily)
			{
			case AddressFamily.InterNetwork:
				socket.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastInterface, iPEndPoint.Address.GetAddressBytes());
				return true;
			case AddressFamily.InterNetworkV6:
				if (iPEndPoint.Address.IsIPv6LinkLocal && !object.Equals(address, WellKnownConstants.IPv6LinkLocalMulticastAddress))
				{
					return false;
				}
				if (!iPEndPoint.Address.IsIPv6LinkLocal && !object.Equals(address, WellKnownConstants.IPv6LinkSiteMulticastAddress))
				{
					return false;
				}
				socket.SetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.MulticastInterface, BitConverter.GetBytes((int)iPEndPoint.Address.ScopeId));
				return true;
			default:
				return false;
			}
		}

		public override NatDevice AnalyseReceivedResponse(IPAddress localAddress, byte[] response, IPEndPoint endpoint)
		{
			string text = null;
			try
			{
				text = Encoding.UTF8.GetString(response);
				DiscoveryResponseMessage discoveryResponseMessage = new DiscoveryResponseMessage(text);
				string text2 = discoveryResponseMessage["ST"];
				if (!IsValidControllerService(text2))
				{
					NatDiscoverer.TraceSource.LogWarn("Invalid controller service. Ignoring.");
					return null;
				}
				NatDiscoverer.TraceSource.LogInfo("UPnP Response: Router advertised a '{0}' service!!!", text2);
				Uri uri = new Uri(discoveryResponseMessage["Location"] ?? discoveryResponseMessage["AL"]);
				NatDiscoverer.TraceSource.LogInfo("Found device at: {0}", uri.ToString());
				if (_devices.ContainsKey(uri))
				{
					NatDiscoverer.TraceSource.LogInfo("Already found - Ignored");
					_devices[uri].Touch();
					return null;
				}
				if (_lastFetched.ContainsKey(endpoint.Address))
				{
					DateTime dateTime = _lastFetched[endpoint.Address];
					if (DateTime.Now - dateTime < TimeSpan.FromSeconds(20.0))
					{
						return null;
					}
				}
				_lastFetched[endpoint.Address] = DateTime.Now;
				NatDiscoverer.TraceSource.LogInfo("{0}:{1}: Fetching service list", uri.Host, uri.Port);
				UpnpNatDeviceInfo deviceInfo = BuildUpnpNatDeviceInfo(localAddress, uri);
				UpnpNatDevice upnpNatDevice;
				lock (_devices)
				{
					upnpNatDevice = new UpnpNatDevice(deviceInfo);
					if (!_devices.ContainsKey(uri))
					{
						_devices.Add(uri, upnpNatDevice);
					}
				}
				return upnpNatDevice;
			}
			catch (Exception ex)
			{
				NatDiscoverer.TraceSource.LogError("Unhandled exception when trying to decode a device's response. ");
				NatDiscoverer.TraceSource.LogError("Report the issue in https://github.com/lontivero/LiteNetLib4Mirror.Open.Nat/issues");
				NatDiscoverer.TraceSource.LogError("Also copy and paste the following info:");
				NatDiscoverer.TraceSource.LogError("-- beging ---------------------------------");
				NatDiscoverer.TraceSource.LogError(ex.Message);
				NatDiscoverer.TraceSource.LogError("Data string:");
				NatDiscoverer.TraceSource.LogError(text ?? "No data available");
				NatDiscoverer.TraceSource.LogError("-- end ------------------------------------");
			}
			return null;
		}

		private static bool IsValidControllerService(string serviceType)
		{
			return (from serviceName in ServiceTypes
				let serviceUrn = "urn:schemas-upnp-org:service:" + serviceName
				where serviceType.ContainsIgnoreCase(serviceUrn)
				select new
				{
					ServiceName = serviceName,
					ServiceUrn = serviceUrn
				}).Any();
		}

		private UpnpNatDeviceInfo BuildUpnpNatDeviceInfo(IPAddress localAddress, Uri location)
		{
			NatDiscoverer.TraceSource.LogInfo("Found device at: {0}", location.ToString());
			IPEndPoint iPEndPoint = new IPEndPoint(IPAddress.Parse(location.Host), location.Port);
			WebResponse webResponse = null;
			try
			{
				HttpWebRequest httpWebRequest = WebRequest.CreateHttp(location);
				httpWebRequest.Headers.Add("ACCEPT-LANGUAGE", "en");
				httpWebRequest.Method = "GET";
				webResponse = httpWebRequest.GetResponse();
				if (webResponse is HttpWebResponse { StatusCode: not HttpStatusCode.OK } httpWebResponse)
				{
					throw new Exception($"Couldn't get services list: {httpWebResponse.StatusCode} {httpWebResponse.StatusDescription}");
				}
				XmlDocument xmlDocument = ReadXmlResponse(webResponse);
				NatDiscoverer.TraceSource.LogInfo("{0}: Parsed services list", iPEndPoint);
				XmlNamespaceManager xmlNamespaceManager = new XmlNamespaceManager(xmlDocument.NameTable);
				xmlNamespaceManager.AddNamespace("ns", "urn:schemas-upnp-org:device-1-0");
				foreach (XmlNode item in xmlDocument.SelectNodes("//ns:service", xmlNamespaceManager))
				{
					string xmlElementText = item.GetXmlElementText("serviceType");
					if (IsValidControllerService(xmlElementText))
					{
						NatDiscoverer.TraceSource.LogInfo("{0}: Found service: {1}", iPEndPoint, xmlElementText);
						string xmlElementText2 = item.GetXmlElementText("controlURL");
						NatDiscoverer.TraceSource.LogInfo("{0}: Found upnp service at: {1}", iPEndPoint, xmlElementText2);
						NatDiscoverer.TraceSource.LogInfo("{0}: Handshake Complete", iPEndPoint);
						return new UpnpNatDeviceInfo(localAddress, location, xmlElementText2, xmlElementText);
					}
				}
				throw new Exception("No valid control service was found in the service descriptor document");
			}
			catch (WebException ex)
			{
				NatDiscoverer.TraceSource.LogError("{0}: Device denied the connection attempt: {1}", iPEndPoint, ex);
				if (ex.InnerException is SocketException ex2)
				{
					NatDiscoverer.TraceSource.LogError("{0}: ErrorCode:{1}", iPEndPoint, ex2.ErrorCode);
					NatDiscoverer.TraceSource.LogError("Go to http://msdn.microsoft.com/en-us/library/system.net.sockets.socketerror.aspx");
					NatDiscoverer.TraceSource.LogError("Usually this happens. Try resetting the device and try again. If you are in a VPN, disconnect and try again.");
				}
				throw;
			}
			finally
			{
				webResponse?.Close();
			}
		}

		private static XmlDocument ReadXmlResponse(WebResponse response)
		{
			using StreamReader streamReader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
			string xml = streamReader.ReadToEnd();
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(xml);
			return xmlDocument;
		}
	}
}
