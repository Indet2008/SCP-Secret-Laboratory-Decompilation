namespace Utf8Json.Formatters
{
	public sealed class NullableStringFormatter : IJsonFormatter<string>, IJsonFormatter, IObjectPropertyNameFormatter<string>
	{
		public static readonly IJsonFormatter<string> Default = new NullableStringFormatter();

		public void Serialize(ref JsonWriter writer, string value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value);
		}

		public string Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadString();
		}

		public void SerializeToPropertyName(ref JsonWriter writer, string value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value);
		}

		public string DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadString();
		}
	}
}
