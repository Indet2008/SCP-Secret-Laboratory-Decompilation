using InventorySystem.Items.Usables;
using Mirror;

namespace Achievements.Handlers
{
	public class GeneralUseItemHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			UsableItemsController.ServerOnUsingCompleted += ServerOnUsingCompleted;
		}

		private static void ServerOnUsingCompleted(ReferenceHub hub, UsableItem item)
		{
			if (NetworkServer.active && item.ItemTypeId == ItemType.SCP1576)
			{
				AchievementHandlerBase.ServerAchieve(hub.networkIdentity.connectionToClient, AchievementName.AfterlifeCommunicator);
			}
		}
	}
}
