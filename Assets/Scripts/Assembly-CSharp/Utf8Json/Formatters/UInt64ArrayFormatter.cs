using System;

namespace Utf8Json.Formatters
{
	public sealed class UInt64ArrayFormatter : IJsonFormatter<ulong[]>, IJsonFormatter
	{
		public static readonly UInt64ArrayFormatter Default = new UInt64ArrayFormatter();

		public void Serialize(ref JsonWriter writer, ulong[] value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			if (value.Length != 0)
			{
				writer.WriteUInt64(value[0]);
			}
			for (int i = 1; i < value.Length; i++)
			{
				writer.WriteValueSeparator();
				writer.WriteUInt64(value[i]);
			}
			writer.WriteEndArray();
		}

		public ulong[] Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			ulong[] array = new ulong[4];
			int count = 0;
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				if (array.Length < count)
				{
					Array.Resize(ref array, count * 2);
				}
				array[count - 1] = reader.ReadUInt64();
			}
			Array.Resize(ref array, count);
			return array;
		}
	}
}
