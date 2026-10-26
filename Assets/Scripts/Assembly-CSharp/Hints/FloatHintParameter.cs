using System;
using System.Globalization;
using Mirror;

namespace Hints
{
	public class FloatHintParameter : FormattablePrimitiveHintParameter<float>
	{
		public static FloatHintParameter FromNetwork(NetworkReader reader)
		{
			FloatHintParameter floatHintParameter = new FloatHintParameter();
			floatHintParameter.Deserialize(reader);
			return floatHintParameter;
		}

		private static string FormatFloat(float value, string format)
		{
			if (format != null)
			{
				return value.ToString(format, CultureInfo.CurrentCulture);
			}
			return value.ToString(CultureInfo.CurrentCulture);
		}

		protected FloatHintParameter()
			: base((Func<float, string, string>)FormatFloat, (Func<NetworkReader, float>)NetworkReaderExtensions.ReadFloat, (Action<NetworkWriter, float>)NetworkWriterExtensions.WriteFloat)
		{
		}

		public FloatHintParameter(float value, string format)
			: base(value, format, (Func<float, string, string>)FormatFloat, (Func<NetworkReader, float>)NetworkReaderExtensions.ReadFloat, (Action<NetworkWriter, float>)NetworkWriterExtensions.WriteFloat)
		{
		}
	}
}
