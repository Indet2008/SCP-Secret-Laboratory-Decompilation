using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyPool : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rect _dragRect;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rect _deleteRect;

		[global::UnityEngine.SerializeField]
		private float _dragLerp;

		[global::UnityEngine.SerializeField]
		private float _heightLerp;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.Customization.PoolElementIcon _iconTemplate;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _dragIcon;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _deleteIcon;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _addNewElementWindow;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _poolRt;

		[global::UnityEngine.SerializeField]
		private float _gridCellSize;

		[global::UnityEngine.SerializeField]
		private float _poolHeightPadding;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.LayoutElement _poolHeightRect;


	}
}
