using System;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class ColorSliderSetting : CustomSliderSetting
	{
		// The value is kept in slider units (the scene's colour sliders run 0-100), not as a 0-1 channel.
		public override float Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = Mathf.Clamp(value, 0f, Scale);
			}
		}

		private float Scale
		{
			get
			{
				if (RepresentingSlider != null && RepresentingSlider.maxValue > 0f)
				{
					return RepresentingSlider.maxValue;
				}
				return 100f;
			}
		}

		private float? _authoredValue;

		// Unknown original defaults; fall back to the colour the scene was authored with.
		public override float DefaultValue
		{
			get
			{
				if (_authoredValue.HasValue)
				{
					return _authoredValue.Value;
				}
				if (RaUIElements != null)
				{
					RawImage[] raUIElements = RaUIElements;
					foreach (RawImage rawImage in raUIElements)
					{
						if (rawImage != null)
						{
							_authoredValue = Mathf.Round(GetChannel(rawImage.color) * Scale);
							return _authoredValue.Value;
						}
					}
				}
				return Scale;
			}
		}

		protected override void OnSave()
		{
			PlayerPrefsSl.Set(Path, Value);
		}

		protected override void OnLoad()
		{
			float stored = PlayerPrefsSl.Get(Path, DefaultValue);
			// Earlier builds of this port saved the raw 0-1 channel; read those as a fraction of the slider.
			Value = (stored > 0f && stored <= 1f) ? (stored * Scale) : stored;
		}

		[field: SerializeField]
		public RawImage[] RaUIElements { get; set; }

		protected override void OnUpdateSlider(float value)
		{
			if (RaUIElements == null)
			{
				return;
			}
			float channel = value / Scale;
			RawImage[] raUIElements = RaUIElements;
			foreach (RawImage rawImage in raUIElements)
			{
				if (rawImage != null)
				{
					rawImage.color = CreateColor(rawImage.color, channel);
				}
			}
		}

		protected abstract float GetChannel(Color color);

		protected virtual Color CreateColor(Color oldColor, float value)
		{
			return oldColor;
		}
	}
}
