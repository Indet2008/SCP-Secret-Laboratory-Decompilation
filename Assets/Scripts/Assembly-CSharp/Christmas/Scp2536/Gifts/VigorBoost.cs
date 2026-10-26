using PlayerRoles.PlayableScps.Scp106;

namespace Christmas.Scp2536.Gifts
{
	public class VigorBoost : Scp2536AnomalousGiftBase
	{
		private const float MaximumVigorPercentageAllowed = 0.4f;

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (!hub.playerStats.TryGetModule<VigorStat>(out var module))
			{
				return false;
			}
			if (module.NormalizedValue <= 0.4f)
			{
				return hub.roleManager.CurrentRole is Scp106Role;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			if (hub.playerStats.TryGetModule<VigorStat>(out var module))
			{
				module.CurValue = module.MaxValue;
			}
		}
	}
}
