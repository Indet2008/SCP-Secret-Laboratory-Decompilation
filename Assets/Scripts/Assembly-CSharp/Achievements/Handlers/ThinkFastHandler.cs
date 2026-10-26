using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class ThinkFastHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
		}

		private static void OnAnyPlayerDied(ReferenceHub victim, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is AttackerDamageHandler attackerDamageHandler && (handler is Scp018DamageHandler || handler is ExplosionDamageHandler { ExplosionType: ExplosionType.SCP018 }))
			{
				ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
				if (!(hub == null) && HitboxIdentity.IsEnemy(attackerDamageHandler.Attacker.Role, victim.GetRoleId()))
				{
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.ThinkFast);
				}
			}
		}
	}
}
