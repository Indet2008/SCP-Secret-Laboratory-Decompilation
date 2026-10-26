using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class Int32Formatter : IJsonFormatter<int>, IJsonFormatter, IObjectPropertyNameFormatter<int>
	{
		public static readonly Int32Formatter Default = new Int32Formatter();

		public void Serialize(ref JsonWriter writer, int value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteInt32(value);
		}

		public int Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadInt32();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, int value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteInt32(value);
			writer.WriteQuotation();
		}

		public int DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadInt32(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
