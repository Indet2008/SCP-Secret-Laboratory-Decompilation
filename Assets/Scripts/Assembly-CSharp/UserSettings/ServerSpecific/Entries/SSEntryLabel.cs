using System;
using TMPro;
using UnityEngine;
using UserSettings.GUIElements;

namespace UserSettings.ServerSpecific.Entries
{
	[Serializable]
	public class SSEntryLabel
	{
		[SerializeField]
		private TMP_Text _label;

		[SerializeField]
		private CustomUserSettingsEntryDescription _hint;

		public void Set(ServerSpecificSettingBase setting)
		{
			_label.text = setting.Label;
			if (string.IsNullOrEmpty(setting.HintDescription))
			{
				_hint.gameObject.SetActive(value: false);
				return;
			}
			_hint.gameObject.SetActive(value: true);
			_hint.SetCustomText(setting.HintDescription);
		}
	}
}
