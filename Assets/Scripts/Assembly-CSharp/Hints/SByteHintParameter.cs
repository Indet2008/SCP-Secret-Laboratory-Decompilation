using System;
using Mirror;

namespace Hints
{
	public class SByteHintParameter : PrimitiveHintParameter<sbyte>
	{
		public static SByteHintParameter FromNetwork(NetworkReader reader)
		{
			SByteHintParameter sByteHintParameter = new SByteHintParameter();
			sByteHintParameter.Deserialize(reader);
			return sByteHintParameter;
		}

		protected SByteHintParameter()
			: base((Func<NetworkReader, sbyte>)NetworkReaderExtensions.ReadSByte, (Action<NetworkWriter, sbyte>)NetworkWriterExtensions.WriteSByte)
		{
		}

		public SByteHintParameter(sbyte value)
			: base(value, (Func<NetworkReader, sbyte>)NetworkReaderExtensions.ReadSByte, (Action<NetworkWriter, sbyte>)NetworkWriterExtensions.WriteSByte)
		{
		}
	}
}
