using CustomPlayerEffects;
using PlayerStatsSystem;

namespace Christmas.Scp2536.Gifts
{
	public class HumeShieldRefresh : Scp2536AnomalousGiftBase
	{
		private const float EffectDuration = 20f;

		private const float MaximumHumePercentageAllowed = 0.4f;

		private const float InCombatDuration = 15f;

		public override UrgencyLevel Urgency => UrgencyLevel.Four;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub) || hub.playerStats.TimeSinceDamageTick > 15.0)
			{
				return false;
			}
			if (!hub.playerStats.TryGetModule<HumeShieldStat>(out var module))
			{
				return false;
			}
			return module.NormalizedValue <= 0.4f;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			hub.playerEffectsController.EnableEffect<AnomalousRegeneration>(20f);
		}
	}
}
