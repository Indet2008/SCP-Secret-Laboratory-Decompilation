using System;
using TMPro;
using UnityEngine;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSButtonEntry : HoldableButton, ISSEntry
	{
		[SerializeField]
		private SSEntryLabel _label;

		[SerializeField]
		private TMP_Text _buttonText;

		private float _holdTime;

		private SSButton _setting;

		public override float HoldTime => _holdTime;

		public bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			return setting is SSButton;
		}

		public void Init(ServerSpecificSettingBase settingBase)
		{
			_setting = settingBase as SSButton;
			UpdateButton();
			SSButton setting = _setting;
			setting.OnSettingUpdate = (Action)Delegate.Combine(setting.OnSettingUpdate, new Action(SettingUpdated));
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_setting != null)
			{
				SSButton setting = _setting;
				setting.OnSettingUpdate = (Action)Delegate.Remove(setting.OnSettingUpdate, new Action(SettingUpdated));
			}
		}

		private void OnTrigger()
		{
			_setting.ClientSendValue();
		}

		private void SettingUpdated()
		{
			base.OnHeld.RemoveListener(OnTrigger);
			base.onClick.RemoveListener(OnTrigger);
			UpdateButton();
		}

		private void UpdateButton()
		{
			_label.Set(_setting);
			_holdTime = _setting.HoldTimeSeconds;
			if (_holdTime > 0f)
			{
				base.OnHeld.AddListener(OnTrigger);
			}
			else
			{
				base.onClick.AddListener(OnTrigger);
			}
			_buttonText.text = _setting.ButtonText;
		}
	}
}
