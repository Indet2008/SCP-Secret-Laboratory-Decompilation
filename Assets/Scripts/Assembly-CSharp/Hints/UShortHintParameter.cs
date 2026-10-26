using System;
using Mirror;

namespace Hints
{
	public class UShortHintParameter : PrimitiveHintParameter<ushort>
	{
		public static UShortHintParameter FromNetwork(NetworkReader reader)
		{
			UShortHintParameter uShortHintParameter = new UShortHintParameter();
			uShortHintParameter.Deserialize(reader);
			return uShortHintParameter;
		}

		protected UShortHintParameter()
			: base((Func<NetworkReader, ushort>)NetworkReaderExtensions.ReadUShort, (Action<NetworkWriter, ushort>)NetworkWriterExtensions.WriteUShort)
		{
		}

		public UShortHintParameter(ushort value)
			: base(value, (Func<NetworkReader, ushort>)NetworkReaderExtensions.ReadUShort, (Action<NetworkWriter, ushort>)NetworkWriterExtensions.WriteUShort)
		{
		}
	}
}
