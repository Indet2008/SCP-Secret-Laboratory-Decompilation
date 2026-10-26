using CustomPlayerEffects;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables
{
	public class Adrenaline : Consumable
	{
		private const float StaminaRegenerationPercent = 100f;

		private const float InvigoratedTargetDuration = 8f;

		private const bool InvigoratedDurationAdditive = true;

		private const float AhpAddition = 40f;

		protected override void OnEffectsActivated()
		{
			base.Owner.playerStats.GetModule<StaminaStat>().AddAmount(1f);
			base.Owner.playerStats.GetModule<AhpStat>().ServerAddProcess(40f);
			base.Owner.playerEffectsController.EnableEffect<Invigorated>(8f, addDuration: true);
			base.Owner.playerEffectsController.UseMedicalItem(this);
			base.Owner.playerEffectsController.DisableEffect<AmnesiaVision>();
		}
	}
}
