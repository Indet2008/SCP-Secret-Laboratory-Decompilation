using System.Collections.Generic;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class GetExternalIPAddressRequestMessage : RequestMessageBase
	{
		public override IDictionary<string, object> ToXml()
		{
			return new Dictionary<string, object>();
		}
	}
}
