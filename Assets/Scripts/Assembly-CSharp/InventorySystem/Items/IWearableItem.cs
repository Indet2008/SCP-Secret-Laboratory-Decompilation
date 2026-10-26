namespace InventorySystem.Items
{
	public interface IWearableItem
	{
		bool IsWorn { get; }

		WearableSlot Slot { get; }
	}
}
