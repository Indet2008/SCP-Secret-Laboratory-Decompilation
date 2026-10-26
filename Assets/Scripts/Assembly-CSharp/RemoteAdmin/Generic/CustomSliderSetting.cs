using System;
using UnityEngine;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class CustomSliderSetting : RaSetting<float>
	{
		public override float Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
				if (RepresentingSlider != null)
				{
					RepresentingSlider.SetValueWithoutNotify(value);
					RepresentingSlider.SetText(value);
				}
				OnUpdateSlider(value);
			}
		}

		[field: SerializeField]
		public CustomSlider RepresentingSlider { get; set; }

		public void SliderToValue()
		{
			if (RepresentingSlider != null)
			{
				Value = RepresentingSlider.value;
				Save();
			}
		}

		protected override void OnSave()
		{
			PlayerPrefsSl.Set(Path, Value);
		}

		protected override void OnLoad()
		{
			Value = PlayerPrefsSl.Get(Path, DefaultValue);
		}

		protected virtual void OnUpdateSlider(float value)
		{
		}
	}
}
