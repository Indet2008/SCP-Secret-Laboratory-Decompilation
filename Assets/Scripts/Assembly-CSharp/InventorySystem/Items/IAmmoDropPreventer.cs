namespace InventorySystem.Items
{
	public interface IAmmoDropPreventer
	{
		bool ValidateAmmoDrop(ItemType id);

		static bool CanDropAmmo(ReferenceHub hub, ItemType id)
		{
			ItemBase curInstance = hub.inventory.CurInstance;
			if (curInstance is IAmmoDropPreventer ammoDropPreventer && !(curInstance == null))
			{
				return ammoDropPreventer.ValidateAmmoDrop(id);
			}
			return true;
		}
	}
}
