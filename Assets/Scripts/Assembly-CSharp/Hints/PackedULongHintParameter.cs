using System;
using Mirror;

namespace Hints
{
	public class PackedULongHintParameter : PrimitiveHintParameter<ulong>
	{
		public static PackedULongHintParameter FromNetwork(NetworkReader reader)
		{
			PackedULongHintParameter packedULongHintParameter = new PackedULongHintParameter();
			packedULongHintParameter.Deserialize(reader);
			return packedULongHintParameter;
		}

		protected PackedULongHintParameter()
			: base((Func<NetworkReader, ulong>)NetworkReaderExtensions.ReadULong, (Action<NetworkWriter, ulong>)NetworkWriterExtensions.WriteULong)
		{
		}

		public PackedULongHintParameter(ulong value)
			: base(value, (Func<NetworkReader, ulong>)NetworkReaderExtensions.ReadULong, (Action<NetworkWriter, ulong>)NetworkWriterExtensions.WriteULong)
		{
		}
	}
}
