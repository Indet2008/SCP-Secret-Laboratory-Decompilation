using System;

namespace Utf8Json.Formatters
{
	public sealed class NullableStringArrayFormatter : IJsonFormatter<string[]>, IJsonFormatter
	{
		public static readonly NullableStringArrayFormatter Default = new NullableStringArrayFormatter();

		public void Serialize(ref JsonWriter writer, string[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			if (value.Length != 0)
			{
				writer.WriteString(value[0]);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				writer.WriteString(value[i]);
			}
			writer.WriteEndArray();
		}

		public string[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			string[] array = new string[4];
			int count = 0;
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array.Length < count)
				{
					Array.Resize(ref array, count * 2);
				}
				array[count - 1] = reader.ReadString();
			}
			Array.Resize(ref array, count);
			return array;
		}
	}
}
