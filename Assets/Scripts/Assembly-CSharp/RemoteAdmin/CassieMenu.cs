using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Cassie;
using RemoteAdmin.Menus;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class CassieMenu : RaCommandMenu
	{
		[SerializeField]
		private Color _resetColor;

		[SerializeField]
		private Color _errorColor;

		[SerializeField]
		private TMP_Text[] _buttons;

		[SerializeField]
		private TMP_Text _pageCount;

		[SerializeField]
		private TMP_Text _elementCount;

		[SerializeField]
		private TMP_InputField _subtitleField;

		[SerializeField]
		private CustomSlider _pitchSlider;

		[SerializeField]
		private CustomSlider _jamDelaySlider;

		[SerializeField]
		private CustomSlider _jamStutterSlider;

		[SerializeField]
		private CustomSlider _yieldSlider;

		[SerializeField]
		private Button[] _subtitleButtonModes;

		private CassieTtsPayload.SubtitleMode _subtitleMode;

		private int _pageIndex;

		private readonly List<string> _words = new List<string>();

		private int PageSize
		{
			get
			{
				if (_buttons != null && _buttons.Length != 0)
				{
					return _buttons.Length;
				}
				return 1;
			}
		}

		private int PageCount => Mathf.Max(1, Mathf.CeilToInt((float)_words.Count / (float)PageSize));

		public void AddJam()
		{
			string text = ((_jamDelaySlider != null) ? Mathf.RoundToInt(_jamDelaySlider.value).ToString("000") : "043");
			string text2 = ((_jamStutterSlider != null) ? Mathf.RoundToInt(_jamStutterSlider.value).ToString() : "3");
			AddElement(".JAM_" + text + "_" + text2);
		}

		public void AddYield()
		{
			string text = ((_yieldSlider != null) ? Mathf.RoundToInt(_yieldSlider.value).ToString("00") : "01");
			AddElement(".YIELD_" + text);
		}

		public void AddPitch()
		{
			string text = ((_pitchSlider != null) ? _pitchSlider.value.ToString("0.00", CultureInfo.InvariantCulture) : "1.00");
			AddElement("PITCH_" + text);
		}

		public void ResetPages()
		{
			_pageIndex = 0;
			RefreshButtons();
		}

		public void JumpPages(int i = 1)
		{
			_pageIndex = (_pageIndex + i) % PageCount;
			if (_pageIndex < 0)
			{
				_pageIndex += PageCount;
			}
			RefreshButtons();
		}

		public void RefreshButtons()
		{
			if (_buttons != null)
			{
				for (int i = 0; i < _buttons.Length; i++)
				{
					int num = _pageIndex * PageSize + i;
					if (!(_buttons[i] == null))
					{
						_buttons[i].text = ((num < _words.Count) ? _words[num] : string.Empty);
					}
				}
			}
			UpdateCounters();
		}

		public void AddElement(string text)
		{
			if (!string.IsNullOrEmpty(text) && !(base.InputFieldText == null))
			{
				string text2 = base.InputFieldText.text ?? string.Empty;
				base.InputFieldText.text = ((text2.Length == 0 || text2.EndsWith(" ")) ? (text2 + text) : (text2 + " " + text));
			}
		}

		public void AddElement(TMP_Text text)
		{
			if (text != null)
			{
				AddElement(text.text);
			}
		}

		public void SendAnnouncement(bool playBackground)
		{
			string text = ((base.InputFieldText != null) ? base.InputFieldText.text : string.Empty);
			if (string.IsNullOrWhiteSpace(text))
			{
				SubmenuSelector.Singleton?.SelectedMenu?.SetResponse(_errorColor, "The announcement is empty.");
				return;
			}
			RemoteAdminClient.SendQuery((playBackground ? "cassie " : "cassie_silent ") + text.Trim());
		}

		public void TestCassie()
		{
			SendAnnouncement(playBackground: false);
		}

		public void CheckEasterEgg()
		{
			string text = InputFieldText.text;
			if (System.Globalization.CultureInfo.CurrentCulture.CompareInfo.IndexOf(text, "MRBOOBOOSTANK", 0, text.Length, System.Globalization.CompareOptions.IgnoreCase) >= 0)
			{
				InputFieldText.textComponent.color = UnityEngine.Color.green;
				InputFieldText.SetTextWithoutNotify("An incredibly well-made guide, useful to many in this community. Thank you, mrbooboostank! :)\nhttps://steamcommunity.com/sharedfiles/filedetails/?id=1577299753");
			}
		}

		public void CopyToClipboard()
		{
			if (base.InputFieldText != null)
			{
				GUIUtility.systemCopyBuffer = base.InputFieldText.text;
			}
		}

		protected override void OnStart()
		{
			_words.Clear();
			if (CassieTtsAnnouncer.TryGetDatabase(out var db) && db != null)
			{
				db.ValidateCache();
				if (db.AllLines != null)
				{
					_words.AddRange((from x in db.AllLines
						where x != null && !string.IsNullOrEmpty(x.ApiName)
						select x.ApiName.ToUpperInvariant()).Distinct().OrderBy((string x) => x));
				}
			}
			if (base.InputFieldText != null)
			{
				base.InputFieldText.onValueChanged.AddListener(OnValueChange);
			}
			if (_subtitleButtonModes != null)
			{
				Button[] subtitleButtonModes = _subtitleButtonModes;
				foreach (Button button in subtitleButtonModes)
				{
					if (button != null)
					{
						Button pressed = button;
						button.onClick.AddListener(delegate
						{
							OnSubtitleModeChanged(pressed);
						});
					}
				}
			}
			ResetPages();
		}

		private void UpdateCounters()
		{
			if (_pageCount != null)
			{
				_pageCount.text = _pageIndex + 1 + "/" + PageCount;
			}
			if (_elementCount != null)
			{
				int num = Mathf.Min(_words.Count, (_pageIndex + 1) * PageSize);
				_elementCount.text = num + "/" + _words.Count;
			}
		}

		private void OnValueChange(string newValue)
		{
			if (base.InputFieldText != null && base.InputFieldText.textComponent != null)
			{
				base.InputFieldText.textComponent.color = _resetColor;
			}
		}

		private void OnSubtitleModeChanged(Button pressedButton)
		{
			if (_subtitleButtonModes == null)
			{
				return;
			}
			for (int i = 0; i < _subtitleButtonModes.Length; i++)
			{
				if (_subtitleButtonModes[i] == pressedButton)
				{
					_subtitleMode = (CassieTtsPayload.SubtitleMode)i;
				}
			}
			if (_subtitleField != null)
			{
				_subtitleField.interactable = _subtitleButtonModes.Length > 1 && pressedButton == _subtitleButtonModes[1];
			}
		}

		private void OnDestroy()
		{
			if (base.InputFieldText != null)
			{
				base.InputFieldText.onValueChanged.RemoveListener(OnValueChange);
			}
		}
	}
}
