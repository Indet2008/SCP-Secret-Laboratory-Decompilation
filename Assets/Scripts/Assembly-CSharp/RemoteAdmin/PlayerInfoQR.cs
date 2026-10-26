using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	internal class PlayerInfoQR : MonoBehaviour
	{
		private const int Size = 125;

		public RawImage QrDisplay;

		private static PlayerInfoQR _singleton;

		private static Texture2D _emptyCode;

		private static Texture2D _lastCode;

		public void OnEnable()
		{
			_singleton = this;
		}

		public static void Display(string content)
		{
			if (!(_singleton == null) && !(_singleton.QrDisplay == null))
			{
				if (_lastCode != null)
				{
					Object.Destroy(_lastCode);
				}
				_lastCode = QrTextureUtility.Create(content, Size);
				_singleton.QrDisplay.enabled = true;
				_singleton.QrDisplay.texture = _lastCode;
			}
		}

		public static void Clear()
		{
			if (!(_singleton == null) && !(_singleton.QrDisplay == null))
			{
				if (_emptyCode == null)
				{
					_emptyCode = QrTextureUtility.Create(null, Size);
				}
				_singleton.QrDisplay.texture = _emptyCode;
			}
		}
	}
}