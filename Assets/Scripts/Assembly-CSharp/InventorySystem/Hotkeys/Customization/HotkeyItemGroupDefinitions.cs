namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyItemGroupDefinitions
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup, CachedValue<ItemType[]>> Groups;

		private static readonly global::System.Collections.Generic.Dictionary<global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup, global::InventorySystem.Hotkeys.HotkeysTranslation> GroupToTranslation;

		private static readonly CachedValue<ItemType[]> EmptyFallback;

		public static ItemType[] GetItems(this global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup group)
		{
			return default;
		}

		public static string GetTranslation(this global::InventorySystem.Hotkeys.Customization.HotkeyItemGroup group)
		{
			return default;
		}

		private static ItemType[] AnyFirearm()
		{
			return default;
		}

		private static ItemType[] AnyKeycard()
		{
			return default;
		}

		private static ItemType[] FromCategory(ItemCategory cat)
		{
			return default;
		}

		private static ItemType[] ItemsOfTypeOrdered<TSource, TKey>(global::System.Func<TSource, TKey> keySelector) where TSource : global::InventorySystem.Items.ItemBase
		{
			return default;
		}
	}
}
