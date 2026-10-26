using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class IPAddressesProvider : IIPAddressesProvider
	{
		public IEnumerable<IPAddress> UnicastAddresses()
		{
			return IPAddresses((IPInterfaceProperties p) => p.UnicastAddresses.Select((UnicastIPAddressInformation x) => x.Address));
		}

		public IEnumerable<IPAddress> DnsAddresses()
		{
			return IPAddresses((IPInterfaceProperties p) => p.DnsAddresses);
		}

		public IEnumerable<IPAddress> GatewayAddresses()
		{
			return IPAddresses((IPInterfaceProperties p) => p.GatewayAddresses.Select((GatewayIPAddressInformation x) => x.Address));
		}

		private static IEnumerable<IPAddress> IPAddresses(Func<IPInterfaceProperties, IEnumerable<IPAddress>> ipExtractor)
		{
			return from networkInterface in NetworkInterface.GetAllNetworkInterfaces()
				where networkInterface.OperationalStatus == OperationalStatus.Up || networkInterface.OperationalStatus == OperationalStatus.Unknown
				let properties = networkInterface.GetIPProperties()
				from address in ipExtractor(properties)
				where address.AddressFamily == AddressFamily.InterNetwork || address.AddressFamily == AddressFamily.InterNetworkV6
				select address;
		}
	}
}
