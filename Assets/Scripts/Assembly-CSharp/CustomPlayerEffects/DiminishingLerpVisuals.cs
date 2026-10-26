using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	// Fades in like the other lerp visuals, then decays along _intensityCurve over _diminishingTime.
	public class DiminishingLerpVisuals : LerpVisualsBase
	{
		[SerializeField]
		private AnimationCurve _intensityCurve;

		[SerializeField]
		private float _diminishingTime;

		private float _enabledTime = -1f;

		private Volume _volume;

		protected override float TargetWeight
		{
			get
			{
				float targetWeight = base.TargetWeight;
				if (targetWeight <= 0f)
				{
					_enabledTime = -1f;
					return 0f;
				}
				if (_enabledTime < 0f)
				{
					_enabledTime = Time.time;
				}
				if (_intensityCurve == null || _diminishingTime <= 0f)
				{
					return targetWeight;
				}
				return targetWeight * Mathf.Clamp01(_intensityCurve.Evaluate((Time.time - _enabledTime) / _diminishingTime));
			}
		}

		protected override void ApplyWeight(float weight)
		{
			if (_volume == null)
			{
				_volume = GetComponent<Volume>();
			}
			if (_volume != null)
			{
				_volume.weight = weight;
				_volume.enabled = weight > 0f;
			}
		}
	}
}
