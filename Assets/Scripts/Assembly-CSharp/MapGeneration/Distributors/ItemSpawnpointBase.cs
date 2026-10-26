using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using UnityEngine;
using UnityEngine.Serialization;

namespace MapGeneration.Distributors
{
	public abstract class ItemSpawnpointBase : DistributorSpawnpointBase
	{
		public static readonly HashSet<ItemSpawnpointBase> Instances = new HashSet<ItemSpawnpointBase>();

		public string TriggerDoorName;

		[Min(1f)]
		[FormerlySerializedAs("_maxUses")]
		public int MaxUses = 1;

		[Range(0f, 100f)]
		public int SpawnEmptyChance;

		public abstract bool TryGeneratePickup(out ItemPickupBase pickup);

		protected virtual void Start()
		{
			Instances.Add(this);
		}

		protected virtual void OnDestroy()
		{
			Instances.Remove(this);
		}
	}
}
