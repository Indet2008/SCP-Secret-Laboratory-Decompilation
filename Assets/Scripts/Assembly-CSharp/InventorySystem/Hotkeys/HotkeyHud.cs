using UnityEngine;

namespace InventorySystem.Hotkeys
{
	public class HotkeyHud : MonoBehaviour
	{
		private struct HotkeyToDisplay
		{
			public global::InventorySystem.Items.ItemBase Item;

			public global::InventorySystem.Hotkeys.Customization.HotkeyApperance Apperance;

			public global::UnityEngine.KeyCode Key;

			public bool IsNew;
		}

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.CanvasGroup _fadeGroup;

		[global::UnityEngine.SerializeField]
		private global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.HotkeyIconBase> _iconTemplates;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _iconParent;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _ellipsisIndicator;

		[global::UnityEngine.SerializeField]
		private float _spacing;

		[global::UnityEngine.SerializeField]
		private float _maxWidth;


	}
}
