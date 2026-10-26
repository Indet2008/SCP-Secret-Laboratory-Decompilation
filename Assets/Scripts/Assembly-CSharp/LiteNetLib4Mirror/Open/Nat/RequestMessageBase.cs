using System.Collections.Generic;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal abstract class RequestMessageBase
	{
		public abstract IDictionary<string, object> ToXml();
	}
}
