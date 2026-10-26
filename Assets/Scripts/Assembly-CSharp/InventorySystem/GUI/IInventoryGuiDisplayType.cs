namespace InventorySystem.GUI
{
	public interface IInventoryGuiDisplayType
	{
		InventoryGuiAction DisplayAndSelectItems(Inventory targetInventory, out ushort itemSerial);

		void InventoryToggled(bool newState);

		void ItemsModified(Inventory targetInventory);

		void AmmoModified(ReferenceHub targetInventory);
	}
}
