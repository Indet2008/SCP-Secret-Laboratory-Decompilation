using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.Usables.Scp244;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;

namespace InventorySystem.Searching
{
	public class Scp244SearchCompletor : ItemSearchCompletor
	{
		public Scp244SearchCompletor(ReferenceHub hub, ItemPickupBase targetPickup, ItemBase targetItem, double maxDistanceSquared)
			: base(hub, targetPickup, targetItem, maxDistanceSquared)
		{
		}

		protected override bool ValidateAny()
		{
			if (base.ValidateAny() && TargetPickup is Scp244DeployablePickup scp244DeployablePickup)
			{
				return !scp244DeployablePickup.ModelDestroyed;
			}
			return false;
		}

		public override void Complete()
		{
			if (TargetPickup is Scp244DeployablePickup scp244DeployablePickup)
			{
				PlayerEvents.OnSearchedPickup(new PlayerSearchedPickupEventArgs(base.Hub, TargetPickup));
				PlayerPickingUpItemEventArgs e = new PlayerPickingUpItemEventArgs(base.Hub, TargetPickup);
				PlayerEvents.OnPickingUpItem(e);
				if (!e.IsAllowed)
				{
					ItemPickupBase targetPickup = TargetPickup;
					PickupSyncInfo info = TargetPickup.Info;
					info.InUse = false;
					targetPickup.NetworkInfo = info;
				}
				else
				{
					ItemBase item = base.Hub.inventory.ServerAddItem(TargetPickup.Info.ItemId, ItemAddReason.PickedUp, TargetPickup.Info.Serial, TargetPickup);
					scp244DeployablePickup.State = Scp244State.PickedUp;
					CheckCategoryLimitHint();
					PlayerEvents.OnPickedUpItem(new PlayerPickedUpItemEventArgs(base.Hub, item));
				}
			}
		}
	}
}
