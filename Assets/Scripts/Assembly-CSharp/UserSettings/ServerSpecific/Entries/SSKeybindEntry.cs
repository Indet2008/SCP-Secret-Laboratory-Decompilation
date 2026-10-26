using System;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSKeybindEntry : KeycodeField, ISSEntry
	{
		private SSKeybindSetting _setting;

		[SerializeField]
		private Image _undoImage;

		[SerializeField]
		private Image _suggestionImage;

		[SerializeField]
		private SSEntryLabel _label;

		public void ApplySuggestion()
		{
			ApplyPressedKey(_setting.SuggestedKey);
		}

		public bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			return setting is SSKeybindSetting;
		}

		public void Init(ServerSpecificSettingBase setting)
		{
			_setting = setting as SSKeybindSetting;
			_label.Set(setting);
			_undoImage.GetComponent<Button>().onClick.AddListener(PressUndo);
			_suggestionImage.GetComponent<Button>().onClick.AddListener(ApplySuggestion);
			ApplyPressedKey((KeyCode)PlayerPrefsSl.Get(_setting.PlayerPrefsKey, 0));
			SSKeybindSetting setting2 = _setting;
			setting2.OnSettingUpdate = (Action)Delegate.Combine(setting2.OnSettingUpdate, new Action(SettingUpdated));
		}

		protected override void ApplyPressedKey(KeyCode key)
		{
			base.ApplyPressedKey(key);
			_setting.AssignedKeyCode = key;
			PlayerPrefsSl.Set(_setting.PlayerPrefsKey, (int)key);
			_undoImage.enabled = key != KeyCode.None;
			_suggestionImage.enabled = key == KeyCode.None && _setting.SuggestedKey != KeyCode.None;
		}

		protected void OnDestroy()
		{
			if (_setting != null)
			{
				SSKeybindSetting setting = _setting;
				setting.OnSettingUpdate = (Action)Delegate.Remove(setting.OnSettingUpdate, new Action(SettingUpdated));
			}
		}

		private void PressUndo()
		{
			ApplyPressedKey(KeyCode.None);
		}

		private void SettingUpdated()
		{
			_label.Set(_setting);
		}
	}
}
