using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyCustomizer : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _titleField;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_InputField _nameInputField;

		[global::UnityEngine.SerializeField]
		private KeycodeField _keycodeField;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Dropdown _apperance;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Dropdown _sortMode;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.Customization.HotkeyPool _itemPool;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.Customization.HotkeyPool _orderPool;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Dropdown _overrideOption;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.HotkeysTranslation[] _sortModeTranslations;


	}
}
