using System;
using Footprinting;
using InventorySystem.Items;
using InventorySystem.Items.Keycards;
using InventorySystem.Items.Pickups;
using MapGeneration;
using PlayerRoles;
using Scp914;

namespace Achievements.Handlers
{
	public class Scp914UpgradeHandler : AchievementHandlerBase
	{
		private static bool AnyDClassIn914
		{
			get
			{
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (allHub.GetRoleId() == RoleTypeId.ClassD && allHub.TryGetCurrentRoom(out var room) && room.Name == RoomName.Lcz914)
					{
						return true;
					}
				}
				return false;
			}
		}

		internal override void OnInitialize()
		{
			Scp914Upgrader.OnInventoryItemUpgraded = (Action<ItemBase, Scp914KnobSetting>)Delegate.Combine(Scp914Upgrader.OnInventoryItemUpgraded, new Action<ItemBase, Scp914KnobSetting>(ItemUpgraded));
			Scp914Upgrader.OnPickupUpgraded = (Action<ItemPickupBase, Scp914KnobSetting>)Delegate.Combine(Scp914Upgrader.OnPickupUpgraded, new Action<ItemPickupBase, Scp914KnobSetting>(PickupUpgraded));
		}

		private static void ItemUpgraded(ItemBase item, Scp914KnobSetting sett)
		{
			if (item.Owner.GetRoleId() == RoleTypeId.Scientist && item is KeycardItem && AnyDClassIn914)
			{
				AchievementHandlerBase.ServerAchieve(item.OwnerInventory.connectionToClient, AchievementName.Friendship);
			}
		}

		private static void PickupUpgraded(ItemPickupBase ipb, Scp914KnobSetting sett)
		{
			Footprint previousOwner = ipb.PreviousOwner;
			ReferenceHub hub = previousOwner.Hub;
			if (ipb is KeycardPickup && previousOwner.Role == RoleTypeId.Scientist && !(hub == null))
			{
				PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
				if (previousOwner.LifeIdentifier == currentRole.UniqueLifeIdentifier && AnyDClassIn914)
				{
					AchievementHandlerBase.ServerAchieve(ipb.PreviousOwner.Hub.networkIdentity.connectionToClient, AchievementName.Friendship);
				}
			}
		}
	}
}
