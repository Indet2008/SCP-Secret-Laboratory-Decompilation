using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public class ListFormatter<T> : IJsonFormatter<List<T>>, IJsonFormatter, IOverwriteJsonFormatter<List<T>>
	{
		private readonly CollectionDeserializeToBehaviour deserializeToBehaviour;

		public ListFormatter()
			: this(CollectionDeserializeToBehaviour.Add)
		{
		}

		public ListFormatter(CollectionDeserializeToBehaviour deserializeToBehaviour)
		{
			this.deserializeToBehaviour = deserializeToBehaviour;
		}

		public void Serialize(ref JsonWriter writer, List<T> value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
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

		public List<T> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			int count = 0;
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			List<T> list = new List<T>();
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				list.Add(formatterWithVerify.Deserialize(ref reader, formatterResolver));
			}
			return list;
		}

		public void DeserializeTo(ref List<T> value, ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (!reader.ReadIsNull())
			{
				int count = 0;
				IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
				List<T> list = value;
				if (deserializeToBehaviour == CollectionDeserializeToBehaviour.OverwriteReplace)
				{
					list.Clear();
				}
				reader.ReadIsBeginArrayWithVerify();
				while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
				{
					list.Add(formatterWithVerify.Deserialize(ref reader, formatterResolver));
				}
			}
		}
	}
}
