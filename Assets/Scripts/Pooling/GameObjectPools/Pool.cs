namespace GameObjectPools
{
	[global::System.Serializable]
	internal class Pool
	{
		internal enum OverflowModes
		{
			RecycleOldPrefab = 0,
			DoNotSpawnPrefab = 1,
			CreateMorePrefabs = 2
		}

		[global::UnityEngine.SerializeField]
		internal global::GameObjectPools.PoolObject Prefab;

		private global::System.Collections.Generic.Stack<global::GameObjectPools.PoolObject> _pool = new global::System.Collections.Generic.Stack<global::GameObjectPools.PoolObject>();

		private global::System.Collections.Generic.Queue<global::GameObjectPools.PoolObject> _spawnQueue = new global::System.Collections.Generic.Queue<global::GameObjectPools.PoolObject>();

		private global::UnityEngine.Transform parentTransform;

		private int _currentMax;

		private global::System.Collections.Generic.List<int> _maxEachRound = new global::System.Collections.Generic.List<int>();

		private global::GameObjectPools.Pool.OverflowModes OverflowMode => Prefab.OverflowMode;

		private void AddNewPrefabToPool()
		{
			_pool.Push(SpawnObject());
		}

		internal void Initialize()
		{
			parentTransform = new global::UnityEngine.GameObject(Prefab.name).transform;
			parentTransform.SetParent(global::GameObjectPools.PoolManager.Singleton.transform, worldPositionStays: false);
			for (int i = 0; i < Prefab.InitialPoolSize; i++)
			{
				AddNewPrefabToPool();
			}
		}

		internal bool TryGetPoolableObject(out global::GameObjectPools.PoolObject poolableObject)
		{
			while (_pool.Count > 0)
			{
				poolableObject = _pool.Pop();
				if (poolableObject == null)
				{
					global::UnityEngine.Debug.LogError("Object Pooling: Found null object in " + parentTransform.gameObject.name + " pool.");
					AddNewPrefabToPool();
					continue;
				}
				if (OverflowMode == global::GameObjectPools.Pool.OverflowModes.RecycleOldPrefab)
				{
					_spawnQueue.Enqueue(poolableObject);
				}
				return true;
			}
			switch (OverflowMode)
			{
			case global::GameObjectPools.Pool.OverflowModes.RecycleOldPrefab:
				while (_spawnQueue.Count > 0)
				{
					poolableObject = _spawnQueue.Dequeue();
					if (poolableObject == null)
					{
						global::UnityEngine.Debug.LogError("Object Pooling: Found null object in " + parentTransform.gameObject.name + " pool.");
						AddNewPrefabToPool();
						continue;
					}
					_spawnQueue.Enqueue(poolableObject);
					ResetObject(poolableObject);
					return true;
				}
				poolableObject = null;
				return false;
			case global::GameObjectPools.Pool.OverflowModes.DoNotSpawnPrefab:
				poolableObject = null;
				return false;
			case global::GameObjectPools.Pool.OverflowModes.CreateMorePrefabs:
				poolableObject = SpawnObject();
				return true;
			default:
				poolableObject = null;
				return false;
			}
		}

		internal void ReturnObject(global::GameObjectPools.PoolObject poolableObject)
		{
			if (!(poolableObject == null))
			{
				ResetObject(poolableObject);
				_pool.Push(poolableObject);
			}
		}

		private void ResetObject(global::GameObjectPools.PoolObject poolableObject)
		{
			global::UnityEngine.GameObject gameObject = poolableObject.gameObject;
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(parentTransform, worldPositionStays: false);
			poolableObject.ResetPoolObject();
		}

		internal void RestartRound()
		{
			if (_currentMax != 0)
			{
				_maxEachRound.Add(_currentMax);
			}
			_currentMax = 0;
		}

		internal void PrintDebug()
		{
			if (OverflowMode == global::GameObjectPools.Pool.OverflowModes.CreateMorePrefabs || _maxEachRound.Count == 0)
			{
				return;
			}
			float num = 0f;
			float num2 = 0f;
			foreach (int item in _maxEachRound)
			{
				num2 += (float)item;
				if ((float)item > num)
				{
					num = item;
				}
			}
			num2 /= (float)_maxEachRound.Count;
			num2 = (float)(int)(num2 * 100f) * 0.01f;
			global::UnityEngine.Debug.LogWarning($"{parentTransform.gameObject.name}: Initial Size: {Prefab.InitialPoolSize} | Average Used: {num2} | Max Used: {num}");
		}

		private global::GameObjectPools.PoolObject SpawnObject()
		{
			global::GameObjectPools.PoolObject component = global::UnityEngine.Object.Instantiate(Prefab.gameObject, parentTransform).GetComponent<global::GameObjectPools.PoolObject>();
			global::GameObjectPools.PoolManager.Singleton.PoolObjectLookup.Add(component.gameObject, component);
			component.gameObject.SetActive(value: false);
			component.InitializePoolObject(this);
			return component;
		}
	}
}
