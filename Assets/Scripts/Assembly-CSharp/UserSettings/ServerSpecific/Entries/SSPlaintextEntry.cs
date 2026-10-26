using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UserSettings.GUIElements;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSPlaintextEntry : UserSettingsUIBase<TMP_InputField, string>, ISSEntry
	{
		private SSPlaintextSetting _setting;

		[SerializeField]
		private TMP_InputField _inputField;

		[SerializeField]
		private SSEntryLabel _label;

		[SerializeField]
		private TMP_Text _placeholder;

		protected override UnityEvent<string> OnValueChangedEvent => base.TargetUI.onEndEdit;

		public bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			return setting is SSPlaintextSetting;
		}

		public void Init(ServerSpecificSettingBase setting)
		{
			_setting = setting as SSPlaintextSetting;
			_setting.OnClearRequested += ClearField;
			_setting.OnTextUpdated += UpdateText;
			SSPlaintextSetting setting2 = _setting;
			setting2.OnSettingUpdate = (Action)Delegate.Combine(setting2.OnSettingUpdate, new Action(SettingUpdate));
			SettingUpdate();
			Setup();
			if (_setting.IsServerOnly)
			{
				UpdateText();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			base.TargetUI.onEndEdit.AddListener((string _) =>
			{
				EventSystem current = EventSystem.current;
				if (!current.alreadySelecting)
				{
					current.SetSelectedGameObject(null);
				}
			});
		}

		protected override void SaveValue(string val)
		{
			if (!_setting.IsServerOnly)
			{
				PlayerPrefsSl.Set(_setting.PlayerPrefsKey, val);
			}
			_setting.SyncInputText = val;
			_setting.ClientSendValue();
		}

		protected override string ReadSavedValue()
		{
			if (!_setting.IsServerOnly)
			{
				_setting.SyncInputText = PlayerPrefsSl.Get(_setting.PlayerPrefsKey, string.Empty);
			}
			return _setting.SyncInputText;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_setting != null)
			{
				_setting.OnClearRequested -= ClearField;
				_setting.OnTextUpdated -= UpdateText;
			}
		}

		protected override void SetValueAndTriggerEvent(string val)
		{
			_inputField.text = val;
		}

		protected override void SetValueWithoutNotify(string val)
		{
			_inputField.SetTextWithoutNotify(val);
		}

		private void SettingUpdate()
		{
			_label.Set(_setting);
			_placeholder.text = _setting.Placeholder;
			_inputField.contentType = _setting.ContentType;
			_inputField.characterLimit = _setting.CharacterLimit;
		}

		private void UpdateText()
		{
			SetValueWithoutNotify(_setting.SyncInputText);
		}

		private void ClearField()
		{
			if (!_inputField.isFocused)
			{
				SetValueAndTriggerEvent(string.Empty);
			}
		}
	}
}
