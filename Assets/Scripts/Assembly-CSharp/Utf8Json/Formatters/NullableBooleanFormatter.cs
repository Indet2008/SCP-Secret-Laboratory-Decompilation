using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableBooleanFormatter : IJsonFormatter<bool?>, IJsonFormatter, IObjectPropertyNameFormatter<bool?>
	{
		public static readonly NullableBooleanFormatter Default = new NullableBooleanFormatter();

		public void Serialize(ref JsonWriter writer, bool? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteBoolean(value.Value);
			}
		}

		public bool? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadBoolean();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, bool? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteBoolean(value.Value);
			writer.WriteQuotation();
		}

		public bool? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadBoolean(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
