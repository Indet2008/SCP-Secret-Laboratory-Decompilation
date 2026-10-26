using System.Xml;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class AddPortMappingResponseMessage : ResponseMessageBase
	{
		public AddPortMappingResponseMessage(XmlDocument response, string serviceType, string typeName)
			: base(response, serviceType, typeName)
		{
		}
	}
}
