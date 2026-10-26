using System;
using System.Globalization;

namespace Utf8Json.Formatters
{
	public sealed class DateTimeOffsetFormatter : IJsonFormatter<DateTimeOffset>, IJsonFormatter
	{
		private readonly string formatString;

		public DateTimeOffsetFormatter()
		{
			formatString = null;
		}

		public DateTimeOffsetFormatter(string formatString)
		{
			this.formatString = formatString;
		}

		public void Serialize(ref JsonWriter writer, DateTimeOffset value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value.ToString(formatString));
		}

		public DateTimeOffset Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			string input = reader.ReadString();
			if (formatString == null)
			{
				return DateTimeOffset.Parse(input, CultureInfo.InvariantCulture);
			}
			return DateTimeOffset.ParseExact(input, formatString, CultureInfo.InvariantCulture);
		}
	}
}
