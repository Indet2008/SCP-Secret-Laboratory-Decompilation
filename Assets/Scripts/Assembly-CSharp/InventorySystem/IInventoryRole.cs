using InventorySystem.Items.Pickups;

namespace InventorySystem
{
	public interface IInventoryRole
	{
		bool AllowDisarming(ReferenceHub detainer);

		bool AllowUndisarming(ReferenceHub releaser);

		bool CanPickupItem(ItemPickupBase itemPickup)
		{
			return true;
		}
	}
}
