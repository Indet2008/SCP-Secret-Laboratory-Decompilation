using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class CustomSlider : Slider
	{
		[Tooltip("This text will be updated as the value of this slider changes.")]
		public TMP_Text ValueDisplay;

		[SerializeField]
		private string _valueFormat;

		protected override void Awake()
		{
			base.Awake();
			onValueChanged.AddListener(ChangeValue);
			SetText(value);
		}

		protected void ChangeValue(float newValue)
		{
			SetText(newValue);
			OnValueChanged(newValue);
		}

		protected virtual void OnValueChanged(float newValue)
		{
		}

		public virtual void SetText(float newValue)
		{
			if (!(ValueDisplay == null))
			{
				if (string.IsNullOrEmpty(_valueFormat))
				{
					ValueDisplay.text = newValue.ToString("0.##");
				}
				else
				{
					ValueDisplay.text = (_valueFormat.Contains("{") ? string.Format(_valueFormat, newValue) : newValue.ToString(_valueFormat));
				}
			}
		}
	}
}
