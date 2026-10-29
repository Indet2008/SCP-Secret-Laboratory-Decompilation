using System.Collections.Generic;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Modules;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeySkipEmptyFirearms : HotkeyOverrideBase
	{
		public override HotkeyOverrideOption OptionType => HotkeyOverrideOption.SkipEmptyFirearms;

		public override HotkeysTranslation OptionName => HotkeysTranslation.OverrideSkipEmpty;

		public override HotkeysTranslation? Description => HotkeysTranslation.OverrideSkipEmptyHint;

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result)
		{
			foreach (ItemBase match in matches)
			{
				if (match is Firearm firearm && firearm.GetTotalStoredAmmo() > 0)
				{
					result = firearm;
					return true;
				}
			}
			result = null;
			return false;
		}

		public override bool CheckAvailability(List<PoolElementData> elements)
		{
			return elements.CountMatches(HotkeyItemGroup.AnyFirearm.GetItems()) > 0;
		}

		private bool CheckAvailability(List<ItemType> items)
		{
			ItemType[] items2 = HotkeyItemGroup.AnyFirearm.GetItems();
			foreach (ItemType item in items)
			{
				if (System.Array.IndexOf(items2, item) >= 0)
				{
					return true;
				}
			}
			return false;
		}
	}
}
