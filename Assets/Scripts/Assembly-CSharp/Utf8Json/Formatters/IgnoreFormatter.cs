namespace Utf8Json.Formatters
{
	public sealed class IgnoreFormatter<T> : IJsonFormatter<T>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, T value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteNull();
		}

		public T Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			reader.ReadNextBlock();
			return default;
		}
	}
}
