using System;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class PrecisionLockerChamber : LockerChamber
	{
		[Serializable]
		private struct SpawnpointOverride
		{
			public ItemType[] AcceptedItemTypes;

			public Transform Spawnpoint;
		}

		[SerializeField]
		private SpawnpointOverride[] _spawnpointOverrides;

		protected override void GetSpawnpoint(ItemType itemType, int index, out Vector3 worldPosition, out Quaternion worldRotation, out Transform parent)
		{
			SpawnpointOverride[] spawnpointOverrides = _spawnpointOverrides;
			for (int i = 0; i < spawnpointOverrides.Length; i++)
			{
				SpawnpointOverride spawnpointOverride = spawnpointOverrides[i];
				if (spawnpointOverride.AcceptedItemTypes.Contains(itemType))
				{
					parent = spawnpointOverride.Spawnpoint;
					spawnpointOverride.Spawnpoint.GetPositionAndRotation(out worldPosition, out worldRotation);
					return;
				}
			}
			base.GetSpawnpoint(itemType, index, out worldPosition, out worldRotation, out parent);
		}
	}
}
