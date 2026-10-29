using System;
using System.Collections.Generic;
using InventorySystem.GUI;
using InventorySystem.Hotkeys.Customization;
using InventorySystem.Items;
using UnityEngine;

namespace InventorySystem.Hotkeys
{
	public class HotkeyController : MonoBehaviour
	{
		public static bool AllowActivation
		{
			get
			{
				if (Cursor.visible || InventoryGuiController.InventoryVisible)
				{
					return false;
				}
				return InventoryGuiController.CanInventoryBeDisplayed();
			}
		}

		public static event Action<int, ItemBase> OnHotkeyTriggered;

		private void Awake()
		{
			HotkeyInterpreter.OnHotkeysRevalidated += OnUpdate;
		}

		private void OnDestroy()
		{
			HotkeyInterpreter.OnHotkeysRevalidated -= OnUpdate;
		}

		private void OnUpdate()
		{
			if (AllowActivation)
			{
				List<SavedHotkey> hotkeys = HotkeyStorage.Hotkeys;
				for (int i = 0; i < hotkeys.Count; i++)
				{
					ProcessHotkey(i, hotkeys[i]);
				}
			}
		}

		private void ProcessHotkey(int index, SavedHotkey sv)
		{
			if (HotkeyInterpreter.TryGetItem(index, out var ib) && Input.GetKeyDown(sv.AssignedKey) && ReferenceHub.TryGetLocalHub(out var hub))
			{
				hub.inventory.ClientSelectItem(ib.ItemSerial);
				HotkeyController.OnHotkeyTriggered?.Invoke(index, ib);
			}
		}
	}
}
