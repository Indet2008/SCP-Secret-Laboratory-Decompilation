using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyGreen : ICandy
	{
		private const int SugarHighDuration = 20;

		public CandyKindID Kind => CandyKindID.Green;

		public float SpawnChanceWeight { get; private set; } = 11f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<SugarHigh>(20f);
		}
	}
}
