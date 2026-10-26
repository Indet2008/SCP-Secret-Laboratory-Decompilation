using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NullableSByteFormatter : IJsonFormatter<sbyte?>, IJsonFormatter, IObjectPropertyNameFormatter<sbyte?>
	{
		public static readonly NullableSByteFormatter Default = new NullableSByteFormatter();

		public void Serialize(ref JsonWriter writer, sbyte? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteSByte(value.Value);
			}
		}

		public sbyte? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return reader.ReadSByte();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, sbyte? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteQuotation();
			writer.WriteSByte(value.Value);
			writer.WriteQuotation();
		}

		public sbyte? DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadSByte(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
