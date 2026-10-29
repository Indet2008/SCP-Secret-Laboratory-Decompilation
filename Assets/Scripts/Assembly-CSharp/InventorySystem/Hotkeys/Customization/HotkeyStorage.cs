using System;
using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public static class HotkeyStorage
	{
		private static List<SavedHotkey> _loadedHotkeys;

		private const string PrefsKey = "CustomHotkeyDefinitions";

		private static readonly List<SavedHotkey> DefaultHotkeys = new List<SavedHotkey>
		{
			new SavedHotkey
			{
				TranslationId = 3,
				AssignedKey = KeyCode.LeftControl,
				Apperance = HotkeyApperance.SmallIcon,
				SortMode = HotkeySortMode.ItemPoolOrder,
				OverrideOption = HotkeyOverrideOption.PrioritizeNearbyDoors,
				Elements = new PoolElementData[1]
				{
					new PoolElementData(HotkeyItemGroup.AnyKeycard)
				}
			},
			new SavedHotkey
			{
				TranslationId = 4,
				AssignedKey = KeyCode.Alpha1,
				Apperance = HotkeyApperance.NormalIcon,
				SortMode = HotkeySortMode.InventoryOrder,
				OverrideOption = HotkeyOverrideOption.NoOverride,
				Elements = new PoolElementData[2]
				{
					new PoolElementData(HotkeyItemGroup.AnyFirearm),
					new PoolElementData(0)
				}
			},
			new SavedHotkey
			{
				TranslationId = 5,
				AssignedKey = KeyCode.Alpha2,
				Apperance = HotkeyApperance.NormalIcon,
				SortMode = HotkeySortMode.InventoryOrder,
				OverrideOption = HotkeyOverrideOption.NoOverride,
				Elements = new PoolElementData[4]
				{
					new PoolElementData(HotkeyItemGroup.AnyFirearm),
					new PoolElementData(1),
					new PoolElementData(2),
					new PoolElementData(3)
				}
			},
			new SavedHotkey
			{
				TranslationId = 6,
				AssignedKey = KeyCode.X,
				Apperance = HotkeyApperance.SmallIcon,
				SortMode = HotkeySortMode.ItemPoolOrder,
				OverrideOption = HotkeyOverrideOption.RememberPrevious,
				Elements = new PoolElementData[4]
				{
					new PoolElementData(ItemType.SCP500),
					new PoolElementData(ItemType.Adrenaline),
					new PoolElementData(ItemType.Medkit),
					new PoolElementData(ItemType.Painkillers)
				}
			},
			new SavedHotkey
			{
				TranslationId = 7,
				AssignedKey = KeyCode.G,
				Apperance = HotkeyApperance.SmallIcon,
				SortMode = HotkeySortMode.ItemPoolOrder,
				OverrideOption = HotkeyOverrideOption.RememberPrevious,
				Elements = new PoolElementData[1]
				{
					new PoolElementData(HotkeyItemGroup.AnyThrowable)
				}
			}
		};

		public static List<SavedHotkey> Hotkeys
		{
			get
			{
				if (_loadedHotkeys != null)
				{
					return _loadedHotkeys;
				}
				if (!PlayerPrefsSl.HasKey("CustomHotkeyDefinitions", PlayerPrefsSl.DataType.StringArray))
				{
					_loadedHotkeys = new List<SavedHotkey>(DefaultHotkeys);
					return _loadedHotkeys;
				}
				_loadedHotkeys = new List<SavedHotkey>();
				string[] array = PlayerPrefsSl.Get("CustomHotkeyDefinitions", new string[0]);
				foreach (string json in array)
				{
					_loadedHotkeys.Add(JsonUtility.FromJson<SavedHotkey>(json));
				}
				return _loadedHotkeys;
			}
		}

		public static event Action OnHotkeysSaved;

		public static void Save()
		{
			List<string> list = new List<string>();
			foreach (SavedHotkey hotkey in Hotkeys)
			{
				list.Add(JsonUtility.ToJson(hotkey));
			}
			PlayerPrefsSl.Set("CustomHotkeyDefinitions", list.ToArray());
			HotkeyStorage.OnHotkeysSaved?.Invoke();
		}

		public static void DeleteAll()
		{
			PlayerPrefsSl.DeleteKey("CustomHotkeyDefinitions", PlayerPrefsSl.DataType.StringArray);
			_loadedHotkeys = null;
			HotkeyStorage.OnHotkeysSaved?.Invoke();
		}
	}
}
