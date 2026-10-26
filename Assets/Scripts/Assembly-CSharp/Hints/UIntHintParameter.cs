using System;
using Mirror;

namespace Hints
{
	public class UIntHintParameter : PrimitiveHintParameter<uint>
	{
		public static UIntHintParameter FromNetwork(NetworkReader reader)
		{
			UIntHintParameter uIntHintParameter = new UIntHintParameter();
			uIntHintParameter.Deserialize(reader);
			return uIntHintParameter;
		}

		protected UIntHintParameter()
			: base((Func<NetworkReader, uint>)NetworkReaderExtensions.ReadUInt, (Action<NetworkWriter, uint>)((NetworkWriter writer, uint writerValue) =>
			{
				writer.WriteUInt(writerValue);
			}))
		{
		}

		public UIntHintParameter(uint value)
			: base(value, (Func<NetworkReader, uint>)NetworkReaderExtensions.ReadUInt, (Action<NetworkWriter, uint>)((NetworkWriter writer, uint writerValue) =>
			{
				writer.WriteUInt(writerValue);
			}))
		{
		}
	}
}
