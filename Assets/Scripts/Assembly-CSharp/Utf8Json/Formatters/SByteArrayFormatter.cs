using System;

namespace Utf8Json.Formatters
{
	public sealed class SByteArrayFormatter : IJsonFormatter<sbyte[]>, IJsonFormatter
	{
		public static readonly SByteArrayFormatter Default = new SByteArrayFormatter();

		public void Serialize(ref JsonWriter writer, sbyte[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			if (value.Length != 0)
			{
				writer.WriteSByte(value[0]);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				writer.WriteSByte(value[i]);
			}
			writer.WriteEndArray();
		}

		public sbyte[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			sbyte[] array = new sbyte[4];
			int count = 0;
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array.Length < count)
				{
					Array.Resize(ref array, count * 2);
				}
				array[count - 1] = reader.ReadSByte();
			}
			Array.Resize(ref array, count);
			return array;
		}
	}
}
