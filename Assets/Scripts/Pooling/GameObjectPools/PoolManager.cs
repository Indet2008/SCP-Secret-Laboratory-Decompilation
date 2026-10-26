namespace GameObjectPools
{
	public class PoolManager : global::UnityEngine.MonoBehaviour
	{
		public static global::GameObjectPools.PoolManager Singleton;

		internal global::System.Collections.Generic.Dictionary<global::UnityEngine.GameObject, global::GameObjectPools.PoolObject> PoolObjectLookup = new global::System.Collections.Generic.Dictionary<global::UnityEngine.GameObject, global::GameObjectPools.PoolObject>();

		[global::UnityEngine.SerializeField]
		private global::System.Collections.Generic.List<global::GameObjectPools.Pool> objectPools;

		private global::System.Collections.Generic.Dictionary<global::UnityEngine.GameObject, global::GameObjectPools.Pool> _poolLookup = new global::System.Collections.Generic.Dictionary<global::UnityEngine.GameObject, global::GameObjectPools.Pool>();

		public void TryAddPool(global::GameObjectPools.PoolObject prefab)
		{
			if (!_poolLookup.ContainsKey(prefab.gameObject))
			{
				global::GameObjectPools.Pool pool = new global::GameObjectPools.Pool
				{
					Prefab = prefab
				};
				_poolLookup.Add(pool.Prefab.gameObject, pool);
				pool.Initialize();
			}
		}

		public bool TryGetPoolObject(global::UnityEngine.GameObject prefab, global::UnityEngine.Transform parent, out global::GameObjectPools.PoolObject poolObject, bool autoSetup = true)
		{
			if (!TryGetPoolObject(prefab, out poolObject, autoSetup: false))
			{
				return false;
			}
			poolObject.transform.SetParent(parent);
			if (autoSetup)
			{
				poolObject.SetupPoolObject();
			}
			return true;
		}

		public bool TryGetPoolObject(global::UnityEngine.GameObject prefab, global::UnityEngine.Transform parent, bool worldPositionStays, out global::GameObjectPools.PoolObject poolObject, bool autoSetup = true)
		{
			if (!TryGetPoolObject(prefab, out poolObject, autoSetup: false))
			{
				return false;
			}
			poolObject.transform.SetParent(parent, worldPositionStays);
			if (autoSetup)
			{
				poolObject.SetupPoolObject();
			}
			return true;
		}

		public bool TryGetPoolObject(global::UnityEngine.GameObject prefab, out global::GameObjectPools.PoolObject poolObject, bool autoSetup = true)
		{
			if (prefab == null)
			{
				poolObject = null;
				return false;
			}
			if (_poolLookup.TryGetValue(prefab, out var value))
			{
				if (!value.TryGetPoolableObject(out poolObject))
				{
					return false;
				}
				poolObject.gameObject.SetActive(value: true);
				if (autoSetup)
				{
					poolObject.SetupPoolObject();
				}
				return true;
			}
			poolObject = null;
			return false;
		}

		public bool TryReturnPoolObject(global::UnityEngine.GameObject poolGameObject)
		{
			if (poolGameObject == null || !PoolObjectLookup.TryGetValue(poolGameObject, out var value))
			{
				return false;
			}
			ReturnPoolObject(value);
			return true;
		}

		public void ReturnPoolObject(global::GameObjectPools.PoolObject poolObject)
		{
			poolObject.ReturnToPool();
		}

		public void ReturnAllPoolObjects()
		{
			foreach (global::System.Collections.Generic.KeyValuePair<global::UnityEngine.GameObject, global::GameObjectPools.PoolObject> item in PoolObjectLookup)
			{
				global::GameObjectPools.PoolObject value = item.Value;
				if (!(value == null) && !value.Pooled)
				{
					value.ReturnToPool();
				}
			}
		}

		public void RestartRound()
		{
			foreach (global::System.Collections.Generic.KeyValuePair<global::UnityEngine.GameObject, global::GameObjectPools.Pool> item in _poolLookup)
			{
				item.Value.RestartRound();
			}
		}

		private void Awake()
		{
			if (Singleton != null)
			{
				global::UnityEngine.Object.Destroy(this);
				return;
			}
			Singleton = this;
			global::UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			foreach (global::GameObjectPools.Pool objectPool in objectPools)
			{
				_poolLookup.Add(objectPool.Prefab.gameObject, objectPool);
				objectPool.Initialize();
			}
		}

		private void OnDestroy()
		{
			global::UnityEngine.Debug.LogWarning("--PoolManager - Average required pool objects per round--");
			foreach (global::System.Collections.Generic.KeyValuePair<global::UnityEngine.GameObject, global::GameObjectPools.Pool> item in _poolLookup)
			{
				item.Value.PrintDebug();
			}
			global::UnityEngine.Debug.LogWarning("--End of Log--");
		}
	}
}
