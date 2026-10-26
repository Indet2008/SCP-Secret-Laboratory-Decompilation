using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class UInt64Formatter : IJsonFormatter<ulong>, IJsonFormatter, IObjectPropertyNameFormatter<ulong>
	{
		public static readonly UInt64Formatter Default = new UInt64Formatter();

		public void Serialize(ref JsonWriter writer, ulong value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteUInt64(value);
		}

		public ulong Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadUInt64();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, ulong value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteUInt64(value);
			writer.WriteQuotation();
		}

		public ulong DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadUInt64(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
