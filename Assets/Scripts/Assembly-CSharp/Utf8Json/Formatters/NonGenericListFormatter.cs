using System.Collections;

namespace Utf8Json.Formatters
{
	public sealed class NonGenericListFormatter<T> : IJsonFormatter<T>, IJsonFormatter where T : class, IList, new()
	{
		public void Serialize(ref JsonWriter writer, T value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			writer.WriteBeginArray();
			if (value.Count != 0)
			{
				formatterWithVerify.Serialize(ref writer, value[0], formatterResolver);
			}
			for (int i = 1; i < value.Count; i++)
			{
				writer.WriteValueSeparator();
				formatterWithVerify.Serialize(ref writer, value[i], formatterResolver);
			}
			writer.WriteEndArray();
		}

		public T Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			int count = 0;
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			T val = new T();
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				val.Add(formatterWithVerify.Deserialize(ref reader, formatterResolver));
			}
			return val;
		}
	}
}
