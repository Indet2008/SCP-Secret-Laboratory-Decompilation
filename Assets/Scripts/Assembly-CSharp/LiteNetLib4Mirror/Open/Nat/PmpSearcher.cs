using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class PmpSearcher : Searcher
	{
		private readonly IIPAddressesProvider _ipprovider;

		private Dictionary<UdpClient, IEnumerable<IPEndPoint>> _gatewayLists;

		private int _timeout;

		internal PmpSearcher(IIPAddressesProvider ipprovider)
		{
			_ipprovider = ipprovider;
			_timeout = 250;
			CreateSocketsAndAddGateways();
		}

		private void CreateSocketsAndAddGateways()
		{
			UdpClients = new List<UdpClient>();
			_gatewayLists = new Dictionary<UdpClient, IEnumerable<IPEndPoint>>();
			try
			{
				List<IPEndPoint> list = (from ip in _ipprovider.GatewayAddresses()
					select new IPEndPoint(ip, 5351)).ToList();
				if (!list.Any())
				{
					list.AddRange(from ip in _ipprovider.DnsAddresses()
						select new IPEndPoint(ip, 5351));
				}
				if (!list.Any())
				{
					return;
				}
				foreach (IPAddress item in _ipprovider.UnicastAddresses())
				{
					UdpClient udpClient;
					try
					{
						udpClient = new UdpClient(new IPEndPoint(item, 0));
					}
					catch (SocketException)
					{
						continue;
					}
					_gatewayLists.Add(udpClient, list);
					UdpClients.Add(udpClient);
				}
			}
			catch (Exception ex2)
			{
				NatDiscoverer.TraceSource.LogError("There was a problem finding gateways: " + ex2);
			}
		}

		protected override void Discover(UdpClient client, CancellationToken cancelationToken)
		{
			NextSearch = DateTime.UtcNow.AddMilliseconds(_timeout);
			_timeout *= 2;
			if (_timeout >= 3000)
			{
				_timeout = 250;
				NextSearch = DateTime.UtcNow.AddSeconds(10.0);
				return;
			}
			byte[] array = new byte[2];
			foreach (IPEndPoint item in _gatewayLists[client])
			{
				if (cancelationToken.IsCancellationRequested)
				{
					break;
				}
				client.Send(array, array.Length, item);
			}
		}

		private bool IsSearchAddress(IPAddress address)
		{
			return _gatewayLists.Values.SelectMany((IEnumerable<IPEndPoint> x) => x).Any((IPEndPoint x) => x.Address.Equals(address));
		}

		public override NatDevice AnalyseReceivedResponse(IPAddress localAddress, byte[] response, IPEndPoint endpoint)
		{
			if (!IsSearchAddress(endpoint.Address) || response.Length != 12 || response[0] != 0 || response[1] != 128)
			{
				return null;
			}
			int num = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(response, 2));
			if (num != 0)
			{
				NatDiscoverer.TraceSource.LogError("Non zero error: {0}", num);
			}
			IPAddress publicAddress = new IPAddress(new byte[4]
			{
				response[8],
				response[9],
				response[10],
				response[11]
			});
			_timeout = 250;
			return new PmpNatDevice(endpoint.Address, publicAddress);
		}
	}
}
