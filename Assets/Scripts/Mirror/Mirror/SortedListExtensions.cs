namespace Mirror
{
	public static class SortedListExtensions
	{
		public static void RemoveRange<T, U>(this global::System.Collections.Generic.SortedList<T, U> list, int amount)
		{
			for (int i = 0; i < amount && i < list.Count; i++)
			{
				list.RemoveAt(0);
			}
		}
	}
}
