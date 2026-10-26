using System;
using Mirror;

namespace Hints
{
	public class PackedLongHintParameter : PrimitiveHintParameter<long>
	{
		public static PackedLongHintParameter FromNetwork(NetworkReader reader)
		{
			PackedLongHintParameter packedLongHintParameter = new PackedLongHintParameter();
			packedLongHintParameter.Deserialize(reader);
			return packedLongHintParameter;
		}

		protected PackedLongHintParameter()
			: base((Func<NetworkReader, long>)NetworkReaderExtensions.ReadLong, (Action<NetworkWriter, long>)NetworkWriterExtensions.WriteLong)
		{
		}

		public PackedLongHintParameter(long value)
			: base(value, (Func<NetworkReader, long>)NetworkReaderExtensions.ReadLong, (Action<NetworkWriter, long>)NetworkWriterExtensions.WriteLong)
		{
		}
	}
}
