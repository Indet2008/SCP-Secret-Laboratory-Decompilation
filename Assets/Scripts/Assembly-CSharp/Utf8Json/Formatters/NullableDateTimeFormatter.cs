using System;

namespace Utf8Json.Formatters
{
	public sealed class NullableDateTimeFormatter : IJsonFormatter<DateTime?>, IJsonFormatter
	{
		private readonly DateTimeFormatter innerFormatter;

		public NullableDateTimeFormatter()
		{
			innerFormatter = new DateTimeFormatter();
		}

		public NullableDateTimeFormatter(string formatString)
		{
			innerFormatter = new DateTimeFormatter(formatString);
		}

		public void Serialize(ref JsonWriter writer, DateTime? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				innerFormatter.Serialize(ref writer, value.Value, formatterResolver);
			}
		}

		public DateTime? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return innerFormatter.Deserialize(ref reader, formatterResolver);
		}
	}
}
