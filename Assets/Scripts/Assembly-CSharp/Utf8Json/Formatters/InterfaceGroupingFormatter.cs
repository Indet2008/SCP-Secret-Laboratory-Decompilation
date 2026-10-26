using System;
using System.Collections.Generic;
using System.Linq;
using Utf8Json.Formatters.Internal;

namespace Utf8Json.Formatters
{
	public sealed class InterfaceGroupingFormatter<TKey, TElement> : IJsonFormatter<IGrouping<TKey, TElement>>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, IGrouping<TKey, TElement> value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteRaw(CollectionFormatterHelper.groupingName[0]);
			formatterResolver.GetFormatterWithVerify<TKey>().Serialize(ref writer, value.Key, formatterResolver);
			writer.WriteRaw(CollectionFormatterHelper.groupingName[1]);
			formatterResolver.GetFormatterWithVerify<IEnumerable<TElement>>().Serialize(ref writer, value.AsEnumerable(), formatterResolver);
			writer.WriteEndObject();
		}

		public IGrouping<TKey, TElement> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			TKey key = default;
			IEnumerable<TElement> elements = null;
			reader.ReadIsBeginObjectWithVerify();
			int count = 0;
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key2 = reader.ReadPropertyNameSegmentRaw();
				CollectionFormatterHelper.groupingAutomata.TryGetValueSafe(key2, out var value);
				switch (value)
				{
				case 0:
					key = formatterResolver.GetFormatterWithVerify<TKey>().Deserialize(ref reader, formatterResolver);
					break;
				case 1:
					elements = formatterResolver.GetFormatterWithVerify<IEnumerable<TElement>>().Deserialize(ref reader, formatterResolver);
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new Grouping<TKey, TElement>(key, elements);
		}
	}
}
