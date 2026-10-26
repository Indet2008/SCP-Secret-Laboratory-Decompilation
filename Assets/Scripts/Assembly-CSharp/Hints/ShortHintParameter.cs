using System;
using Mirror;

namespace Hints
{
	public class ShortHintParameter : PrimitiveHintParameter<short>
	{
		public static ShortHintParameter FromNetwork(NetworkReader reader)
		{
			ShortHintParameter shortHintParameter = new ShortHintParameter();
			shortHintParameter.Deserialize(reader);
			return shortHintParameter;
		}

		protected ShortHintParameter()
			: base((Func<NetworkReader, short>)NetworkReaderExtensions.ReadShort, (Action<NetworkWriter, short>)NetworkWriterExtensions.WriteShort)
		{
		}

		public ShortHintParameter(short value)
			: base(value, (Func<NetworkReader, short>)NetworkReaderExtensions.ReadShort, (Action<NetworkWriter, short>)NetworkWriterExtensions.WriteShort)
		{
		}
	}
}
