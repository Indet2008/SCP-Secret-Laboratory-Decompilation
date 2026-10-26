namespace Utf8Json
{
	public static class JsonFormatterExtensions
	{
		public static string ToJsonString<T>(this IJsonFormatter<T> formatter, T value, IJsonFormatterResolver formatterResolver)
		{
			JsonWriter writer = default;
			formatter.Serialize(ref writer, value, formatterResolver);
			return writer.ToString();
		}
	}
}
