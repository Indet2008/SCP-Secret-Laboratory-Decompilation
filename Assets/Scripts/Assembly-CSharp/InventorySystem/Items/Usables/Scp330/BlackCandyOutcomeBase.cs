namespace InventorySystem.Items.Usables.Scp330
{
	public abstract class BlackCandyOutcomeBase
	{
		public virtual bool IsAvailable => true;

		public abstract void ServerGrant(ReferenceHub target);
	}
}
