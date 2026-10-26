using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class DictionaryFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, Dictionary<TKey, TValue>, Dictionary<TKey, TValue>.Enumerator, Dictionary<TKey, TValue>>
	{
		protected override void Add(ref Dictionary<TKey, TValue> collection, int index, TKey key, TValue value)
		{
			collection.Add(key, value);
		}

		protected override Dictionary<TKey, TValue> Complete(ref Dictionary<TKey, TValue> intermediateCollection)
		{
			return intermediateCollection;
		}

		protected override Dictionary<TKey, TValue> Create()
		{
			return new Dictionary<TKey, TValue>();
		}

		protected override Dictionary<TKey, TValue>.Enumerator GetSourceEnumerator(Dictionary<TKey, TValue> source)
		{
			return source.GetEnumerator();
		}
	}
}
