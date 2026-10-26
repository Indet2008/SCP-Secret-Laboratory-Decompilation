using System.Collections.Generic;
using UnityEngine;

public static class RandomElement
{
	public static T RandomItem<T>(this T[] array)
	{
		return array[Random.Range(0, array.Length)];
	}

	public static T RandomItem<T>(this List<T> list)
	{
		return list[Random.Range(0, list.Count)];
	}

	public static bool TryGetRandomItem<T>(this List<T> list, out T random)
	{
		if (list.Count > 0)
		{
			random = list.RandomItem();
			return true;
		}
		random = default;
		return false;
	}

	public static T PullRandomItem<T>(this List<T> list)
	{
		int index = Random.Range(0, list.Count);
		T result = list[index];
		list.RemoveAt(index);
		return result;
	}
}
