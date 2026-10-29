namespace GameObjectPools
{
	public class PoolObject : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.SerializeField]
		internal int InitialPoolSize = 10;

		[global::UnityEngine.SerializeField]
		internal global::GameObjectPools.Pool.OverflowModes OverflowMode = global::GameObjectPools.Pool.OverflowModes.CreateMorePrefabs;

		private global::GameObjectPools.IPoolResettable[] _poolResetables;

		private global::GameObjectPools.IPoolSpawnable[] _poolSpawnables;

		public bool Pooled { get; set; } = true;

		public bool DetachedFromPool { get; set; }

		private global::GameObjectPools.Pool _myPool { get; set; }

		public void ReturnToPool(bool checkChildren = true)
		{
			if (Pooled || DetachedFromPool)
			{
				return;
			}
			if (_myPool == null)
			{
				global::UnityEngine.Debug.LogError(base.gameObject.name + " does not have an initialized pool.");
			}
			else if (checkChildren)
			{
				global::GameObjectPools.PoolObject[] componentsInChildren = GetComponentsInChildren<global::GameObjectPools.PoolObject>();
				for (int num = componentsInChildren.Length - 1; num >= 0; num--)
				{
					componentsInChildren[num].ReturnToPool(checkChildren: false);
				}
			}
			else
			{
				Pooled = true;
				_myPool.ReturnObject(this);
			}
		}

		protected virtual void OnInstantiated()
		{
		}

		internal void InitializePoolObject(global::GameObjectPools.Pool poolOwner)
		{
			_myPool = poolOwner;
			_poolResetables = GetComponentsInChildren<global::GameObjectPools.IPoolResettable>();
			_poolSpawnables = GetComponentsInChildren<global::GameObjectPools.IPoolSpawnable>();
			OnInstantiated();
		}

		public void ResetPoolObject()
		{
			global::GameObjectPools.IPoolResettable[] poolResetables = _poolResetables;
			for (int i = 0; i < poolResetables.Length; i++)
			{
				poolResetables[i].ResetObject();
			}
		}

		public void SetupPoolObject()
		{
			Pooled = false;
			global::GameObjectPools.IPoolSpawnable[] poolSpawnables = _poolSpawnables;
			for (int i = 0; i < poolSpawnables.Length; i++)
			{
				// One failing spawnable used to abort the loop, leaving every later component
				// (subroutines, hume shield, ...) without an owner and throwing every frame.
				try
				{
					poolSpawnables[i].SpawnObject();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, poolSpawnables[i] as global::UnityEngine.Object);
				}
			}
		}
	}
}
