using System;

namespace Utf8Json.Formatters
{
	public sealed class Int64ArrayFormatter : IJsonFormatter<long[]>, IJsonFormatter
	{
		public static readonly Int64ArrayFormatter Default = new Int64ArrayFormatter();

		public void Serialize(ref JsonWriter writer, long[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			if (value.Length != 0)
			{
				writer.WriteInt64(value[0]);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				writer.WriteInt64(value[i]);
			}
			writer.WriteEndArray();
		}

		public long[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			long[] array = new long[4];
			int count = 0;
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array.Length < count)
				{
					Array.Resize(ref array, count * 2);
				}
				array[count - 1] = reader.ReadInt64();
			}
			Array.Resize(ref array, count);
			return array;
		}
	}
}
