using System;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class ColorSliderSetting : CustomSliderSetting
	{
		public override float Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = Mathf.Clamp01(value);
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
							_authoredValue = GetChannel(rawImage.color);
							return _authoredValue.Value;
						}
					}
				}
				return 1f;
			}
		}

		[field: SerializeField]
		public RawImage[] RaUIElements { get; set; }

		protected override void OnUpdateSlider(float value)
		{
			if (RaUIElements == null)
			{
				return;
			}
			RawImage[] raUIElements = RaUIElements;
			foreach (RawImage rawImage in raUIElements)
			{
				if (rawImage != null)
				{
					rawImage.color = CreateColor(rawImage.color, value);
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
