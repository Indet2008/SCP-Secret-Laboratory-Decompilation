using System;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	[Serializable]
	public struct SavedHotkey
	{
		public string CustomName;

		public byte TranslationId;

		public KeyCode AssignedKey;

		public HotkeyApperance Apperance;

		public HotkeySortMode SortMode;

		public HotkeyOverrideOption OverrideOption;

		public PoolElementData[] Elements;

		public readonly string DisplayName
		{
			get
			{
				if (!string.IsNullOrWhiteSpace(CustomName))
				{
					return CustomName;
				}
				return Translations.Get((HotkeysTranslation)TranslationId);
			}
		}
	}
}
