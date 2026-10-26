using System.Collections.Generic;
using InventorySystem.Configs;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Armor
{
	public static class BodyArmorUtils
	{
		private static readonly HashSet<ReferenceHub> DirtyArmorPlayers = new HashSet<ReferenceHub>();

		private static readonly HashSet<ushort> ItemsToRemoveNonAlloc = new HashSet<ushort>();

		private static readonly Dictionary<ItemCategory, int> CategoryCounterNonAlloc = new Dictionary<ItemCategory, int>();

		private static readonly Dictionary<ItemType, ushort> AmmoToRemoveNonAlloc = new Dictionary<ItemType, ushort>();

		public static void SetPlayerDirty(ReferenceHub player)
		{
			DirtyArmorPlayers.Add(player);
		}

		public static bool TryGetBodyArmor(this Inventory inv, out BodyArmor bodyArmor)
		{
			foreach (KeyValuePair<ushort, ItemBase> item in inv.UserInventory.Items)
			{
				if (item.Value is BodyArmor bodyArmor2)
				{
					bodyArmor = bodyArmor2;
					return true;
				}
			}
			bodyArmor = null;
			return false;
		}

		public static float ProcessDamage(int efficacy, float baseDamage, int bulletPenetrationPercent)
		{
			float num = (float)efficacy / 100f;
			float num2 = (float)bulletPenetrationPercent / 100f;
			return baseDamage * (1f - num * (1f - num2));
		}

		public static void RemoveEverythingExceedingLimits(this Inventory inv)
		{
			ItemsToRemoveNonAlloc.Clear();
			CategoryCounterNonAlloc.Clear();
			AmmoToRemoveNonAlloc.Clear();
			HashSet<ushort> itemsToRemoveNonAlloc = ItemsToRemoveNonAlloc;
			Dictionary<ItemCategory, int> categoryCounterNonAlloc = CategoryCounterNonAlloc;
			Dictionary<ItemType, ushort> ammoToRemoveNonAlloc = AmmoToRemoveNonAlloc;
			inv.TryGetBodyArmor(out var bodyArmor);
			foreach (KeyValuePair<ushort, ItemBase> item in inv.UserInventory.Items)
			{
				if (!item.Value.CountsTowardsCategoryLimit)
				{
					continue;
				}
				ItemCategory category = item.Value.Category;
				if (category != ItemCategory.Armor)
				{
					int num = Mathf.Abs(InventoryLimits.GetCategoryLimit(bodyArmor, category));
					int num2 = 1 + categoryCounterNonAlloc.GetValueOrDefault(category);
					if (num2 > num)
					{
						itemsToRemoveNonAlloc.Add(item.Key);
					}
					categoryCounterNonAlloc[category] = num2;
				}
			}
			foreach (KeyValuePair<ItemType, ushort> item2 in inv.UserInventory.ReserveAmmo)
			{
				ushort ammoLimit = InventoryLimits.GetAmmoLimit(bodyArmor, item2.Key);
				if (item2.Value > ammoLimit)
				{
					ammoToRemoveNonAlloc.Add(item2.Key, (ushort)(item2.Value - ammoLimit));
				}
			}
			foreach (ushort item3 in itemsToRemoveNonAlloc)
			{
				inv.ServerDropItem(item3);
			}
			foreach (KeyValuePair<ItemType, ushort> item4 in ammoToRemoveNonAlloc)
			{
				inv.ServerDropAmmo(item4.Key, item4.Value);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnLateUpdate += UpdateDirty;
		}

		private static void UpdateDirty()
		{
			if (DirtyArmorPlayers.Count == 0)
			{
				return;
			}
			if (NetworkServer.active)
			{
				foreach (ReferenceHub dirtyArmorPlayer in DirtyArmorPlayers)
				{
					if (!(dirtyArmorPlayer == null))
					{
						dirtyArmorPlayer.inventory.RemoveEverythingExceedingLimits();
					}
				}
			}
			DirtyArmorPlayers.Clear();
		}
	}
}
