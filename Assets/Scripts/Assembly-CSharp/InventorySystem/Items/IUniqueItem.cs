namespace InventorySystem.Items
{
	public interface IUniqueItem
	{
		bool CompareIdentical(ItemBase other);
	}
}
