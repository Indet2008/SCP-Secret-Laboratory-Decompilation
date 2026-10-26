using System.Net;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal static class WellKnownConstants
	{
		public static IPAddress IPv4MulticastAddress = IPAddress.Parse("239.255.255.250");

		public static IPAddress IPv6LinkLocalMulticastAddress = IPAddress.Parse("FF02::C");

		public static IPAddress IPv6LinkSiteMulticastAddress = IPAddress.Parse("FF05::C");

		public static IPEndPoint NatPmpEndPoint = new IPEndPoint(IPAddress.Parse("192.168.0.1"), 5351);
	}
}
