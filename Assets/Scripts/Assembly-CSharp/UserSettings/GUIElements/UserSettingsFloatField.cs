using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UserSettings.GUIElements
{
	public class UserSettingsFloatField : UserSettingsUIBase<TMP_InputField, float>
	{
		[SerializeField]
		private float _minInput;

		[SerializeField]
		private float _maxInput = 1f;

		[SerializeField]
		private string _toStringFormat = "0.000";

		[SerializeField]
		private string _finalFormat = "{0}";

		[SerializeField]
		private float _valueMultiplier = 1f;

		private readonly UnityEvent<float> _onParsed = new UnityEvent<float>();

		protected override UnityEvent<float> OnValueChangedEvent => _onParsed;

		protected override void Awake()
		{
			base.Awake();
			base.TargetUI.onEndEdit.AddListener((string str) =>
			{
				if (!float.TryParse(str, out var result))
				{
					SetValueAndTriggerEvent(base.StoredValue * _valueMultiplier);
				}
				else
				{
					_onParsed.Invoke(Mathf.Clamp(result / _valueMultiplier, _minInput, _maxInput));
					EventSystem current = EventSystem.current;
					if (!current.alreadySelecting)
					{
						current.SetSelectedGameObject(null);
					}
				}
			});
			base.TargetUI.onSelect.AddListener((string _) =>
			{
				string text = (base.StoredValue * _valueMultiplier).ToString();
				if (text.Length > base.TargetUI.characterLimit)
				{
					text = text.Remove(base.TargetUI.characterLimit);
				}
				base.TargetUI.SetTextWithoutNotify(text);
			});
		}

		protected override void SetValueAndTriggerEvent(float val)
		{
			base.TargetUI.text = FormatValue(val);
		}

		protected override void SetValueWithoutNotify(float val)
		{
			base.TargetUI.SetTextWithoutNotify(FormatValue(val));
		}

		private string FormatValue(float val)
		{
			return string.Format(_finalFormat, (val * _valueMultiplier).ToString(_toStringFormat));
		}
	}
}
