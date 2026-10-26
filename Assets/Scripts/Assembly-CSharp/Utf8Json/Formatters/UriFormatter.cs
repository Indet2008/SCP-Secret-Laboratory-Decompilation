using System;

namespace Utf8Json.Formatters
{
	public sealed class UriFormatter : IJsonFormatter<Uri>, IJsonFormatter
	{
		public static readonly IJsonFormatter<Uri> Default = new UriFormatter();

		public void Serialize(ref JsonWriter writer, Uri value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteString(value.ToString());
			}
		}

		public Uri Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return new Uri(reader.ReadString(), UriKind.RelativeOrAbsolute);
		}
	}
}
