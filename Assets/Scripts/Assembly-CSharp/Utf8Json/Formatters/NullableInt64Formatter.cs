using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableInt64Formatter : IJsonFormatter<long?>, IJsonFormatter, IObjectPropertyNameFormatter<long?>
	{
		public static readonly NullableInt64Formatter Default = new NullableInt64Formatter();

		public void Serialize(ref JsonWriter writer, long? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteInt64(value.Value);
			}
		}

		public long? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadInt64();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, long? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteInt64(value.Value);
			writer.WriteQuotation();
		}

		public long? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadInt64(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
