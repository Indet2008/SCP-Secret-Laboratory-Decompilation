using Mirror;
using PlayerRoles.PlayableScps.HumeShield;

namespace CustomPlayerEffects
{
	public class AnomalousRegeneration : StatusEffectBase, IHumeRegenModifier
	{
		public override EffectClassification Classification => EffectClassification.Positive;

		public bool HumeRegenCooldownEnabled => false;

		protected override void Enabled()
		{
			base.Enabled();
			if (NetworkServer.active && base.Hub.roleManager.CurrentRole is IHumeShieldedRole humeShieldedRole)
			{
				humeShieldedRole.HumeShieldModule.HsCurrent = humeShieldedRole.HumeShieldModule.HsMax;
			}
		}
	}
}
