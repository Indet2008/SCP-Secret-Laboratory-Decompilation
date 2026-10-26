using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class SortedListFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, SortedList<TKey, TValue>>
	{
		protected override void Add(ref SortedList<TKey, TValue> collection, int index, TKey key, TValue value)
		{
			collection.Add(key, value);
		}

		protected override SortedList<TKey, TValue> Create()
		{
			return new SortedList<TKey, TValue>();
		}
	}
}
