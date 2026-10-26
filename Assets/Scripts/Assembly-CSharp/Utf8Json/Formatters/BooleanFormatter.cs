using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class BooleanFormatter : IJsonFormatter<bool>, IJsonFormatter, IObjectPropertyNameFormatter<bool>
	{
		public static readonly BooleanFormatter Default = new BooleanFormatter();

		public void Serialize(ref JsonWriter writer, bool value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteBoolean(value);
		}

		public bool Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadBoolean();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, bool value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteBoolean(value);
			writer.WriteQuotation();
		}

		public bool DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadBoolean(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
