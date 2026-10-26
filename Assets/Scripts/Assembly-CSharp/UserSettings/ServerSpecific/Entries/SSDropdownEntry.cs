using System;
using TMPro;
using UnityEngine;
using UserSettings.GUIElements;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSDropdownEntry : UserSettingsDropdown, ISSEntry
	{
		private SSDropdownSetting _setting;

		[SerializeField]
		private SSEntryLabel _label;

		protected override void SaveValue(int val)
		{
			if (!_setting.IsServerOnly)
			{
				PlayerPrefsSl.Set(_setting.PlayerPrefsKey, val);
			}
			_setting.SyncSelectionIndexRaw = val;
			_setting.ClientSendValue();
		}

		protected override int ReadSavedValue()
		{
			if (!_setting.IsServerOnly)
			{
				_setting.SyncSelectionIndexRaw = PlayerPrefsSl.Get(_setting.PlayerPrefsKey, _setting.DefaultOptionIndex);
			}
			return _setting.SyncSelectionIndexRaw;
		}

		public virtual bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			if (setting is SSDropdownSetting sSDropdownSetting)
			{
				return sSDropdownSetting.EntryType == SSDropdownSetting.DropdownEntryType.Regular;
			}
			return false;
		}

		public virtual void Init(ServerSpecificSettingBase setting)
		{
			_setting = setting as SSDropdownSetting;
			SettingUpdated();
			Setup();
			if (_setting.IsServerOnly)
			{
				SelectionUpdated();
			}
			SSDropdownSetting setting2 = _setting;
			setting2.OnSettingUpdate = (Action)Delegate.Combine(setting2.OnSettingUpdate, new Action(SettingUpdated));
			_setting.OnSelectionUpdated += SelectionUpdated;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_setting != null)
			{
				SSDropdownSetting setting = _setting;
				setting.OnSettingUpdate = (Action)Delegate.Remove(setting.OnSettingUpdate, new Action(SettingUpdated));
				_setting.OnSelectionUpdated -= SelectionUpdated;
			}
		}

		private void SettingUpdated()
		{
			_label.Set(_setting);
			base.TargetUI.options.Clear();
			string[] options = _setting.Options;
			foreach (string text in options)
			{
				base.TargetUI.options.Add(new TMP_Dropdown.OptionData(text));
			}
		}

		private void SelectionUpdated()
		{
			SetValueWithoutNotify(_setting.SyncSelectionIndexRaw);
		}
	}
}
