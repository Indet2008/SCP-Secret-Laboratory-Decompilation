using System;
using TMPro;
using UnityEngine;
using UserSettings.GUIElements;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSTwoButtonsEntry : UserSettingsTwoButtons, ISSEntry
	{
		private SSTwoButtonsSetting _setting;

		[SerializeField]
		private TMP_Text _optionA;

		[SerializeField]
		private TMP_Text _optionB;

		[SerializeField]
		private SSEntryLabel _label;

		protected override void SaveValue(bool val)
		{
			if (!_setting.IsServerOnly)
			{
				PlayerPrefsSl.Set(_setting.PlayerPrefsKey, val);
			}
			_setting.SyncIsB = val;
			_setting.ClientSendValue();
		}

		protected override bool ReadSavedValue()
		{
			if (!_setting.IsServerOnly)
			{
				_setting.SyncIsB = PlayerPrefsSl.Get(_setting.PlayerPrefsKey, _setting.DefaultIsB);
			}
			return _setting.SyncIsB;
		}

		public bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			return setting is SSTwoButtonsSetting;
		}

		public void Init(ServerSpecificSettingBase setting)
		{
			_setting = setting as SSTwoButtonsSetting;
			SettingUpdated();
			Setup();
			if (_setting.IsServerOnly)
			{
				UpdateValue();
			}
			UpdateColors(instant: true);
			SSTwoButtonsSetting setting2 = _setting;
			setting2.OnSettingUpdate = (Action)Delegate.Combine(setting2.OnSettingUpdate, new Action(SettingUpdated));
			SSTwoButtonsSetting setting3 = _setting;
			setting3.OnValueUpdated = (Action)Delegate.Combine(setting3.OnValueUpdated, new Action(UpdateValue));
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_setting != null)
			{
				SSTwoButtonsSetting setting = _setting;
				setting.OnSettingUpdate = (Action)Delegate.Remove(setting.OnSettingUpdate, new Action(SettingUpdated));
				SSTwoButtonsSetting setting2 = _setting;
				setting2.OnValueUpdated = (Action)Delegate.Remove(setting2.OnValueUpdated, new Action(UpdateValue));
			}
		}

		private void SettingUpdated()
		{
			_label.Set(_setting);
			_optionA.text = _setting.OptionA;
			_optionB.text = _setting.OptionB;
		}

		private void UpdateValue()
		{
			SetValueWithoutNotify(_setting.SyncIsB);
		}
	}
}
