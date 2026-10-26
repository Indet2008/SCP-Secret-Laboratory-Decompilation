using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class DoubleFormatter : IJsonFormatter<double>, IJsonFormatter, IObjectPropertyNameFormatter<double>
	{
		public static readonly DoubleFormatter Default = new DoubleFormatter();

		public void Serialize(ref JsonWriter writer, double value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteDouble(value);
		}

		public double Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadDouble();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, double value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteQuotation();
			writer.WriteDouble(value);
			writer.WriteQuotation();
		}

		public double DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> arraySegment = reader.ReadStringSegmentRaw();
			int readCount;
			return NumberConverter.ReadDouble(arraySegment.Array, arraySegment.Offset, out readCount);
		}
	}
}
