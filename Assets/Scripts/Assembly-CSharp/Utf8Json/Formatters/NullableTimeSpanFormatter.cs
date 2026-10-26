using System;

namespace Utf8Json.Formatters
{
	public sealed class NullableTimeSpanFormatter : IJsonFormatter<TimeSpan?>, IJsonFormatter
	{
		private readonly TimeSpanFormatter innerFormatter;

		public NullableTimeSpanFormatter()
		{
			innerFormatter = new TimeSpanFormatter();
		}

		public void Serialize(ref JsonWriter writer, TimeSpan? value, IJsonFormatterResolver formatterResolver)
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

		public TimeSpan? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return innerFormatter.Deserialize(ref reader, formatterResolver);
		}
	}
}
