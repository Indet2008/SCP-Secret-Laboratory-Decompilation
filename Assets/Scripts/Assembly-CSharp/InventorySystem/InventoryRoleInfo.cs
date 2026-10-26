using System.Collections.Generic;

namespace InventorySystem
{
	public readonly struct InventoryRoleInfo
	{
		public readonly ItemType[] Items;

		public readonly Dictionary<ItemType, ushort> Ammo;

		public InventoryRoleInfo(ItemType[] items, Dictionary<ItemType, ushort> ammo)
		{
			Items = items;
			Ammo = ammo;
		}
	}
}
