using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyGray : ICandy
	{
		public CandyKindID Kind => CandyKindID.Gray;

		public float SpawnChanceWeight { get; private set; } = 9.5f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<Metal>(30f, addDuration: true);
		}
	}
}
