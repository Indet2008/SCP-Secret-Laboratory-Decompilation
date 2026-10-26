using Mirror;
using PlayerRoles;

namespace Achievements.Handlers
{
	public class RespawnHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			PlayerRoleManager.OnServerRoleSet += OnRespawned;
		}

		private static void OnRespawned(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if ((reason == RoleChangeReason.Respawn || reason == RoleChangeReason.RespawnMiniwave) && newRole.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				NetworkConnection connectionToClient = userHub.connectionToClient;
				switch (result.Team)
				{
				case Team.FoundationForces:
					AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.LightsOut);
					break;
				case Team.ChaosInsurgency:
					AchievementHandlerBase.ServerAchieve(connectionToClient, AchievementName.DeltaCommand);
					break;
				}
			}
		}
	}
}
