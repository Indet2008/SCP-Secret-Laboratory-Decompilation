namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyRememberPreviousOverride : global::InventorySystem.Hotkeys.Customization.HotkeyOverrideBase
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::UnityEngine.KeyCode, ushort> PrevItems;

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

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}

		public override bool CheckAvailability(global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements)
		{
			return default;
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> matches, out global::InventorySystem.Items.ItemBase result)
		{ result = default;
			return default;
		}

		public HotkeyRememberPreviousOverride()
		{
		}
	}
}
