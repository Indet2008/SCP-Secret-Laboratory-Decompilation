using UnityEngine;

namespace CustomPlayerEffects
{
	public class LerpFrostingVisuals : LerpPostProcessVisuals
	{
		[SerializeField]
		[Tooltip("This effect bugs out when Frosting is set to 1.\n\nYou have been warned!")]
		private float _maxFrosting;

		protected override void ApplyWeight(float weight)
		{
			float num = ((_maxFrosting > 0f) ? Mathf.Min(_maxFrosting, 0.99f) : 0.99f);
			base.ApplyWeight(weight * num);
		}
	}
}
