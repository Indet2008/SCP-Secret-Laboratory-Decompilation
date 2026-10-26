using System.Collections;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class BitArrayFormatter : IJsonFormatter<BitArray>, IJsonFormatter
	{
		public static readonly IJsonFormatter<BitArray> Default = new BitArrayFormatter();

		public void Serialize(ref JsonWriter writer, BitArray value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteBeginArray();
			for (int i = 0; i < value.Length; i++)
			{
				if (i != 0)
				{
					writer.WriteValueSeparator();
				}
				writer.WriteBoolean(value[i]);
			}
			writer.WriteEndArray();
		}

		public BitArray Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			reader.ReadIsBeginArrayWithVerify();
			int count = 0;
			ArrayBuffer<bool> arrayBuffer = new ArrayBuffer<bool>(4);
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				arrayBuffer.Add(reader.ReadBoolean());
			}
			return new BitArray(arrayBuffer.ToArray());
		}
	}
}
