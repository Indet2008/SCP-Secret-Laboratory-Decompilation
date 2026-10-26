namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096BecomeTargetShake : global::CameraShaking.IShakeEffect
	{
		private float _remaining;

		private const float FovKick = 1.12f;

		private const float LerpSpeed = 0.92f;

		private const float RemoveThreshold = 0.001f;

		public bool GetEffect(ReferenceHub ply, out global::CameraShaking.ShakeEffectValues shakeValues)
		{ shakeValues = default;
			return default;
		}

		public Scp096BecomeTargetShake()
		{
		}
	}
}
