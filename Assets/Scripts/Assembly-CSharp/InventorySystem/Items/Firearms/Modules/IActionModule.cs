namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IActionModule
	{
		float DisplayCyclicRate { get; }

		bool IsLoaded { get; }
	}
}
