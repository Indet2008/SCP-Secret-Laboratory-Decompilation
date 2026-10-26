using CustomPlayerEffects;
using InventorySystem.Disarming;
using InventorySystem.Items;
using Mirror;
using PlayerRoles;

namespace Achievements.Handlers
{
	public class EscapeHandler : AchievementHandlerBase
	{
		private static bool _escapeFired;

		internal override void OnInitialize()
		{
			Escape.OnServerPlayerEscape += OnEscaped;
			PlayerRoleManager.OnServerRoleSet += OnRoleSet;
		}

		private static void OnRoleSet(ReferenceHub userHub, RoleTypeId newId, RoleChangeReason reason)
		{
			if (NetworkServer.active && !_escapeFired && reason == RoleChangeReason.Escaped)
			{
				AchievementHandlerBase.ServerAchieve(userHub.networkIdentity.connectionToClient, AchievementName.EscapeArtist);
				_escapeFired = true;
			}
		}

		internal override void OnRoundStarted()
		{
			_escapeFired = false;
		}

		private static void OnEscaped(ReferenceHub userHub)
		{
			NetworkConnectionToClient connectionToClient = userHub.networkIdentity.connectionToClient;
			PlayerRoleBase currentRole = userHub.roleManager.CurrentRole;
			if (userHub.playerEffectsController.GetEffect<Scp207>().IsEnabled)
			{
				AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.Escape207);
			}
			if (currentRole.RoleTypeId == RoleTypeId.Scientist)
			{
				AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.ForScience);
			}
			else
			{
				if (currentRole.RoleTypeId != RoleTypeId.ClassD)
				{
					return;
				}
				AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.ItsAlwaysLeft);
				int num = 0;
				if (!userHub.inventory.IsDisarmed())
				{
					foreach (ItemBase value in userHub.inventory.UserInventory.Items.Values)
					{
						if (value.Category == ItemCategory.SCPItem)
						{
							num++;
						}
					}
				}
				if (num >= 2)
				{
					AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.PropertyOfChaos);
				}
			}
		}
	}
}
