using System;

namespace Utf8Json.Formatters
{
	public sealed class ByteArrayFormatter : IJsonFormatter<byte[]>, IJsonFormatter
	{
		public static readonly IJsonFormatter<byte[]> Default = new ByteArrayFormatter();

		public void Serialize(ref JsonWriter writer, byte[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteString(Convert.ToBase64String(value, Base64FormattingOptions.None));
			}
		}

		public byte[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return Convert.FromBase64String(reader.ReadString());
		}
	}
}
