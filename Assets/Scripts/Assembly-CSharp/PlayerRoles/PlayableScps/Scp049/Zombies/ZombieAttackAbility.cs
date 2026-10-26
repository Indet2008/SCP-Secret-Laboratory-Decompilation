using PlayerRoles.PlayableScps.Subroutines;
using PlayerStatsSystem;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieAttackAbility : SingleTargetAttackAbility<ZombieRole>
	{
		private ZombieConsumeAbility _consumeAbility;

		public override float DamageAmount => 40f;

		protected override float AttackDelay => 0f;

		protected override float BaseCooldown => 1.3f;

		protected override bool CanTriggerAbility
		{
			get
			{
				if (!_consumeAbility.IsInProgress)
				{
					return base.CanTriggerAbility;
				}
				return false;
			}
		}

		protected override bool SelfRepeating => false;

		protected override DamageHandlerBase DamageHandler(float damage)
		{
			return new Scp049DamageHandler(base.Owner, damage, Scp049DamageHandler.AttackType.Scp0492);
		}

		protected override void Awake()
		{
			base.Awake();
			base.CastRole.SubroutineModule.TryGetSubroutine<ZombieConsumeAbility>(out _consumeAbility);
		}
	}
}
