using UnityEngine.Events;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	public class UserSettingsSlider : UserSettingsUIBase<Slider, float>
	{
		protected override UnityEvent<float> OnValueChangedEvent => base.TargetUI.onValueChanged;

		protected override void SetValueAndTriggerEvent(float val)
		{
			base.TargetUI.value = val;
		}

		protected override void SetValueWithoutNotify(float val)
		{
			base.TargetUI.SetValueWithoutNotify(val);
		}
	}
}
