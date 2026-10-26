using System;

namespace Utf8Json.Formatters
{
	public sealed class ByteArraySegmentFormatter : IJsonFormatter<ArraySegment<byte>>, IJsonFormatter
	{
		public static readonly IJsonFormatter<ArraySegment<byte>> Default = new ByteArraySegmentFormatter();

		public void Serialize(ref JsonWriter writer, ArraySegment<byte> value, IJsonFormatterResolver formatterResolver)
		{
			if (value.Array == null)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteString(Convert.ToBase64String(value.Array, value.Offset, value.Count, Base64FormattingOptions.None));
			}
		}

		public ArraySegment<byte> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return default;
			}
			byte[] array = Convert.FromBase64String(reader.ReadString());
			return new ArraySegment<byte>(array, 0, array.Length);
		}
	}
}
