using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class ExperimentalWeaponLocker : Locker
	{
		[Serializable]
		private struct GlobalLimit
		{
			public ItemType ItemType;

			public int Limit;
		}

		private static readonly Dictionary<ItemType, int> GloballySpawned = new Dictionary<ItemType, int>();

		[SerializeField]
		private GlobalLimit[] _globalLimits;

		public override void FillChamber(LockerChamber ch)
		{
			List<ItemType> list = ListPool<ItemType>.Shared.Rent();
			LockerLoot[] loot = Loot;
			foreach (LockerLoot lockerLoot in loot)
			{
				if (ValidateUnderGlobalLimit(lockerLoot.TargetItem))
				{
					list.Add(lockerLoot.TargetItem);
				}
			}
			if (list.Count > 0)
			{
				ItemType itemType = list.RandomItem();
				IncrementGloballySpawned(itemType);
				ch.SpawnItem(itemType, 1);
			}
			ListPool<ItemType>.Shared.Return(list);
		}

		private bool ValidateUnderGlobalLimit(ItemType it)
		{
			GlobalLimit[] globalLimits = _globalLimits;
			for (int i = 0; i < globalLimits.Length; i++)
			{
				GlobalLimit globalLimit = globalLimits[i];
				if (globalLimit.ItemType == it)
				{
					return GloballySpawned.GetValueOrDefault(it) < globalLimit.Limit;
				}
			}
			return true;
		}

		private void IncrementGloballySpawned(ItemType it)
		{
			GloballySpawned[it] = GloballySpawned.GetValueOrDefault(it) + 1;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += GloballySpawned.Clear;
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
