using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyYellow : ICandy
	{
		private const int SugarRushDuration = 15;

		public CandyKindID Kind => CandyKindID.Yellow;

		public float SpawnChanceWeight { get; private set; } = 11f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<SugarRush>(15f);
		}
	}
}
