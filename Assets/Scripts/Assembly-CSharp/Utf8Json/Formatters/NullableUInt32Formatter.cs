using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableUInt32Formatter : IJsonFormatter<uint?>, IJsonFormatter, IObjectPropertyNameFormatter<uint?>
	{
		public static readonly NullableUInt32Formatter Default = new NullableUInt32Formatter();

		public void Serialize(ref JsonWriter writer, uint? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteUInt32(value.Value);
			}
		}

		public uint? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadUInt32();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, uint? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteUInt32(value.Value);
			writer.WriteQuotation();
		}

		public uint? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadUInt32(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
