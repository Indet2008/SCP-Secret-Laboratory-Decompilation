using System;
using Mirror;

namespace Hints
{
	public class ULongHintParameter : PrimitiveHintParameter<ulong>
	{
		public static ULongHintParameter FromNetwork(NetworkReader reader)
		{
			ULongHintParameter uLongHintParameter = new ULongHintParameter();
			uLongHintParameter.Deserialize(reader);
			return uLongHintParameter;
		}

		protected ULongHintParameter()
			: base((Func<NetworkReader, ulong>)NetworkReaderExtensions.ReadULong, (Action<NetworkWriter, ulong>)((NetworkWriter writer, ulong writerValue) =>
			{
				writer.WriteULong(writerValue);
			}))
		{
		}

		public ULongHintParameter(ulong value)
			: base(value, (Func<NetworkReader, ulong>)NetworkReaderExtensions.ReadULong, (Action<NetworkWriter, ulong>)((NetworkWriter writer, ulong writerValue) =>
			{
				writer.WriteULong(writerValue);
			}))
		{
		}
	}
}
