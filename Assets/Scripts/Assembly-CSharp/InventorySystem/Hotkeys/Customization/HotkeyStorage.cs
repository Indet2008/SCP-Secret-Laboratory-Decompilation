namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyStorage
	{
		private static global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.SavedHotkey> _loadedHotkeys;

		private const string PrefsKey = "CustomHotkeyDefinitions";

		private static readonly global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.SavedHotkey> DefaultHotkeys;

		[global::System.Runtime.CompilerServices.CompilerGenerated]
		private static global::System.Action m_OnHotkeysSaved;

		public static global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.SavedHotkey> Hotkeys
		{
			get
			{
				return default;
			}
		}

		public static event global::System.Action OnHotkeysSaved
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			add
			{
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			remove
			{
			}
		}

		public static void Save()
		{
		}

		public static void DeleteAll()
		{
		}
	}
}
