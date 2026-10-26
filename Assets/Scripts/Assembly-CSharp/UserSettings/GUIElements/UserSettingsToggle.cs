using UnityEngine.Events;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	public class UserSettingsToggle : UserSettingsUIBase<Toggle, bool>
	{
		protected override UnityEvent<bool> OnValueChangedEvent => base.TargetUI.onValueChanged;

		protected override void SetValueAndTriggerEvent(bool val)
		{
			base.TargetUI.isOn = val;
		}

		protected override void SetValueWithoutNotify(bool val)
		{
			base.TargetUI.SetIsOnWithoutNotify(val);
		}
	}
}
