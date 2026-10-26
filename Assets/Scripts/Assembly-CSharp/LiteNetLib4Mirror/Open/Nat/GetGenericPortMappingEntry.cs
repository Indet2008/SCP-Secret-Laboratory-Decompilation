using System.Collections.Generic;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class GetGenericPortMappingEntry : RequestMessageBase
	{
		private readonly int _index;

		public GetGenericPortMappingEntry(int index)
		{
			_index = index;
		}

		public override IDictionary<string, object> ToXml()
		{
			return new Dictionary<string, object> { { "NewPortMappingIndex", _index } };
		}
	}
}
