using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
using Mirror;
using NorthwoodLib.Pools;
using UnityEngine;

public static class CollectionExtensions
{
	public static void ShuffleQueue<T>(this Queue<T> queue, System.Random rng = null)
	{
		if (rng == null)
		{
			rng = new System.Random();
		}
		List<T> list = ListPool<T>.Shared.Rent(queue.Count);
		while (queue.Count > 0)
		{
			list.Add(queue.Dequeue());
		}
		queue.Clear();
		while (list.Count > 0)
		{
			int index = rng.Next(list.Count);
			queue.Enqueue(list[index]);
			list.RemoveAt(index);
		}
		ListPool<T>.Shared.Return(list);
	}

	public static void ShuffleList<T>(this IList<T> list, System.Random rng = null)
	{
		if (rng == null)
		{
			rng = new System.Random();
		}
		int num = list.Count;
		while (num > 1)
		{
			num--;
			int index = rng.Next(num + 1);
			T value = list[index];
			list[index] = list[num];
			list[num] = value;
		}
	}

	public static void ShuffleListSecure<T>(this IList<T> list)
	{
		using RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider();
		int num = list.Count;
		while (num > 1)
		{
			byte[] array = new byte[1];
			do
			{
				rNGCryptoServiceProvider.GetBytes(array);
			}
			while (array[0] >= num * (255 / num));
			int index = array[0] % num;
			num--;
			T value = list[index];
			list[index] = list[num];
			list[num] = value;
		}
	}

	public static TReturn[] OfType<TOriginal, TReturn>(this TOriginal[] original)
	{
		List<TReturn> list = ListPool<TReturn>.Shared.Rent();
		foreach (TOriginal val in original)
		{
			if (val is TReturn item)
			{
				list.Add(item);
			}
		}
		TReturn[] result = list.ToArray();
		ListPool<TReturn>.Shared.Return(list);
		return result;
	}

	public static bool IsEmpty(this Array array)
	{
		return array.Length == 0;
	}

	public static bool IsEmpty<T>(this T[] array)
	{
		return array.Length == 0;
	}

	public static bool IsEmpty<T>(this ArraySegment<T> array)
	{
		return array.Count == 0;
	}

	public static bool IsEmpty<T>(this List<T> list)
	{
		return list.Count == 0;
	}

	public static bool IsEmpty<T>(this Queue<T> queue)
	{
		return queue.Count == 0;
	}

	public static bool IsEmpty<T>(this Stack<T> stack)
	{
		return stack.Count == 0;
	}

	public static bool IsEmpty<T>(this HashSet<T> set)
	{
		return set.Count == 0;
	}

	public static bool IsEmpty<T>(this SortedSet<T> set)
	{
		return set.Count == 0;
	}

	public static bool IsEmpty<T>(this SyncList<T> list)
	{
		return list.Count == 0;
	}

	public static bool IsEmpty<T>(this SyncSet<T> set)
	{
		return set.Count == 0;
	}

	public static bool IsEmpty<TKey, TValue>(this SyncDictionary<TKey, TValue> dictionary)
	{
		return dictionary.Count == 0;
	}

	public static bool IsEmpty<T>(this ICollection<T> collection)
	{
		return collection.Count == 0;
	}

	public static bool IsEmpty<TKey, TValue>(this Dictionary<TKey, TValue> dictionary)
	{
		return dictionary.Count == 0;
	}

	public static bool IsEmpty<T>(this IEnumerable<T> iEnumerable)
	{
		return !iEnumerable.Any();
	}

	public static void EnsureCapacity<T>(this List<T> list, int capacity)
	{
		if (list.Capacity < capacity)
		{
			list.Capacity = capacity;
		}
	}

