using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableUInt64Formatter : IJsonFormatter<ulong?>, IJsonFormatter, IObjectPropertyNameFormatter<ulong?>
	{
		public static readonly NullableUInt64Formatter Default = new NullableUInt64Formatter();

		public void Serialize(ref JsonWriter writer, ulong? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteUInt64(value.Value);
			}
		}

		public ulong? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadUInt64();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, ulong? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteUInt64(value.Value);
			writer.WriteQuotation();
		}

		public ulong? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadUInt64(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
