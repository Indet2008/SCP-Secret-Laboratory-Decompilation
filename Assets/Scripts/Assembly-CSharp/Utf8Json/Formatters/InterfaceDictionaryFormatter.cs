using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class InterfaceDictionaryFormatter<TKey, TValue> : DictionaryFormatterBase<TKey, TValue, Dictionary<TKey, TValue>, IDictionary<TKey, TValue>>
	{
		protected override void Add(ref Dictionary<TKey, TValue> collection, int index, TKey key, TValue value)
		{
			collection.Add(key, value);
		}

		protected override Dictionary<TKey, TValue> Create()
		{
			return new Dictionary<TKey, TValue>();
		}

		protected override IDictionary<TKey, TValue> Complete(ref Dictionary<TKey, TValue> intermediateCollection)
		{
			return intermediateCollection;
		}
	}
}
