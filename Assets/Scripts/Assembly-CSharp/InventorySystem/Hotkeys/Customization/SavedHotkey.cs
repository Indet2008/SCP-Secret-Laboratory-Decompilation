namespace InventorySystem.Hotkeys.Customization
{
	[global::System.Serializable]
	public struct SavedHotkey
	{
		public string CustomName;

		public byte TranslationId;

		public global::UnityEngine.KeyCode AssignedKey;

		public global::InventorySystem.Hotkeys.Customization.HotkeyApperance Apperance;

		public global::InventorySystem.Hotkeys.Customization.HotkeySortMode SortMode;

		public global::InventorySystem.Hotkeys.Customization.HotkeyOverrideOption OverrideOption;

		public global::InventorySystem.Hotkeys.Customization.PoolElementData[] Elements;

		public readonly string DisplayName
		{
			get
			{
				return default;
			}
		}
	}
}
