using System.Collections.Generic;
using System.Linq;

namespace Utf8Json.Formatters
{
	public sealed class InterfaceLookupFormatter<TKey, TElement> : IJsonFormatter<ILookup<TKey, TElement>>, IJsonFormatter
	{
		public void Serialize(ref JsonWriter writer, ILookup<TKey, TElement> value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
			}
			else
			{
				formatterResolver.GetFormatterWithVerify<IEnumerable<IGrouping<TKey, TElement>>>().Serialize(ref writer, value.AsEnumerable(), formatterResolver);
			}
		}

		public ILookup<TKey, TElement> Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			if (reader.ReadIsNull())
			{
				return null;
			}
			int count = 0;
			IJsonFormatter<IGrouping<TKey, TElement>> formatterWithVerify = formatterResolver.GetFormatterWithVerify<IGrouping<TKey, TElement>>();
			Dictionary<TKey, IGrouping<TKey, TElement>> dictionary = new Dictionary<TKey, IGrouping<TKey, TElement>>();
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				IGrouping<TKey, TElement> grouping = formatterWithVerify.Deserialize(ref reader, formatterResolver);
				dictionary.Add(grouping.Key, grouping);
			}
			return new Lookup<TKey, TElement>(dictionary);
		}
	}
}
