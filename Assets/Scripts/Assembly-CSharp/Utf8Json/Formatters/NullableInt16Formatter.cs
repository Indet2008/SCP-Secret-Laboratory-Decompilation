using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableInt16Formatter : IJsonFormatter<short?>, IJsonFormatter, IObjectPropertyNameFormatter<short?>
	{
		public static readonly NullableInt16Formatter Default = new NullableInt16Formatter();

		public void Serialize(ref JsonWriter writer, short? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteInt16(value.Value);
			}
		}

		public short? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadInt16();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, short? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteInt16(value.Value);
			writer.WriteQuotation();
		}

		public short? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadInt16(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
