namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyRed : ICandy
	{
		private const float RegenerationDuration = 5f;

		private const float RegenerationPerSecond = 9f;

		public CandyKindID Kind => CandyKindID.Red;

		public float SpawnChanceWeight { get; private set; } = 1f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			Scp330Bag.AddSimpleRegeneration(hub, 9f, 5f);
		}
	}
}
