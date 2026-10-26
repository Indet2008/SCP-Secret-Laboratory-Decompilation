namespace InventorySystem.Drawers
{
	public interface IItemAlertDrawer : IItemDrawer
	{
		AlertContent Alert { get; }
	}
}
