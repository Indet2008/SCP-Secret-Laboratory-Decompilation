namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyBestMedicalOverride : global::InventorySystem.Hotkeys.Customization.HotkeyOverrideBase
	{
		private static readonly global::System.Collections.Generic.List<ItemType> BestToWorst;

		private static readonly ItemType[] HandledItems;

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

		private void UpdateConditions(global::PlayerStatsSystem.PlayerStats stats, PlayerEffectsController effectsController)
		{
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> matches, out global::InventorySystem.Items.ItemBase result)
		{ result = default;
			return default;
		}

		public override bool CheckAvailability(global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements)
		{
			return default;
		}

		public HotkeyBestMedicalOverride()
		{
		}
	}
}
