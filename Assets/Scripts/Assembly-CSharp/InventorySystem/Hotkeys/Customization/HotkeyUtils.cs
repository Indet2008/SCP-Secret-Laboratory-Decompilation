namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyUtils
	{
		private static readonly global::System.Collections.Generic.Dictionary<int, ItemType[]> ItemOrder;

		public static ItemType[] GetItemsByQueue(int hotkeyIndex)
		{
			return default;
		}

		public static ItemType[] GetItemsByQueue(this global::System.Collections.Generic.IEnumerable<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements)
		{
			return default;
		}

		public static void GetItemsByQueue(this global::System.Collections.Generic.IEnumerable<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements, global::System.Collections.Generic.List<ItemType> targetList)
		{
		}

		public static int CountMatches(this global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements, ItemType[] filters)
		{
			return default;
		}

		public static bool IsHotkeyable(this global::InventorySystem.Items.ItemBase item)
		{
			return default;
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}
	}
}
