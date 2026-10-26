using CameraShaking;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	// Client-only behaviour stripped from the server build: lowers the camera into the
	// floor while SCP-106 submerges and narrows the FOV slightly.
	public class Scp106PortalShake : IShakeEffect
	{
		private const float StalkHeight = -0.75f;

		private const float NormalizationLerp = 300f;

		private const float MinFovPercent = 0.9f;

		private readonly Scp106Model _model;

		private readonly Scp106Role _role;

		private static Scp106PortalShake _latestEffect;

		public Scp106PortalShake(Scp106Role role, Scp106Model model)
		{
			_role = role;
			_model = model;
			_latestEffect = this;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			shakeValues = ShakeEffectValues.None;
			if (_latestEffect != this || _role == null || ply == null || ply.roleManager.CurrentRole != _role)
			{
				return false;
			}
			Scp106SinkholeController sinkhole = _role.Sinkhole;
			if (sinkhole == null)
			{
				return true;
			}
			float num = Mathf.SmoothStep(0f, 1f, Mathf.Clamp01(sinkhole.SubmergeProgress));
			shakeValues = new ShakeEffectValues(null, null, Vector3.up * (StalkHeight * num), Mathf.Lerp(1f, MinFovPercent, num));
			return true;
		}

		public static void Register(Scp106Role role, Scp106Model model)
		{
			if (!(CameraShakeController.Singleton == null))
			{
				CameraShakeController.AddEffect(new Scp106PortalShake(role, model));
			}
		}
	}
}
