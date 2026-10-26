namespace Utf8Json.Formatters
{
	public sealed class NullableFormatter<T> : IJsonFormatter<T?>, IJsonFormatter where T : struct
	{
		public void Serialize(ref JsonWriter writer, T? value, IJsonFormatterResolver formatterResolver)
		{
			if (!value.HasValue)
			{
				writer.WriteNull();
			}
			else
			{
				formatterResolver.GetFormatterWithVerify<T>().Serialize(ref writer, value.Value, formatterResolver);
			}
		}

		public T? Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return formatterResolver.GetFormatterWithVerify<T>().Deserialize(ref reader, formatterResolver);
		}
	}
}
