using System;
using System.Globalization;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class DecimalFormatter : IJsonFormatter<decimal>, IJsonFormatter
	{
		public static readonly IJsonFormatter<decimal> Default = new DecimalFormatter();

		private readonly bool serializeAsString;

		public DecimalFormatter()
			: this(serializeAsString: false)
		{
		}

		public DecimalFormatter(bool serializeAsString)
		{
			this.serializeAsString = serializeAsString;
		}

		public void Serialize(ref JsonWriter writer, decimal value, IJsonFormatterResolver formatterResolver)
		{
			if (serializeAsString)
			{
				writer.WriteString(value.ToString(CultureInfo.InvariantCulture));
			}
			else
			{
				writer.WriteRaw(StringEncoding.UTF8.GetBytes(value.ToString(CultureInfo.InvariantCulture)));
			}
		}

		public decimal Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			JsonToken currentJsonToken = reader.GetCurrentJsonToken();
			switch (currentJsonToken)
			{
			case JsonToken.Number:
			{
				ArraySegment<byte> arraySegment = reader.ReadNumberSegment();
				return decimal.Parse(StringEncoding.UTF8.GetString(arraySegment.Array, arraySegment.Offset, arraySegment.Count), NumberStyles.Float, CultureInfo.InvariantCulture);
			}
			case JsonToken.String:
				return decimal.Parse(reader.ReadString(), NumberStyles.Float, CultureInfo.InvariantCulture);
			default:
				throw new InvalidOperationException("Invalid Json Token for DecimalFormatter:" + currentJsonToken);
			}
		}
	}
}
