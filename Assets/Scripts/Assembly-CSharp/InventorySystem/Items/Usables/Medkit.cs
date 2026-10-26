using PlayerStatsSystem;

namespace InventorySystem.Items.Usables
{
	public class Medkit : Consumable
	{
		private const int HpToHeal = 65;

		protected override void OnEffectsActivated()
		{
			base.Owner.playerStats.GetModule<HealthStat>().ServerHeal(65f);
			base.Owner.playerEffectsController.UseMedicalItem(this);
		}
	}
}
