using System;

namespace Utf8Json.Formatters
{
	public sealed class NullableDateTimeOffsetFormatter : IJsonFormatter<DateTimeOffset?>, IJsonFormatter
	{
		private readonly DateTimeOffsetFormatter innerFormatter;

		public NullableDateTimeOffsetFormatter()
		{
			innerFormatter = new DateTimeOffsetFormatter();
		}

		public NullableDateTimeOffsetFormatter(string formatString)
		{
			innerFormatter = new DateTimeOffsetFormatter(formatString);
		}

		public void Serialize(ref JsonWriter writer, DateTimeOffset? value, IJsonFormatterResolver formatterResolver)
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

		public DateTimeOffset? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return innerFormatter.Deserialize(ref reader, formatterResolver);
		}
	}
}
