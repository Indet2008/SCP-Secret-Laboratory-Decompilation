using System.Collections.Generic;
using System.Diagnostics;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class HatsOffToYouHandler : AchievementHandlerBase
	{
		private const float KillWindowSeconds = 5f;

		private static readonly Dictionary<ReferenceHub, Stopwatch> Timers = new Dictionary<ReferenceHub, Stopwatch>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
			StatusEffectBase.OnDisabled += HandleEffectDisabled;
		}

		internal override void OnRoundStarted()
		{
			Timers.Clear();
		}

		private void HandleEffectDisabled(StatusEffectBase effectBase)
		{
			if (!NetworkServer.active || !(effectBase is Invisible invisible))
			{
				return;
			}
			if (Timers.TryGetValue(invisible.Hub, out var value))
			{
				if (value.Elapsed.TotalSeconds >= 5.0)
				{
					value.Restart();
				}
			}
			else
			{
				Timers[invisible.Hub] = Stopwatch.StartNew();
			}
		}

		private void HandleDeath(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (!NetworkServer.active || !(handler is AttackerDamageHandler attackerDamageHandler) || attackerDamageHandler.Attacker.Hub == null)
			{
				return;
			}
			ReferenceHub hub = attackerDamageHandler.Attacker.Hub;
			if (!hub.IsSCP() && HitboxIdentity.IsEnemy(hub, deadPlayer) && Timers.TryGetValue(hub, out var value))
			{
				if (value.Elapsed.TotalSeconds <= 5.0)
				{
					AchievementHandlerBase.ServerAchieve(hub.networkIdentity.connectionToClient, AchievementName.HatsOffToYou);
				}
				Timers.Remove(hub);
			}
		}
	}
}
