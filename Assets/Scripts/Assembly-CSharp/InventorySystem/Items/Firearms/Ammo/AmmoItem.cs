using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Ammo
{
	public class AmmoItem : ItemBase, IItemNametag
	{
		[SerializeField]
		private string _caliber;

		public int UnitPrice;

		public override float Weight => 0.25f + ((PickupDropModel is AmmoPickup ammoPickup) ? ((float)(int)ammoPickup.SavedAmmo * 0.01f) : 0f);

		public string Name => _caliber;

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.None;

		public override void OnAdded(ItemPickupBase pickup)
		{
			if (NetworkServer.active)
			{
				if (pickup is AmmoPickup ammoPickup)
				{
					base.OwnerInventory.ServerAddAmmo(ItemTypeId, ammoPickup.SavedAmmo);
				}
				else if (PickupDropModel is AmmoPickup ammoPickup2)
				{
					base.OwnerInventory.ServerAddAmmo(ItemTypeId, ammoPickup2.SavedAmmo);
				}
				base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
			}
		}
	}
}
