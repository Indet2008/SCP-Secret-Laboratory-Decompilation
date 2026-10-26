using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Keycards;
using InventorySystem.Items.Pickups;
using Mirror;
using PlayerRoles;

namespace Achievements.Handlers
{
	public class ItemPickupHandler : AchievementHandlerBase
	{
		private const ItemType ExecutiveAccessCardId = ItemType.KeycardO5;

		internal override void OnInitialize()
		{
			InventoryExtensions.OnItemAdded += OnItemAdded;
		}

		private static void OnItemAdded(ReferenceHub ply, ItemBase ib, ItemPickupBase pickup)
		{
			if (NetworkServer.active)
			{
				if (ib is KeycardItem { ItemTypeId: ItemType.KeycardO5 })
				{
					AchievementHandlerBase.ServerAchieve(ply.connectionToClient, AchievementName.ExecutiveAccess);
				}
				else if (ply.GetRoleId() == RoleTypeId.ClassD && ib is Firearm)
				{
					AchievementHandlerBase.ServerAchieve(ply.connectionToClient, AchievementName.ThatCanBeUseful);
				}
			}
		}
	}
}
