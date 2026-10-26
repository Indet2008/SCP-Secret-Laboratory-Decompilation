using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class MutuallyAssuredDestructionHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
		}

		private static void OnAnyPlayerDied(ReferenceHub victim, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is AttackerDamageHandler attackerDamageHandler && ValidDamage(attackerDamageHandler))
			{
				ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
				if (!(hub == null) && !hub.IsAlive() && HitboxIdentity.IsEnemy(attackerDamageHandler.Attacker.Role, victim.GetRoleId()))
				{
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.MutuallyAssuredDestruction);
				}
			}
		}

		private static bool ValidDamage(AttackerDamageHandler attackerHandler)
		{
			if (attackerHandler is Scp018DamageHandler)
			{
				return true;
			}
			if (!(attackerHandler is ExplosionDamageHandler { ExplosionType: var explosionType }))
			{
				return false;
			}
			if (explosionType == ExplosionType.SCP018 || explosionType == ExplosionType.Grenade)
			{
				return true;
			}
			return false;
		}
	}
}
