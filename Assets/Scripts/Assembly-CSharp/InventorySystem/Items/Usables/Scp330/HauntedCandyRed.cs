using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyRed : ICandy
	{
		public CandyKindID Kind => CandyKindID.Red;

		public float SpawnChanceWeight { get; private set; } = 11f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<Spicy>(10f);
		}
	}
}
