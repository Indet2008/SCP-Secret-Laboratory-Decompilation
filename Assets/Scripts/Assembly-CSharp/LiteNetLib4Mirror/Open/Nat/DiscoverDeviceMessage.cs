using System.Globalization;
using System.Net;
using System.Net.Sockets;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal static class DiscoverDeviceMessage
	{
		public static string Encode(string serviceType, IPAddress address)
		{
			string text = string.Format((address.AddressFamily == AddressFamily.InterNetwork) ? "{0}" : "[{0}]", address);
			string format = "M-SEARCH * HTTP/1.1\r\nHOST: " + text + ":1900\r\nMAN: \"ssdp:discover\"\r\nMX: 3\r\nST: urn:schemas-upnp-org:service:{0}\r\n\r\n";
			return string.Format(CultureInfo.InvariantCulture, format, serviceType);
		}
	}
}
