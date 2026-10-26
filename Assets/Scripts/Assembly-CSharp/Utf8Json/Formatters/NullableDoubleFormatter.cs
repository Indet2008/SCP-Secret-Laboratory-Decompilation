using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableDoubleFormatter : IJsonFormatter<double?>, IJsonFormatter, IObjectPropertyNameFormatter<double?>
	{
		public static readonly NullableDoubleFormatter Default = new NullableDoubleFormatter();

		public void Serialize(ref JsonWriter writer, double? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteDouble(value.Value);
			}
		}

		public double? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadDouble();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, double? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteDouble(value.Value);
			writer.WriteQuotation();
		}

		public double? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadDouble(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
