using PlayerStatsSystem;

namespace Christmas.Scp2536.Gifts
{
	public class HealthBoost : Scp2536AnomalousGiftBase
	{
		private const float MaxHpHealingMultiplier = 0.15f;

		private const float MaximumHealthPercentageAllowed = 0.4f;

		public override UrgencyLevel Urgency => UrgencyLevel.Two;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (!hub.playerStats.TryGetModule<HealthStat>(out var module))
			{
				return false;
			}
			return module.NormalizedValue <= 0.4f;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			if (hub.playerStats.TryGetModule<HealthStat>(out var module))
			{
				module.ServerHeal(module.MaxValue * 0.15f);
			}
		}
	}
}
