using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class LargeDataPrinter : MonoBehaviour
	{
		private const int Size = 700;

		private const float DisplayDuration = 30f;

		public GameObject Panel;

		public RawImage QrDisplay;

		public TMP_Text TimeDisplay;

		private static LargeDataPrinter _singleton;

		private Texture2D _texture;

		private float _remaining;

		private void Awake()
		{
			_singleton = this;
		}

		private void Update()
		{
			if (Panel == null || !Panel.activeSelf)
			{
				return;
			}
			_remaining -= Time.unscaledDeltaTime;
			if (TimeDisplay != null)
			{
				TimeDisplay.text = Mathf.CeilToInt(Mathf.Max(0f, _remaining)).ToString();
			}
			if (_remaining <= 0f || Input.GetKeyDown(KeyCode.Escape))
			{
				Hide();
			}
		}

		public static void Display(string content, bool replaceToBr)
		{
			if (!(_singleton == null))
			{
				if (replaceToBr)
				{
					content = content.Replace("\n", "<br>");
				}
				if (_singleton._texture != null)
				{
					UnityEngine.Object.Destroy(_singleton._texture);
				}
				_singleton._texture = QrTextureUtility.Create(content, Size);
				if (_singleton.QrDisplay != null)
				{
					_singleton.QrDisplay.texture = _singleton._texture;
				}
				_singleton._remaining = DisplayDuration;
				if (_singleton.Panel != null)
				{
					_singleton.Panel.SetActive(value: true);
				}
			}
		}

		public static void Hide()
		{
			if (_singleton != null && _singleton.Panel != null)
			{
				_singleton.Panel.SetActive(value: false);
			}
		}
	}
}