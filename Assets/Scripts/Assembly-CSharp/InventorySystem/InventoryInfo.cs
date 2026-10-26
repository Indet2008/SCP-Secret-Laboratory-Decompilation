using System.Collections.Generic;
using InventorySystem.Items;

namespace InventorySystem
{
	public class InventoryInfo
	{
		public Dictionary<ushort, ItemBase> Items;

		public Dictionary<ItemType, ushort> ReserveAmmo;

		public InventoryInfo()
		{
			Items = new Dictionary<ushort, ItemBase>();
			ReserveAmmo = new Dictionary<ItemType, ushort>();
		}
	}
}
