using System;
using System.Globalization;

namespace Utf8Json.Formatters
{
	public sealed class DateTimeFormatter : IJsonFormatter<DateTime>, IJsonFormatter
	{
		private readonly string formatString;

		public DateTimeFormatter()
		{
			formatString = null;
		}

		public DateTimeFormatter(string formatString)
		{
			this.formatString = formatString;
		}

		public void Serialize(ref JsonWriter writer, DateTime value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value.ToString(formatString));
		}

		public DateTime Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			string s = reader.ReadString();
			if (formatString == null)
			{
				return DateTime.Parse(s, CultureInfo.InvariantCulture);
			}
			return DateTime.ParseExact(s, formatString, CultureInfo.InvariantCulture);
		}
	}
}
