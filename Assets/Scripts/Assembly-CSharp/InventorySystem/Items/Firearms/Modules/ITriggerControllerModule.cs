namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface ITriggerControllerModule
	{
		bool TriggerHeld { get; }

		double LastTriggerPress { get; }

		double LastTriggerRelease { get; }
	}
}
