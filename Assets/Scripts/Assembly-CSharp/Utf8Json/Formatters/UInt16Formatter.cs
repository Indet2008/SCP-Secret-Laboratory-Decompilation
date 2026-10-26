using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class UInt16Formatter : IJsonFormatter<ushort>, IJsonFormatter, IObjectPropertyNameFormatter<ushort>
	{
		public static readonly UInt16Formatter Default = new UInt16Formatter();

		public void Serialize(ref JsonWriter writer, ushort value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteUInt16(value);
		}

		public ushort Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadUInt16();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, ushort value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteUInt16(value);
			writer.WriteQuotation();
		}

		public ushort DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadUInt16(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
