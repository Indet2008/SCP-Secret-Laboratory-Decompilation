using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class Int16Formatter : IJsonFormatter<short>, IJsonFormatter, IObjectPropertyNameFormatter<short>
	{
		public static readonly Int16Formatter Default = new Int16Formatter();

		public void Serialize(ref JsonWriter writer, short value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteInt16(value);
		}

		public short Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadInt16();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, short value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteInt16(value);
			writer.WriteQuotation();
		}

		public short DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadInt16(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
