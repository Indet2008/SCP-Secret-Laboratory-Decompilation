using System;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles;
using UnityEngine;

namespace PlayerStatsSystem
{
	public static class DeathLogger
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
		}

		private static void HandleDeath(ReferenceHub ply, DamageHandlerBase handler)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append(ply.LoggedNameFromRefHub());
			stringBuilder.Append(", playing as ");
			stringBuilder.Append(ply.roleManager.CurrentRole.RoleName);
			stringBuilder.Append(", ");
			ServerLogs.ServerLogType type;
			if (handler is AttackerDamageHandler attackerDamageHandler)
			{
				if (attackerDamageHandler.IsSuicide)
				{
					type = ServerLogs.ServerLogType.Suicide;
					stringBuilder.Append("has commited suicide.");
				}
				else
				{
					if (attackerDamageHandler.IsFriendlyFire)
					{
						type = ServerLogs.ServerLogType.Teamkill;
						stringBuilder.Append("has been teamkilled by ");
					}
					else
					{
						type = ServerLogs.ServerLogType.KillLog;
						stringBuilder.Append("has been killed by ");
					}
					stringBuilder.Append(attackerDamageHandler.Attacker.Nickname);
					stringBuilder.Append(" (");
					stringBuilder.Append(attackerDamageHandler.Attacker.LogUserID);
					stringBuilder.Append(") playing as: ");
					stringBuilder.Append(attackerDamageHandler.Attacker.Role.TryGetRoleTemplate<PlayerRoleBase>(out var result) ? result.RoleName : "Unknown class");
					stringBuilder.Append(".");
				}
			}
			else
			{
				type = ServerLogs.ServerLogType.KillLog;
				stringBuilder.Append("has died.");
			}
			stringBuilder.Append(" Specific death reason: ");
			string serverLogsText = handler.ServerLogsText;
			stringBuilder.Append(serverLogsText);
			if (!serverLogsText.EndsWith(".", StringComparison.Ordinal))
			{
				stringBuilder.Append(".");
			}
			ServerLogs.AddLog(ServerLogs.Modules.ClassChange, stringBuilder.ToString(), type);
			StringBuilderPool.Shared.Return(stringBuilder);
		}
	}
}
