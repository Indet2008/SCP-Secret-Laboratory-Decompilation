using System;

namespace Utf8Json.Formatters
{
	public sealed class CharArrayFormatter : IJsonFormatter<char[]>, IJsonFormatter
	{
		public static readonly CharArrayFormatter Default = new CharArrayFormatter();

		public void Serialize(ref JsonWriter writer, char[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			if (value.Length != 0)
			{
				CharFormatter.Default.Serialize(ref writer, value[0], formatterResolver);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				CharFormatter.Default.Serialize(ref writer, value[i], formatterResolver);
			}
			writer.WriteEndArray();
		}

		public char[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			char[] array = new char[4];
			int count = 0;
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array.Length < count)
				{
					Array.Resize(ref array, count * 2);
				}
				array[count - 1] = CharFormatter.Default.Deserialize(ref reader, formatterResolver);
			}
			Array.Resize(ref array, count);
			return array;
		}
	}
}