	public static int IndexOf<T>(this T[] array, T obj)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (EqualityComparer<T>.Default.Equals(array[i], obj))
			{
				return i;
			}
		}
		return -1;
	}

	public static int LastIndexOf<T>(this T[] array, T obj)
	{
		for (int num = array.Length - 1; num >= 0; num--)
		{
			if (EqualityComparer<T>.Default.Equals(array[num], obj))
			{
				return num;
			}
		}
		return -1;
	}

	public static bool Contains<T>(this T[] array, T obj)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (EqualityComparer<T>.Default.Equals(array[i], obj))
			{
				return true;
			}
		}
		return false;
	}

	public static void ForEach<T>(this T[] array, Action<T> obj)
	{
		for (int i = 0; i < array.Length; i++)
		{
			obj?.Invoke(array[i]);
		}
	}

	public static void Reverse<T>(this T[] array)
	{
		int num = 0;
		int num2 = array.Length;
		while (num < num2)
		{
			T val = array[num];
			array[num] = array[num2];
			array[num2] = val;
			num++;
			num2--;
		}
	}

	public static bool CheckIdentical<T>(ICollection<T> left, ICollection<T> right, Func<T, T, bool> isEqual)
	{
		bool flag = left == null;
		bool flag2 = right == null;
		if (flag != flag2)
		{
			return false;
		}
		if (flag & flag2)
		{
			return true;
		}
		int count = left.Count;
		int count2 = right.Count;
		if (count != count2)
		{
			return false;
		}
		for (int i = 0; i < count; i++)
		{
			if (!isEqual(left.ElementAt(i), right.ElementAt(i)))
			{
				return false;
			}
		}
		return true;
	}

	public static bool Contains(this string[] array, string str, StringComparison comparison = StringComparison.Ordinal)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (string.Equals(array[i], str, comparison))
			{
				return true;
			}
		}
		return false;
	}

	public static bool Contains(this List<string> list, string str, StringComparison comparison = StringComparison.Ordinal)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (string.Equals(list[i], str, comparison))
			{
				return true;
			}
		}
		return false;
	}

	public static bool TryGet<T>(this T[] array, int index, out T element)
	{
		if (index > -1 && index < array.Length)
		{
			element = array[index];
			return true;
		}
		element = default;
		return false;
	}

	public static bool TryGet<T>(this List<T> list, int index, out T element)
	{
		if (index > -1 && index < list.Count)
		{
			element = list[index];
			return true;
		}
		element = default;
		return false;
	}

	public static bool TryDequeue<T>(this Queue<T> queue, out T element)
	{
		if (queue.Count > 0)
		{
			element = queue.Dequeue();
			return true;
		}
		element = default;
		return false;
	}

	public static T[] ToArray<T>(this Array array)
	{
		T[] array2 = new T[array.Length];
		array.CopyTo(array2, 0);
		return array2;
	}

	public static int IndexOf(this GameObject[] array, GameObject obj)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] == obj)
			{
				return i;
			}
		}
		return -1;
	}

	public static int IndexOf(this List<GameObject> list, GameObject obj)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] == obj)
			{
				return i;
			}
		}
		return -1;
	}

	public static bool Contains(this GameObject[] array, GameObject obj)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] == obj)
			{
				return true;
			}
		}
		return false;
	}

	public static bool Contains(this List<GameObject> list, GameObject obj)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] == obj)
			{
				return true;
			}
		}
		return false;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static T FirstElement<T>(this ArraySegment<T> segment)
	{
		return segment.Array[segment.Offset];
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static T At<T>(this ArraySegment<T> segment, int index)
	{
		return segment.Array[segment.Offset + index];
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static ArraySegment<T> Segment<T>(this ArraySegment<T> segment, int offset)
	{
		return new ArraySegment<T>(segment.Array, segment.Offset + offset, segment.Count - offset);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static ArraySegment<T> Segment<T>(this ArraySegment<T> segment, int offset, int length)
	{
		return new ArraySegment<T>(segment.Array, segment.Offset + offset, length);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static ArraySegment<T> Segment<T>(this T[] array, int offset)
	{
		return new ArraySegment<T>(array, offset, array.Length - offset);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static ArraySegment<T> Segment<T>(this T[] array, int offset, int length)
	{
		return new ArraySegment<T>(array, offset, length);
	}

	public static TValue GetOrAdd<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, TKey key, Func<TValue> factory) where TValue : class
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return dictionary[key] = factory();
		}
		return value;
	}

	public static HashSet<TValue> GetOrAddNew<TKey, TValue>(this Dictionary<TKey, HashSet<TValue>> dictionary, TKey key)
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return dictionary[key] = new HashSet<TValue>();
		}
		return value;
	}

	public static List<TValue> GetOrAddNew<TKey, TValue>(this Dictionary<TKey, List<TValue>> dictionary, TKey key)
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return dictionary[key] = new List<TValue>();
		}
		return value;
	}

	public static Queue<TValue> GetOrAddNew<TKey, TValue>(this Dictionary<TKey, Queue<TValue>> dictionary, TKey key)
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return dictionary[key] = new Queue<TValue>();
		}
		return value;
	}

	public static Stack<TValue> GetOrAddNew<TKey, TValue>(this Dictionary<TKey, Stack<TValue>> dictionary, TKey key)
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return dictionary[key] = new Stack<TValue>();
		}
		return value;
	}
}
