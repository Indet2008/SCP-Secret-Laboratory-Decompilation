using System;
using Mirror;

namespace Hints
{
	public class ByteHintParameter : PrimitiveHintParameter<byte>
	{
		public static ByteHintParameter FromNetwork(NetworkReader reader)
		{
			ByteHintParameter byteHintParameter = new ByteHintParameter();
			byteHintParameter.Deserialize(reader);
			return byteHintParameter;
		}

		protected ByteHintParameter()
			: base((Func<NetworkReader, byte>)NetworkReaderExtensions.ReadByte, (Action<NetworkWriter, byte>)NetworkWriterExtensions.WriteByte)
		{
		}

		public ByteHintParameter(byte value)
			: base(value, (Func<NetworkReader, byte>)NetworkReaderExtensions.ReadByte, (Action<NetworkWriter, byte>)NetworkWriterExtensions.WriteByte)
		{
		}
	}
}
