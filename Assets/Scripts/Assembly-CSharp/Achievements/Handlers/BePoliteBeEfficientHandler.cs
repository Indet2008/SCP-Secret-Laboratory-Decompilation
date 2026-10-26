using System.Collections.Generic;
using System.Diagnostics;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class BePoliteBeEfficientHandler : AchievementHandlerBase
	{
		private const float TimeLimit = 30f;

		private const int KillsTarget = 5;

		private static readonly Dictionary<ReferenceHub, Stopwatch> Timers = new Dictionary<ReferenceHub, Stopwatch>();

		private static readonly Dictionary<ReferenceHub, int> Kills = new Dictionary<ReferenceHub, int>();

		private static readonly HashSet<uint> AlreadyAchieved = new HashSet<uint>();

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDied += HandleDeath;
		}

		internal override void OnRoundStarted()
		{
			Kills.Clear();
			Timers.Clear();
			AlreadyAchieved.Clear();
		}

		private static void HandleDeath(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is FirearmDamageHandler { Attacker: { Hub: var hub } attacker } && HitboxIdentity.IsEnemy(attacker.Role, deadPlayer.GetRoleId()) && !AlreadyAchieved.Contains(attacker.NetId) && !(hub == null))
			{
				if (!Kills.TryGetValue(hub, out var value))
				{
					value = 0;
				}
				value = (Kills[hub] = value + 1);
				if (!Timers.TryGetValue(hub, out var value2))
				{
					Timers.Add(hub, Stopwatch.StartNew());
				}
				else if (value2.Elapsed.TotalSeconds > 30.0)
				{
					Timers[hub].Restart();
					Kills[hub] = 1;
				}
				else if (value >= 5)
				{
					AlreadyAchieved.Add(attacker.NetId);
					Kills.Remove(attacker.Hub);
					Timers.Remove(attacker.Hub);
					AchievementHandlerBase.ServerAchieve(attacker.Hub.networkIdentity.connectionToClient, AchievementName.BePoliteBeEfficient);
				}
			}
		}
	}
}
