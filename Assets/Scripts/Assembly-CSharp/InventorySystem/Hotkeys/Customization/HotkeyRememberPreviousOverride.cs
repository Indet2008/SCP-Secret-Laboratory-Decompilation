using System.Collections.Generic;
using InventorySystem.Items;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyRememberPreviousOverride : HotkeyOverrideBase
	{
		private static readonly Dictionary<KeyCode, ushort> PrevItems = new Dictionary<KeyCode, ushort>();

		public override HotkeyOverrideOption OptionType => HotkeyOverrideOption.RememberPrevious;

		public override HotkeysTranslation OptionName => HotkeysTranslation.OverrideRememberPrev;

		public override HotkeysTranslation? Description => HotkeysTranslation.OverrideRememberPrevHint;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnLocalClientStarted += PrevItems.Clear;
			HotkeyStorage.OnHotkeysSaved += PrevItems.Clear;
			HotkeyController.OnHotkeyTriggered += delegate(int index, ItemBase item)
			{
				List<SavedHotkey> hotkeys = HotkeyStorage.Hotkeys;
				if (index < hotkeys.Count && item != null)
				{
					PrevItems[hotkeys[index].AssignedKey] = item.ItemSerial;
				}
			};
		}

		public override bool CheckAvailability(List<PoolElementData> elements)
		{
			return elements.CountMatches(elements.GetItemsByQueue()) > 1;
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result)
		{
			KeyCode assignedKey = HotkeyStorage.Hotkeys[hotkeyId].AssignedKey;
			if (PrevItems.TryGetValue(assignedKey, out var value) && player.inventory.UserInventory.Items.TryGetValue(value, out result))
			{
				return true;
			}
			result = null;
			return false;
		}
	}
}
