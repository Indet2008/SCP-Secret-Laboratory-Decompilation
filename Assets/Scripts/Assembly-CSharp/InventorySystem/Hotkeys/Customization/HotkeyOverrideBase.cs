namespace InventorySystem.Hotkeys.Customization
{
	public abstract class HotkeyOverrideBase
	{
		public static readonly global::InventorySystem.Hotkeys.Customization.HotkeyOverrideBase[] Overrides;

		public abstract global::InventorySystem.Hotkeys.Customization.HotkeyOverrideOption OptionType
		{
			get;
		}

		public abstract global::InventorySystem.Hotkeys.HotkeysTranslation OptionName
		{
			get;
		}

		public abstract global::InventorySystem.Hotkeys.HotkeysTranslation? Description
		{
			get;
		}

		public abstract bool CheckAvailability(global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements);

		public abstract bool TryGetOverride(ReferenceHub player, int hotkeyId, global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> matches, out global::InventorySystem.Items.ItemBase result);

		protected HotkeyOverrideBase()
		{
		}
	}
}
