using System.Collections.Generic;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class TrilateralTerminationHandler : AchievementHandlerBase
	{
		private const int KillsNeeded = 3;

		private static readonly Dictionary<ReferenceHub, int> Kills = new Dictionary<ReferenceHub, int>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		internal override void OnRoundStarted()
		{
			Kills.Clear();
		}

		private static void OnServerRoleSet(ReferenceHub hub, RoleTypeId roleTypeId, RoleChangeReason changeReason)
		{
			if (changeReason != RoleChangeReason.Escaped)
			{
				Kills.Remove(hub);
			}
		}

		private static void OnAnyPlayerDied(ReferenceHub victim, DamageHandlerBase handler)
		{
			if (!NetworkServer.active || !(handler is AttackerDamageHandler attackerDamageHandler) || (!(handler is DisruptorDamageHandler) && !(handler is ExplosionDamageHandler { ExplosionType: ExplosionType.Disruptor })))
			{
				return;
			}
			ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
			if (!(hub == null) && HitboxIdentity.IsEnemy(attackerDamageHandler.Attacker.Role, victim.GetRoleId()))
			{
				if (!Kills.TryGetValue(hub, out var value))
				{
					value = 0;
				}
				value = (Kills[hub] = value + 1);
				if (value >= 3)
				{
					Kills.Remove(hub);
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.TrilateralTermination);
				}
			}
		}
	}
}
