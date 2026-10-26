using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public class ArraySegmentFormatter<T> : IJsonFormatter<ArraySegment<T>>, IJsonFormatter
	{
		private static readonly ArrayPool<T> arrayPool = new ArrayPool<T>(99);

		public void Serialize(ref JsonWriter writer, ArraySegment<T> value, IJsonFormatterResolver formatterResolver)
		{
			if (value.Array == null)
			{
				writer.WriteNull();
				return;
			}
			T[] array = value.Array;
			int offset = value.Offset;
			int count = value.Count;
			writer.WriteBeginArray();
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			if (count != 0)
			{
				formatterWithVerify.Serialize(ref writer, value.Array[offset], formatterResolver);
			}
			for (int i = 1; i < count; i++)
			{
				writer.WriteValueSeparator();
				formatterWithVerify.Serialize(ref writer, array[offset + i], formatterResolver);
			}
			writer.WriteEndArray();
		}

		public ArraySegment<T> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return default;
			}
			int count = 0;
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			T[] array = arrayPool.Rent();
			try
			{
				T[] array2 = array;
				reader.ReadIsBeginArrayWithVerify();
				while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
				{
					if (array2.Length < count)
					{
						Array.Resize(ref array2, array2.Length * 2);
					}
					array2[count - 1] = formatterWithVerify.Deserialize(ref reader, formatterResolver);
				}
				T[] array3 = new T[count];
				Array.Copy(array2, array3, count);
				Array.Clear(array, 0, Math.Min(count, array.Length));
				return new ArraySegment<T>(array3, 0, array3.Length);
			}
			finally
			{
				arrayPool.Return(array);
			}
		}
	}
}
