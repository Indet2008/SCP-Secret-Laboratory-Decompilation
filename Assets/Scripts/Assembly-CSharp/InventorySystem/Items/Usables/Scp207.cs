using CustomPlayerEffects;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables
{
	public class Scp207 : Consumable
	{
		public const byte MaxColas = 4;

		private const int InstantHealth = 30;

		protected override void OnEffectsActivated()
		{
			base.Owner.playerStats.GetModule<StaminaStat>().CurValue = 1f;
			base.Owner.playerStats.GetModule<HealthStat>().ServerHeal(30f);
			if (base.Owner.playerEffectsController.TryGetEffect<CustomPlayerEffects.Scp207>(out var playerEffect))
			{
				byte intensity = playerEffect.Intensity;
				if (intensity < 4)
				{
					base.Owner.playerEffectsController.ChangeState<CustomPlayerEffects.Scp207>(++intensity);
				}
			}
		}
	}
}
