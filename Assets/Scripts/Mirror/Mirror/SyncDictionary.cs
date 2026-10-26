namespace Mirror
{
	public class SyncDictionary<TKey, TValue> : global::Mirror.SyncIDictionary<TKey, TValue>
	{
		public new global::System.Collections.Generic.Dictionary<TKey, TValue>.ValueCollection Values => ((global::System.Collections.Generic.Dictionary<TKey, TValue>)objects).Values;

		public new global::System.Collections.Generic.Dictionary<TKey, TValue>.KeyCollection Keys => ((global::System.Collections.Generic.Dictionary<TKey, TValue>)objects).Keys;

		public SyncDictionary()
			: base((global::System.Collections.Generic.IDictionary<TKey, TValue>)new global::System.Collections.Generic.Dictionary<TKey, TValue>())
		{
		}

		public SyncDictionary(global::System.Collections.Generic.IEqualityComparer<TKey> eq)
			: base((global::System.Collections.Generic.IDictionary<TKey, TValue>)new global::System.Collections.Generic.Dictionary<TKey, TValue>(eq))
		{
		}

		public SyncDictionary(global::System.Collections.Generic.IDictionary<TKey, TValue> d)
			: base((global::System.Collections.Generic.IDictionary<TKey, TValue>)new global::System.Collections.Generic.Dictionary<TKey, TValue>(d))
		{
		}

		public new global::System.Collections.Generic.Dictionary<TKey, TValue>.Enumerator GetEnumerator()
		{
			return ((global::System.Collections.Generic.Dictionary<TKey, TValue>)objects).GetEnumerator();
		}
	}
}
