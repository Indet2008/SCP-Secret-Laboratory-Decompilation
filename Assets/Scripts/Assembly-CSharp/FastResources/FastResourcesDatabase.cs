using System;
using System.Collections.Generic;
using UnityEngine;

namespace FastResources
{
	public class FastResourcesDatabase : ScriptableObject
	{
		[Serializable]
		private struct ResourcesTypePair
		{
			public string TypeName;

			public List<UnityEngine.Object> Resources;
		}

		public const string FullDatabasePath = "Assets/_Scripts/FastResources/Resources/FastResources/FastResources.asset";

		public const string RelativeDatabasePath = "FastResources/FastResources";

		private static Dictionary<Type, List<UnityEngine.Object>> _dictionarizedRaw;

		private static Dictionary<Type, object> _dictionarizedTyped;

		private static bool _cacheSet;

		[SerializeField]
		private ResourcesTypePair[] _resources;

		public static T GetFirst<T>() where T : UnityEngine.Object
		{
			if (!TryGetFirst<T>(out var result))
			{
				return null;
			}
			return result;
		}

		public static bool TryGetFirst<T>(out T result) where T : UnityEngine.Object
		{
			if (TryGetAll(out ReadOnlySpan<T> result2))
			{
				result = result2[0];
				return true;
			}
			result = null;
			return false;
		}

		public static ReadOnlySpan<T> GetAll<T>() where T : UnityEngine.Object
		{
			if (!TryGetAll(out ReadOnlySpan<T> result))
			{
				return ReadOnlySpan<T>.Empty;
			}
			return result;
		}

		public static bool TryGetAll<T>(out ReadOnlySpan<T> result) where T : UnityEngine.Object
		{
			ValidateDictionaryCache();
			Type typeFromHandle = typeof(T);
			if (_dictionarizedTyped.TryGetValue(typeFromHandle, out var value))
			{
				result = new ReadOnlySpan<T>(value as T[]);
				return result.Length > 0;
			}
			if (!_dictionarizedRaw.TryGetValue(typeFromHandle, out var value2))
			{
				result = null;
				return false;
			}
			T[] array = new T[value2.Count];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = value2[i] as T;
			}
			_dictionarizedTyped[typeFromHandle] = array;
			result = new ReadOnlySpan<T>(array);
			return true;
		}

		private static void ValidateDictionaryCache()
		{
			if (_cacheSet)
			{
				return;
			}
			ResourcesTypePair[] resources = Resources.Load<FastResourcesDatabase>("FastResources/FastResources")._resources;
			_dictionarizedRaw = new Dictionary<Type, List<UnityEngine.Object>>(resources.Length);
			_dictionarizedTyped = new Dictionary<Type, object>(resources.Length);
			ResourcesTypePair[] array = resources;
			for (int i = 0; i < array.Length; i++)
			{
				ResourcesTypePair resourcesTypePair = array[i];
				Type type = Type.GetType(resourcesTypePair.TypeName);
				if (!_dictionarizedRaw.TryAdd(type, resourcesTypePair.Resources))
				{
					Debug.LogError("Fast resource type " + resourcesTypePair.TypeName + " already existed in dictionary.");
				}
			}
			_cacheSet = true;
		}
	}
}
