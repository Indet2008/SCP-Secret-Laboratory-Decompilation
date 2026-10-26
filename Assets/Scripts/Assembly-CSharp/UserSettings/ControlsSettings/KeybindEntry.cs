using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.ControlsSettings
{
	public class KeybindEntry : KeycodeField
	{
		private ActionName _action;

		private KeyCode _key;

		[SerializeField]
		private TMP_Text _labelText;

		[SerializeField]
		private Image _undoImage;

		private const string LabelKey = "Keybinds";

		private static readonly ActionName[] BlacklistedLMBs = new ActionName[5]
		{
			ActionName.Inventory,
			ActionName.PlayerList,
			ActionName.CharacterInfo,
			ActionName.RemoteAdmin,
			ActionName.GameConsole
		};

		public void Init(ActionName action)
		{
			_action = action;
			_key = NewInput.GetKey(action);
			RefreshKey();
			NewInput.OnKeyModified += OnKeyModified;
			RefreshLabel();
			TranslationReader.OnTranslationsRefreshed += RefreshLabel;
			_undoImage.GetComponent<Button>().onClick.AddListener(() =>
			{
				NewInput.ChangeKeybind(_action, KeyCode.None);
			});
		}

		protected override bool ValidatePressedKey(KeyCode key)
		{
			if (key == KeyCode.Mouse0)
			{
				return !BlacklistedLMBs.Contains(_action);
			}
			return true;
		}

		protected override void ApplyPressedKey(KeyCode key)
		{
			base.ApplyPressedKey(key);
			NewInput.ChangeKeybind(_action, key);
		}

		private void OnDestroy()
		{
			NewInput.OnKeyModified -= OnKeyModified;
			TranslationReader.OnTranslationsRefreshed -= RefreshLabel;
		}

		private void RefreshLabel()
		{
			_labelText.text = TranslationReader.Get("Keybinds", (int)_action, _action.ToString());
		}

		private void RefreshKey()
		{
			SetDisplayedKey(_key);
			_undoImage.enabled = NewInput.DefaultKeybinds.TryGetValue(_action, out var value) && value != _key;
		}

		private void OnKeyModified(ActionName action, KeyCode key)
		{
			if (_action == action)
			{
				_key = key;
				RefreshKey();
			}
		}
	}
}
