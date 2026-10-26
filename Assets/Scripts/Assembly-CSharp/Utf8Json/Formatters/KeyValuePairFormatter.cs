using System;
using System.Collections.Generic;
using Utf8Json.Formatters.Internal;

namespace Utf8Json.Formatters
{
	public sealed class KeyValuePairFormatter<TKey, TValue> : IJsonFormatter<KeyValuePair<TKey, TValue>>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, KeyValuePair<TKey, TValue> value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(StandardClassLibraryFormatterHelper.keyValuePairName[0]);
			formatterResolver.GetFormatterWithVerify<TKey>().Serialize(ref writer, value.Key, formatterResolver);
			writer.WriteRaw(StandardClassLibraryFormatterHelper.keyValuePairName[1]);
			formatterResolver.GetFormatterWithVerify<TValue>().Serialize(ref writer, value.Value, formatterResolver);
			writer.WriteEndObject();
		}

		public KeyValuePair<TKey, TValue> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("Data is Nil, KeyValuePair can not be null.");
			}
			TKey key = default;
			TValue value = default;
			reader.ReadIsBeginObjectWithVerify();
			int count = 0;
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key2 = reader.ReadPropertyNameSegmentRaw();
				StandardClassLibraryFormatterHelper.keyValuePairAutomata.TryGetValueSafe(key2, out var value2);
				switch (value2)
				{
				case 0:
					key = formatterResolver.GetFormatterWithVerify<TKey>().Deserialize(ref reader, formatterResolver);
					break;
				case 1:
					value = formatterResolver.GetFormatterWithVerify<TValue>().Deserialize(ref reader, formatterResolver);
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new KeyValuePair<TKey, TValue>(key, value);
		}
	}
}
