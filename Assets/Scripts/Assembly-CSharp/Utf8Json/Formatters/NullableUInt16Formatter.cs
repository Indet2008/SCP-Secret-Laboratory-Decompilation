using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableUInt16Formatter : IJsonFormatter<ushort?>, IJsonFormatter, IObjectPropertyNameFormatter<ushort?>
	{
		public static readonly NullableUInt16Formatter Default = new NullableUInt16Formatter();

		public void Serialize(ref JsonWriter writer, ushort? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteUInt16(value.Value);
			}
		}

		public ushort? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadUInt16();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, ushort? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteUInt16(value.Value);
			writer.WriteQuotation();
		}

		public ushort? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadUInt16(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
