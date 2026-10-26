namespace Mirror
{
	public class SyncSortedSet<T> : global::Mirror.SyncSet<T>
	{
		public SyncSortedSet()
			: this((global::System.Collections.Generic.IComparer<T>)global::System.Collections.Generic.Comparer<T>.Default)
		{
		}

		public SyncSortedSet(global::System.Collections.Generic.IComparer<T> comparer)
			: base((global::System.Collections.Generic.ISet<T>)new global::System.Collections.Generic.SortedSet<T>(comparer ?? global::System.Collections.Generic.Comparer<T>.Default))
		{
		}

		public new global::System.Collections.Generic.SortedSet<T>.Enumerator GetEnumerator()
		{
			return ((global::System.Collections.Generic.SortedSet<T>)objects).GetEnumerator();
		}
	}
}
