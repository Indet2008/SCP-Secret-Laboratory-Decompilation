using Footprinting;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public class Scp244Item : UsableItem
	{
		private bool _primed;

		public override void ServerOnUsingCompleted()
		{
			_primed = true;
			base.OwnerInventory.ServerDropItem(base.ItemSerial);
		}

		public override void OnUsingCancelled()
		{
			base.OnUsingCancelled();
			_primed = false;
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			PickupSyncInfo value = new PickupSyncInfo
			{
				ItemId = ItemTypeId,
				Serial = base.ItemSerial,
				WeightKg = Weight
			};
			ItemPickupBase itemPickupBase = base.OwnerInventory.ServerCreatePickup(this, value, spawn, (ItemPickupBase ipb) =>
			{
				ipb.PreviousOwner = new Footprint(base.Owner);
				if (ipb is Scp244DeployablePickup scp244DeployablePickup)
				{
					scp244DeployablePickup.State = (_primed ? Scp244State.Active : Scp244State.Idle);
				}
				Transform transform = base.Owner.transform;
				ipb.transform.SetPositionAndRotation(transform.position, transform.rotation);
			});
			base.OwnerInventory.ServerRemoveItem(base.ItemSerial, itemPickupBase);
			return itemPickupBase;
		}
	}
}
