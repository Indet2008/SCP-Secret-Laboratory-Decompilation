using UnityEngine;

namespace InventorySystem.Hotkeys
{
	public abstract class HotkeyIconBase : MonoBehaviour
	{
		private class HighlightHandler
		{
			public bool IsPlaying;

			public float Timer;

			public HighlightHandler()
			{
			}
		}

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		protected global::UnityEngine.UI.Image Outline;

		[global::UnityEngine.SerializeField]
		protected global::UnityEngine.UI.Image HighlightImage;

		[global::UnityEngine.SerializeField]
		protected global::TMPro.TextMeshProUGUI KeycodeText;


	}
}
