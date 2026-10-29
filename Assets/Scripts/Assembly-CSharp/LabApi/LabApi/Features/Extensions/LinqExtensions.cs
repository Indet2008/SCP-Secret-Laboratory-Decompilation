namespace LabApi.Features.Extensions
{
	public static class LinqExtensions
	{
		public static T? MinBy<T, TKey>(this global::System.Collections.Generic.IEnumerable<T> enumerable, global::System.Func<T, TKey> selectFunc) where T : class where TKey : global::System.IComparable
		{
			if (!global::System.Linq.Enumerable.Any(enumerable))
			{
				return null;
			}
			T val = global::System.Linq.Enumerable.First(enumerable);
			foreach (T item in enumerable)
			{
				if (selectFunc(item).CompareTo(selectFunc(val)) < 0)
				{
					val = item;
				}
			}
			return val;
		}

		public static T? MaxBy<T, TKey>(this global::System.Collections.Generic.IEnumerable<T> enumerable, global::System.Func<T, TKey> selectFunc) where T : class where TKey : global::System.IComparable
		{
			if (!global::System.Linq.Enumerable.Any(enumerable))
			{
				return null;
			}
			T val = global::System.Linq.Enumerable.First(enumerable);
			foreach (T item in enumerable)
			{
				if (selectFunc(item).CompareTo(selectFunc(val)) > 0)
				{
					val = item;
				}
			}
			return val;
		}
	}
}
