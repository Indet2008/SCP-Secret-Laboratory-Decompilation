using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class SingleFormatter : IJsonFormatter<float>, IJsonFormatter, IObjectPropertyNameFormatter<float>
	{
		public static readonly SingleFormatter Default = new SingleFormatter();

		public void Serialize(ref JsonWriter writer, float value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteSingle(value);
		}

		public float Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadSingle();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, float value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteSingle(value);
			writer.WriteQuotation();
		}

		public float DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadSingle(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
