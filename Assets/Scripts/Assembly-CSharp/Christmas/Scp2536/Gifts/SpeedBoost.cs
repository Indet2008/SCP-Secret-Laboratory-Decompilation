using CustomPlayerEffects;

namespace Christmas.Scp2536.Gifts
{
	public class SpeedBoost : Scp2536AnomalousGiftBase
	{
		private const int EffectIntensity = 30;

		private const int EffectDuration = 25;

		public override UrgencyLevel Urgency => UrgencyLevel.Six;

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			hub.playerEffectsController.ChangeState<MovementBoost>(30, 25f);
		}
	}
}
