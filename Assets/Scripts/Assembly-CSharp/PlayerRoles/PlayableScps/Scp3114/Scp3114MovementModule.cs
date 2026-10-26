using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114MovementModule : FirstPersonMovementModule, IStaminaModifier
	{
		private Scp3114Role _scpRole;

		private float _skeletonWalkSpeed;

		private float _skeletonSprintSpeed;

		protected override FpcStateProcessor NewStateProcessor => new SubroutineInfluencedFpcStateProcessor(base.Hub, this, FpcStateProcessor.DefaultUseRate, FpcStateProcessor.DefaultSpawnImmunity, FpcStateProcessor.DefaultRegenCooldown, FpcStateProcessor.DefaultRegenSpeed, 3.11f);

		public bool StaminaModifierActive => _scpRole.SkeletonIdle;

		public float StaminaUsageMultiplier => 1.8f;

		private void Awake()
		{
			_scpRole = GetComponent<Scp3114Role>();
			_skeletonWalkSpeed = WalkSpeed;
			_skeletonSprintSpeed = SprintSpeed;
			_scpRole.CurIdentity.OnStatusChanged += OnStatusChanged;
		}

		private void OnStatusChanged()
		{
			switch (_scpRole.CurIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Active:
			{
				if (_scpRole.CurIdentity.StolenRole.TryGetRoleTemplate<HumanRole>(out var result))
				{
					WalkSpeed = result.FpcModule.WalkSpeed;
					SprintSpeed = result.FpcModule.SprintSpeed;
				}
				break;
			}
			case Scp3114Identity.DisguiseStatus.None:
				WalkSpeed = _skeletonWalkSpeed;
				SprintSpeed = _skeletonSprintSpeed;
				break;
			}
		}
	}
}
