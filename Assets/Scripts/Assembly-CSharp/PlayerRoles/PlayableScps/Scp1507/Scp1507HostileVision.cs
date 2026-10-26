using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507HostileVision : StandardSubroutine<Scp1507Role>
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Color _colorMultiplier;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _postProcess;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.ParticleSystem _particleTemplate;

		[global::UnityEngine.SerializeField]
		private float _visionRange;


	}
}
