using System.Collections.Generic;
using InventorySystem.Items;

namespace InventorySystem.Hotkeys.Customization
{
	public abstract class HotkeyOverrideBase
	{
		public static readonly HotkeyOverrideBase[] Overrides = new HotkeyOverrideBase[5]
		{
			new HotkeyNoneOverride(),
			new HotkeyRememberPreviousOverride(),
			new HotkeyBestMedicalOverride(),
			new HotkeyNearbyDoorOverride(),
			new HotkeySkipEmptyFirearms()
		};

		public abstract HotkeyOverrideOption OptionType { get; }

		public abstract HotkeysTranslation OptionName { get; }

		public abstract HotkeysTranslation? Description { get; }

		public abstract bool CheckAvailability(List<PoolElementData> elements);

		public abstract bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result);
	}
}
