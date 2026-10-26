namespace Mirror
{
	public class SyncHashSet<T> : global::Mirror.SyncSet<T>
	{
		public SyncHashSet()
			: this((global::System.Collections.Generic.IEqualityComparer<T>)global::System.Collections.Generic.EqualityComparer<T>.Default)
		{
		}

		public SyncHashSet(global::System.Collections.Generic.IEqualityComparer<T> comparer)
			: base((global::System.Collections.Generic.ISet<T>)new global::System.Collections.Generic.HashSet<T>(comparer ?? global::System.Collections.Generic.EqualityComparer<T>.Default))
		{
		}

		public new global::System.Collections.Generic.HashSet<T>.Enumerator GetEnumerator()
		{
			return ((global::System.Collections.Generic.HashSet<T>)objects).GetEnumerator();
		}
	}
}
