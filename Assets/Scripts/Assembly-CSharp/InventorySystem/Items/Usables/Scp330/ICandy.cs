namespace InventorySystem.Items.Usables.Scp330
{
	public interface ICandy
	{
		CandyKindID Kind { get; }

		float SpawnChanceWeight { get; }

		void ServerApplyEffects(ReferenceHub hub);
	}
}
