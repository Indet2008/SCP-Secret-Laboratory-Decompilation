namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeySkipEmptyFirearms : global::InventorySystem.Hotkeys.Customization.HotkeyOverrideBase
	{
		public override global::InventorySystem.Hotkeys.Customization.HotkeyOverrideOption OptionType
		{
			get
			{
				return default;
			}
		}

		public override global::InventorySystem.Hotkeys.HotkeysTranslation OptionName
		{
			get
			{
				return default;
			}
		}

		public override global::InventorySystem.Hotkeys.HotkeysTranslation? Description
		{
			get
			{
				return default;
			}
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> matches, out global::InventorySystem.Items.ItemBase result)
		{ result = default;
			return default;
		}

		public override bool CheckAvailability(global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements)
		{
			return default;
		}

		private bool CheckAvailability(global::System.Collections.Generic.List<ItemType> items)
		{
			return default;
		}

		public HotkeySkipEmptyFirearms()
		{
		}
	}
}
