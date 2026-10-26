namespace InventorySystem.Hotkeys
{
	public class FirearmHotkeyIcon : HotkeyIconBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _rootIcon;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage[] _attachmentsPool;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _transformToFit;

		[global::UnityEngine.SerializeField]
		private float _horizontalPadding;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Vector2 _maxSize;


	}
}
