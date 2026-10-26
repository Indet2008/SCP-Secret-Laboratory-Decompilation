using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class PoolElementIcon : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject[] _roots;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _specificItemIcon;

		[global::UnityEngine.SerializeField]
		private global::System.Collections.Generic.List<global::UnityEngine.RectTransform> _groupRows;

		[global::UnityEngine.SerializeField]
		private global::System.Collections.Generic.List<global::UnityEngine.UI.RawImage> _groupIcons;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _orderText;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _addElement;


	}
}
