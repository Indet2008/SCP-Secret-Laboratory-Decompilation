using System;
using System.Xml;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class GetPortMappingEntryResponseMessage : ResponseMessageBase
	{
		public string RemoteHost { get; private set; }

		public int ExternalPort { get; private set; }

		public NetworkProtocolType NetworkProtocolType { get; private set; }

		public int InternalPort { get; private set; }

		public string InternalClient { get; private set; }

		public bool Enabled { get; private set; }

		public string PortMappingDescription { get; private set; }

		public int LeaseDuration { get; private set; }

		internal GetPortMappingEntryResponseMessage(XmlDocument response, string serviceType, bool genericMapping)
			: base(response, serviceType, genericMapping ? "GetGenericPortMappingEntryResponseMessage" : "GetSpecificPortMappingEntryResponseMessage")
		{
			XmlNode node = GetNode();
			RemoteHost = (genericMapping ? node.GetXmlElementText("NewRemoteHost") : string.Empty);
			ExternalPort = (genericMapping ? Convert.ToInt32(node.GetXmlElementText("NewExternalPort")) : 65535);
			if (genericMapping)
			{
				NetworkProtocolType = ((!node.GetXmlElementText("NewProtocol").Equals("TCP", StringComparison.InvariantCultureIgnoreCase)) ? NetworkProtocolType.Udp : NetworkProtocolType.Tcp);
			}
			else
			{
				NetworkProtocolType = NetworkProtocolType.Udp;
			}
			InternalPort = Convert.ToInt32(node.GetXmlElementText("NewInternalPort"));
			InternalClient = node.GetXmlElementText("NewInternalClient");
			Enabled = node.GetXmlElementText("NewEnabled") == "1";
			PortMappingDescription = node.GetXmlElementText("NewPortMappingDescription");
			LeaseDuration = Convert.ToInt32(node.GetXmlElementText("NewLeaseDuration"));
		}
	}
}
