using CustomPlayerEffects;
using PlayerRoles.PlayableScps.Scp939;

namespace Christmas.Scp2536.Gifts
{
	public class TemporaryFocus : Scp2536AnomalousGiftBase
	{
		private const float EffectDuration = 40f;

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			return hub.roleManager.CurrentRole is Scp939Role;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			hub.playerEffectsController.EnableEffect<FocusedVision>(40f);
		}
	}
}
