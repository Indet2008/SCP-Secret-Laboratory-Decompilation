using CustomPlayerEffects;

namespace InventorySystem.Items.Usables
{
	public class Scp1853Item : Consumable
	{
		protected override void OnEffectsActivated()
		{
			base.Owner.playerEffectsController.EnableEffect<Scp1853>();
		}
	}
}
