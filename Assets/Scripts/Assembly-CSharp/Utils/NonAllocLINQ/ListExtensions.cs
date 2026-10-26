using System;
using System.Collections.Generic;

namespace Utils.NonAllocLINQ
{
	public static class ListExtensions
	{
		public static void ForEach<T>(this List<T> target, Action<T> action)
		{
			foreach (T item in target)
			{
				action(item);
			}
		}

		public static bool Any<T>(this List<T> target, Func<T, bool> condition)
		{
			foreach (T item in target)
			{
				if (condition(item))
				{
					return true;
				}
			}
			return false;
		}

		public static int Count<T>(this List<T> target, Func<T, bool> condition)
		{
			int num = 0;
			foreach (T item in target)
			{
				if (condition(item))
				{
					num++;
				}
			}
			return num;
		}

		public static bool All<T>(this List<T> target, Func<T, bool> condition, bool emptyResult = true)
		{
			foreach (T item in target)
			{
				if (!condition(item))
				{
					return false;
				}
				emptyResult = true;
			}
			return emptyResult;
		}

		public static T FirstOrDefault<T>(this List<T> target, Func<T, bool> condition, T defaultRet)
		{
			foreach (T item in target)
			{
				if (condition(item))
				{
					return item;
				}
			}
			return defaultRet;
		}

		public static bool TryGetFirst<T>(this List<T> target, Func<T, bool> condition, out T first)
		{
			foreach (T item in target)
			{
				if (condition(item))
				{
					first = item;
					return true;
				}
			}
			first = default;
			return false;
		}

		public static bool TryGetFirstIndex<T>(this List<T> target, Func<T, bool> condition, out int indexOfFirst)
		{
			int count = target.Count;
			for (int i = 0; i < count; i++)
			{
				T arg = target[i];
				if (condition(arg))
				{
					indexOfFirst = i;
					return true;
				}
			}
			indexOfFirst = -1;
			return false;
		}

		public static bool AddIfNotContains<T>(this List<T> target, T element)
		{
			if (target.Contains(element))
			{
				return false;
			}
			target.Add(element);
			return true;
		}
	}
}
