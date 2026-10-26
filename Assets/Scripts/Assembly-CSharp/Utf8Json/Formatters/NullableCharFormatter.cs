namespace Utf8Json.Formatters
{
	public sealed class NullableCharFormatter : IJsonFormatter<char?>, IJsonFormatter
	{
		public static readonly NullableCharFormatter Default = new NullableCharFormatter();

		public void Serialize(ref JsonWriter writer, char? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				CharFormatter.Default.Serialize(ref writer, value.Value, formatterResolver);
			}
		}

		public char? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return CharFormatter.Default.Deserialize(ref reader, formatterResolver);
		}
	}
}
