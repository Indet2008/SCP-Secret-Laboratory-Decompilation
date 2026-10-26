namespace Utf8Json
{
	public interface IObjectPropertyNameFormatter<T>
	{
		void SerializeToPropertyName(ref JsonWriter writer, T value, IJsonFormatterResolver formatterResolver);

		T DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver);
	}
}
