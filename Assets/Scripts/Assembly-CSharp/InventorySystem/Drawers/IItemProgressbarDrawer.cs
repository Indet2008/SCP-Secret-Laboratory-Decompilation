namespace InventorySystem.Drawers
{
	public interface IItemProgressbarDrawer : IItemDrawer
	{
		bool ProgressbarEnabled { get; }

		float ProgressbarMin { get; }

		float ProgressbarMax { get; }

		float ProgressbarValue { get; }

		float ProgressbarWidth { get; }
	}
}
