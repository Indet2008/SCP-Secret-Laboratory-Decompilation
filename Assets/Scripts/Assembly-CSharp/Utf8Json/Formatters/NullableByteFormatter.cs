using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableByteFormatter : IJsonFormatter<byte?>, IJsonFormatter, IObjectPropertyNameFormatter<byte?>
	{
		public static readonly NullableByteFormatter Default = new NullableByteFormatter();

		public void Serialize(ref JsonWriter writer, byte? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteByte(value.Value);
			}
		}

		public byte? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadByte();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, byte? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteByte(value.Value);
			writer.WriteQuotation();
		}

		public byte? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadByte(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
