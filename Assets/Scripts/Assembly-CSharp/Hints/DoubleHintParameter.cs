using System;
using System.Globalization;
using Mirror;

namespace Hints
{
	public class DoubleHintParameter : FormattablePrimitiveHintParameter<double>
	{
		public static DoubleHintParameter FromNetwork(NetworkReader reader)
		{
			DoubleHintParameter doubleHintParameter = new DoubleHintParameter();
			doubleHintParameter.Deserialize(reader);
			return doubleHintParameter;
		}

		private static string FormatDouble(double value, string format)
		{
			if (format != null)
			{
				return value.ToString(format, CultureInfo.CurrentCulture);
			}
			return value.ToString(CultureInfo.CurrentCulture);
		}

		public DoubleHintParameter(double value, string format)
			: base(value, format, (Func<double, string, string>)FormatDouble, (Func<NetworkReader, double>)NetworkReaderExtensions.ReadDouble, (Action<NetworkWriter, double>)NetworkWriterExtensions.WriteDouble)
		{
		}

		protected DoubleHintParameter()
			: base((Func<double, string, string>)FormatDouble, (Func<NetworkReader, double>)NetworkReaderExtensions.ReadDouble, (Action<NetworkWriter, double>)NetworkWriterExtensions.WriteDouble)
		{
		}
	}
}
