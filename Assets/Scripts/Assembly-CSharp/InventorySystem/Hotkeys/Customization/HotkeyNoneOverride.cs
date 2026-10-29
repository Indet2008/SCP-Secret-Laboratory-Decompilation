using System.Collections.Generic;
using InventorySystem.Items;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyNoneOverride : HotkeyOverrideBase
	{
		public override HotkeyOverrideOption OptionType => HotkeyOverrideOption.NoOverride;

		public override HotkeysTranslation OptionName => HotkeysTranslation.OverrideNone;

		public override HotkeysTranslation? Description => null;

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result)
		{
			result = null;
			return false;
		}

		public override bool CheckAvailability(List<PoolElementData> elements)
		{
			return true;
		}
	}
}
