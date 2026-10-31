using CustomRendering;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class LerpFrostingVisuals : LerpPostProcessVisuals
	{
		[SerializeField]
		[Tooltip("This effect bugs out when Frosting is set to 1.\n\nYou have been warned!")]
		private float _maxFrosting = 0.99f;

		private VignetteRefraction _refraction;

		protected override void Awake()
		{
			base.Awake();
			base.ProcessVolume.profile.TryGet<VignetteRefraction>(out _refraction);
		}

		protected override void OnWeightChanged(float weight)
		{
			base.ProcessVolume.weight = ((weight > 0f) ? 1f : 0f);
			_refraction.Frosting.value = Mathf.Min(weight, _maxFrosting);
		}
	}
}
