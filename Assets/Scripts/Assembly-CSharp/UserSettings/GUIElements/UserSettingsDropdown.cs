using TMPro;
using UnityEngine.Events;

namespace UserSettings.GUIElements
{
	public class UserSettingsDropdown : UserSettingsUIBase<TMP_Dropdown, int>
	{
		protected override UnityEvent<int> OnValueChangedEvent => base.TargetUI.onValueChanged;

		protected override void SetValueAndTriggerEvent(int val)
		{
			base.TargetUI.value = val;
		}

		protected override void SetValueWithoutNotify(int val)
		{
			while (val >= base.TargetUI.options.Count)
			{
				base.TargetUI.options.Add(new TMP_Dropdown.OptionData());
			}
			base.TargetUI.SetValueWithoutNotify(val);
		}
	}
}
