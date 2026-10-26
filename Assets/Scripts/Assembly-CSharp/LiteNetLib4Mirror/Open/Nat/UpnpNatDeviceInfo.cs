using System;
using System.Net;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class UpnpNatDeviceInfo
	{
		public IPEndPoint HostEndPoint { get; private set; }

		public IPAddress LocalAddress { get; private set; }

		public string ServiceType { get; private set; }

		public Uri ServiceControlUri { get; private set; }

		public UpnpNatDeviceInfo(IPAddress localAddress, Uri locationUri, string serviceControlUrl, string serviceType)
		{
			LocalAddress = localAddress;
			ServiceType = serviceType;
			HostEndPoint = new IPEndPoint(IPAddress.Parse(locationUri.Host), locationUri.Port);
			if (Uri.IsWellFormedUriString(serviceControlUrl, UriKind.Absolute))
			{
				Uri uri = new Uri(serviceControlUrl);
				IPEndPoint hostEndPoint = HostEndPoint;
				serviceControlUrl = uri.PathAndQuery;
				NatDiscoverer.TraceSource.LogInfo("{0}: Absolute URI detected. Host address is now: {1}", hostEndPoint, HostEndPoint);
				NatDiscoverer.TraceSource.LogInfo("{0}: New control url: {1}", HostEndPoint, serviceControlUrl);
			}
			UriBuilder uriBuilder = new UriBuilder("http", locationUri.Host, locationUri.Port);
			ServiceControlUri = new Uri(uriBuilder.Uri, serviceControlUrl);
		}
	}
}
