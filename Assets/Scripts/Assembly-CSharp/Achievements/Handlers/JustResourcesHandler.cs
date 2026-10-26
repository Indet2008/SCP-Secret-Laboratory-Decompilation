using System.Collections.Generic;
using InventorySystem.Disarming;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class JustResourcesHandler : AchievementHandlerBase
	{
		private List<ReferenceHub> _interactedPlayers = new List<ReferenceHub>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
			DisarmingHandlers.OnPlayerDisarmed += HandleDisarmed;
		}

		internal override void OnRoundStarted()
		{
			_interactedPlayers.Clear();
		}

		private void HandleDisarmed(ReferenceHub disarmerHub, ReferenceHub targetHub)
		{
			if (NetworkServer.active && !(disarmerHub == null) && !(targetHub == null) && disarmerHub.GetTeam() == Team.Scientists && targetHub.GetTeam() == Team.ClassD && !_interactedPlayers.Contains(targetHub))
			{
				_interactedPlayers.Add(targetHub);
				AchievementHandlerBase.ServerAchieve(disarmerHub.networkIdentity.connectionToClient, AchievementName.JustResources);
			}
		}

		private void HandleDeath(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is AttackerDamageHandler attackerDamageHandler && !(attackerDamageHandler.Attacker.Hub == null))
			{
				ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
				if (hub.GetTeam() == Team.Scientists && deadPlayer.GetTeam() == Team.ClassD && !_interactedPlayers.Contains(deadPlayer))
				{
					_interactedPlayers.Add(hub);
					AchievementHandlerBase.ServerAchieve(hub.networkIdentity.connectionToClient, AchievementName.JustResources);
				}
			}
		}
	}
}
