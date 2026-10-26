using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public class ArrayFormatter<T> : IJsonFormatter<T[]>, IJsonFormatter, IOverwriteJsonFormatter<T[]>
	{
		private static readonly ArrayPool<T> arrayPool = new ArrayPool<T>(99);

		private readonly CollectionDeserializeToBehaviour deserializeToBehaviour;

		public ArrayFormatter()
			: this(CollectionDeserializeToBehaviour.Add)
		{
		}

		public ArrayFormatter(CollectionDeserializeToBehaviour deserializeToBehaviour)
		{
			this.deserializeToBehaviour = deserializeToBehaviour;
		}

		public void Serialize(ref JsonWriter writer, T[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			if (value.Length != 0)
			{
				formatterWithVerify.Serialize(ref writer, value[0], formatterResolver);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				formatterWithVerify.Serialize(ref writer, value[i], formatterResolver);
			}
			writer.WriteEndArray();
		}

		public T[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
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
				return array3;
			}
			finally
			{
				arrayPool.Return(array);
			}
		}

		public void DeserializeTo(ref T[] value, ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return;
			}
			int count = 0;
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			if (deserializeToBehaviour == CollectionDeserializeToBehaviour.Add)
			{
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
					if (count != 0)
					{
						T[] destinationArray = new T[value.Length + count];
						Array.Copy(value, 0, destinationArray, 0, value.Length);
						Array.Copy(array2, 0, destinationArray, value.Length, count);
						Array.Clear(array, 0, Math.Min(count, array.Length));
					}
					return;
				}
				finally
				{
					arrayPool.Return(array);
				}
			}
			T[] array3 = value;
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array3.Length < count)
				{
					Array.Resize(ref array3, array3.Length * 2);
				}
				array3[count - 1] = formatterWithVerify.Deserialize(ref reader, formatterResolver);
			}
			Array.Resize(ref array3, count);
		}
	}
}
