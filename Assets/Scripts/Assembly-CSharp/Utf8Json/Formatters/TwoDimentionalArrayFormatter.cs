using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class TwoDimentionalArrayFormatter<T> : IJsonFormatter<T[,]>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, T[,] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			int length = value.GetLength(0);
			int length2 = value.GetLength(1);
			writer.WriteBeginArray();
			for (int i = 0; i < length; i++)
			{
				if (i != 0)
				{
					writer.WriteValueSeparator();
				}
				writer.WriteBeginArray();
				for (int j = 0; j < length2; j++)
				{
					if (j != 0)
					{
						writer.WriteValueSeparator();
					}
					formatterWithVerify.Serialize(ref writer, value[i, j], formatterResolver);
				}
				writer.WriteEndArray();
			}
			writer.WriteEndArray();
		}

		public T[,] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			ArrayBuffer<ArrayBuffer<T>> arrayBuffer = new ArrayBuffer<ArrayBuffer<T>>(4);
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			int num = 0;
			int count = 0;
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				ArrayBuffer<T> value = new ArrayBuffer<T>((num == 0) ? 4 : num);
				int count2 = 0;
				reader.ReadIsBeginArrayWithVerify();
				while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count2))
				{
					value.Add(formatterWithVerify.Deserialize(ref reader, formatterResolver));
				}
				num = value.Size;
				arrayBuffer.Add(value);
			}
			T[,] array = new T[arrayBuffer.Size, num];
			for (int i = 0; i < arrayBuffer.Size; i++)
			{
				for (int j = 0; j < num; j++)
				{
					array[i, j] = arrayBuffer.Buffer[i].Buffer[j];
				}
			}
			return array;
		}
	}
}
