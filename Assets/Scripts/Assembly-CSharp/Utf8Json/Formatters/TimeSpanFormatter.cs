using System;

namespace Utf8Json.Formatters
{
	public sealed class TimeSpanFormatter : IJsonFormatter<TimeSpan>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, TimeSpan value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value.ToString());
		}

		public TimeSpan Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return TimeSpan.Parse(reader.ReadString());
		}
	}
}
