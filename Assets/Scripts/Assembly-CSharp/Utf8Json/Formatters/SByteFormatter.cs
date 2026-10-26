using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class SByteFormatter : IJsonFormatter<sbyte>, IJsonFormatter, IObjectPropertyNameFormatter<sbyte>
	{
		public static readonly SByteFormatter Default = new SByteFormatter();

		public void Serialize(ref JsonWriter writer, sbyte value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteSByte(value);
		}

		public sbyte Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadSByte();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, sbyte value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteSByte(value);
			writer.WriteQuotation();
		}

		public sbyte DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadSByte(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
