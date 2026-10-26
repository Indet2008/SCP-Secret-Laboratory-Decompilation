using System;
using Mirror;

namespace Hints
{
	public class StringHintParameter : PrimitiveHintParameter<string>
	{
		public static StringHintParameter FromNetwork(NetworkReader reader)
		{
			StringHintParameter stringHintParameter = new StringHintParameter();
			stringHintParameter.Deserialize(reader);
			return stringHintParameter;
		}

		protected StringHintParameter()
			: base((Func<NetworkReader, string>)NetworkReaderExtensions.ReadString, (Action<NetworkWriter, string>)NetworkWriterExtensions.WriteString)
		{
		}

		public StringHintParameter(string value)
			: base(value, (Func<NetworkReader, string>)NetworkReaderExtensions.ReadString, (Action<NetworkWriter, string>)NetworkWriterExtensions.WriteString)
		{
		}
	}
}
