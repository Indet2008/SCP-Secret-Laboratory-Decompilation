using MapGeneration.Holidays;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp1507;

namespace CustomPlayerEffects
{
	public class BecomingFlamingo : StatusEffectBase, IHolidayEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _screamClip;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AnimationCurve _maxFadeOverTime;

		[global::UnityEngine.SerializeField]
		private float _fogAdjustSpeed;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _particles;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _burstParticles;

		[global::UnityEngine.SerializeField]
		private float _burstFadeThreshold;


		public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
		{
			HolidayType.Christmas,
			HolidayType.AprilFools
		};

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			if (newRole is Scp1507Role)
			{
				base.OnRoleChanged(previousRole, newRole);
			}
		}

		internal override void OnDeath(PlayerRoleBase previousRole)
		{
		}
	}
}
