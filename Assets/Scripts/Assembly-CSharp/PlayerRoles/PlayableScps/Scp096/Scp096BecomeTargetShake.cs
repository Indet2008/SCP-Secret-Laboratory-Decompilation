using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	// Restored from the client build: a short FOV kick that decays after becoming a target.
	public class Scp096BecomeTargetShake : global::CameraShaking.IShakeEffect
	{
		private float _remaining;

		private const float FovKick = 1.12f;

		private const float LerpSpeed = 0.92f;

		private const float RemoveThreshold = 0.001f;

		public bool GetEffect(ReferenceHub ply, out global::CameraShaking.ShakeEffectValues shakeValues)
		{
			_remaining = Mathf.Lerp(_remaining, 0f, Mathf.Clamp01(Time.deltaTime * LerpSpeed));
			shakeValues = new global::CameraShaking.ShakeEffectValues(null, null, null, Mathf.Clamp01(_remaining) * (FovKick - 1f) + 1f);
			return _remaining > RemoveThreshold;
		}

		public Scp096BecomeTargetShake()
		{
			_remaining = 1f;
		}
	}
}
