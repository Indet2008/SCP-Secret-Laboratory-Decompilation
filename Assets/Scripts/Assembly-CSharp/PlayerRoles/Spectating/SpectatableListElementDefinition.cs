using System;
using GameObjectPools;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	[Serializable]
	public struct SpectatableListElementDefinition
	{
		public SpectatableListElementType Type;

		public SpectatableListElementBase FullSize;

		public SpectatableListElementBase Compact;

		public bool TryGetFromPools(Transform parent, out SpectatableListElementBase full, out SpectatableListElementBase compact)
		{
			if (TrySpawn(parent, FullSize, out full) && TrySpawn(parent, Compact, out compact))
			{
				return true;
			}
			full = null;
			compact = null;
			return false;
		}

		private bool TrySpawn(Transform parent, SpectatableListElementBase template, out SpectatableListElementBase instance)
		{
			if (PoolManager.Singleton.TryGetPoolObject(template.gameObject, parent, out var poolObject))
			{
				instance = poolObject as SpectatableListElementBase;
				return true;
			}
			instance = null;
			return false;
		}
	}
}
