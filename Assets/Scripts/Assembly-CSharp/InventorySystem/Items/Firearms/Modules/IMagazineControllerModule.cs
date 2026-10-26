namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IMagazineControllerModule
	{
		bool MagazineInserted { get; }
	}
}
