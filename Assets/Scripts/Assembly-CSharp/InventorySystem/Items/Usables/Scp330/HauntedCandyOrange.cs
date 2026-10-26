using CustomPlayerEffects;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyOrange : ICandy
	{
		private const float ActiveTime = 20f;

		public CandyKindID Kind => CandyKindID.Orange;

		public float SpawnChanceWeight { get; private set; } = 10f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<OrangeCandy>(20f, addDuration: true);
		}
	}
}
