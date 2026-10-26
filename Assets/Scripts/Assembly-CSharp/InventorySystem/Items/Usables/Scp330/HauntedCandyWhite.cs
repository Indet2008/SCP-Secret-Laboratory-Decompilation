using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyWhite : ICandy
	{
		public CandyKindID Kind => CandyKindID.White;

		public float SpawnChanceWeight { get; private set; } = 10f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<WhiteCandy>(25f, addDuration: true);
		}
	}
}
