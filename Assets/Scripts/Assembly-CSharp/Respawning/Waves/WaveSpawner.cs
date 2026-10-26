using System;
using System.Collections.Generic;
using System.Linq;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using LabApi.Features.Wrappers;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.Spectating;
using Respawning.NamingRules;
using UnityEngine;
using UnityEngine.Pool;
using Utils.NonAllocLINQ;

namespace Respawning.Waves
{
	public static class WaveSpawner
	{
		public const float TimePerPoint = 15f;

		private const float MaxRandomPoints = 0.25f;

		private const float MinPoints = 0f;

		private const float SameFactionPoints = 3f;

		private static readonly Dictionary<ReferenceHub, Team> PreviousTeam = new Dictionary<ReferenceHub, Team>();

		private static readonly System.Random WaveShuffleRandomizer = new System.Random();

		private static readonly Queue<RoleTypeId> SpawnQueue = new Queue<RoleTypeId>();

		public static bool AnyPlayersAvailable => ReferenceHub.AllHubs.Any(CanBeSpawned);

		public static ReferenceHub[] GetAvailablePlayers(Team spawningTeam, int? capCount = null)
		{
			return (from hub in ReferenceHub.AllHubs.Where(CanBeSpawned)
				orderby CalculatePriority(hub, spawningTeam) descending
				select hub).Take(capCount ?? int.MaxValue).ToArray();
		}

		public static ReferenceHub[] GetAvailablePlayers(Team spawningTeam, int capCount, bool randomizeResult)
		{
			ReferenceHub[] availablePlayers = GetAvailablePlayers(spawningTeam, capCount);
			if (randomizeResult)
			{
				availablePlayers.ShuffleList(WaveShuffleRandomizer);
			}
			return availablePlayers;
		}

		public static List<ReferenceHub> SpawnWave(SpawnableWaveBase wave)
		{
			int maxWaveSize = wave.MaxWaveSize;
			Team spawnableTeam = wave.TargetFaction.GetSpawnableTeam();
			List<ReferenceHub> list = NorthwoodLib.Pools.ListPool<ReferenceHub>.Shared.Rent();
			ReferenceHub[] availablePlayers = GetAvailablePlayers(spawnableTeam, maxWaveSize, wave.RandomizeRoleAssignment);
			int num = Mathf.Min(availablePlayers.Length, maxWaveSize);
			if (num <= 0)
			{
				return list;
			}
			if (NamingRulesManager.TryGetNamingRule(spawnableTeam, out var rule))
			{
				NamingRulesManager.ServerGenerateName(spawnableTeam, rule);
			}
			wave.PopulateQueue(SpawnQueue, num);
			RoleChangeReason reason = ((wave is IMiniWave) ? RoleChangeReason.RespawnMiniwave : RoleChangeReason.Respawn);
			Dictionary<ReferenceHub, RoleTypeId> dictionary = CollectionPool<Dictionary<ReferenceHub, RoleTypeId>, KeyValuePair<ReferenceHub, RoleTypeId>>.Get();
			ReferenceHub[] array = availablePlayers;
			foreach (ReferenceHub referenceHub in array)
			{
				if (list.Count >= maxWaveSize)
				{
					break;
				}
				try
				{
					RoleTypeId value = SpawnQueue.Dequeue();
					dictionary.Add(referenceHub, value);
				}
				catch (Exception ex)
				{
					if (referenceHub != null)
					{
						ServerLogs.AddLog(ServerLogs.Modules.ClassChange, "Player " + referenceHub.LoggedNameFromRefHub() + " couldn't be added to spawn wave. Err msg: " + ex.Message, ServerLogs.ServerLogType.GameEvent);
					}
					else
					{
						ServerLogs.AddLog(ServerLogs.Modules.ClassChange, "Couldn't add a player - target's ReferenceHub is null.", ServerLogs.ServerLogType.GameEvent);
					}
				}
			}
			WaveRespawningEventArgs e = new WaveRespawningEventArgs(wave, dictionary);
			ServerEvents.OnWaveRespawning(e);
			if (!e.IsAllowed)
			{
				list.Clear();
				CollectionPool<Dictionary<ReferenceHub, RoleTypeId>, KeyValuePair<ReferenceHub, RoleTypeId>>.Release(dictionary);
				SpawnQueue.Clear();
				return list;
			}
			dictionary.Clear();
			foreach (KeyValuePair<Player, RoleTypeId> role in e.Roles)
			{
				dictionary[role.Key.ReferenceHub] = role.Value;
			}
			CollectionPool<Dictionary<Player, RoleTypeId>, KeyValuePair<Player, RoleTypeId>>.Release(e.Roles);
			foreach (KeyValuePair<ReferenceHub, RoleTypeId> item in dictionary)
			{
				if (list.Count >= maxWaveSize)
				{
					break;
				}
				try
				{
					item.Key.roleManager.ServerSetRole(item.Value, reason);
					list.Add(item.Key);
					ServerLogs.AddLog(ServerLogs.Modules.ClassChange, "Player " + item.Key.LoggedNameFromRefHub() + " respawned as " + item.Value.ToString() + ".", ServerLogs.ServerLogType.GameEvent);
				}
				catch (Exception ex2)
				{
					if (item.Key != null)
					{
						ServerLogs.AddLog(ServerLogs.Modules.ClassChange, "Player " + item.Key.LoggedNameFromRefHub() + " couldn't be spawned. Err msg: " + ex2.Message, ServerLogs.ServerLogType.GameEvent);
					}
					else
					{
						ServerLogs.AddLog(ServerLogs.Modules.ClassChange, "Couldn't spawn a player - target's ReferenceHub is null.", ServerLogs.ServerLogType.GameEvent);
					}
				}
			}
			if (wave is IAnnouncedWave announcedWave)
			{
				announcedWave.Announcement.PlayAnnouncement(list, announcedWave);
			}
			ServerEvents.OnWaveRespawned(new WaveRespawnedEventArgs(wave, dictionary.Keys.Select(Player.Get).ToList()));
			if (list.Count > 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.ClassChange, string.Format("{0} has successfully spawned {1} players as {2}!", "WaveSpawner", list.Count, spawnableTeam), ServerLogs.ServerLogType.GameEvent);
			}
			SpawnQueue.Clear();
			CollectionPool<Dictionary<ReferenceHub, RoleTypeId>, KeyValuePair<ReferenceHub, RoleTypeId>>.Release(dictionary);
			return list;
		}

		public static float CalculatePriority(ReferenceHub hub, Team targetTeam)
		{
			float num = UnityEngine.Random.Range(0f, 0.25f);
			if (!(hub.roleManager.CurrentRole is SpectatorRole spectatorRole))
			{
				return 0f - num;
			}
			num += spectatorRole.ActiveTime / 15f;
			if (!PreviousTeam.TryGetValue(hub, out var value))
			{
				return num;
			}
			if (value == targetTeam)
			{
				num += 3f;
			}
			return num;
		}

		public static Team GetSpawnableTeam(this Faction faction)
		{
			return faction switch
			{
				Faction.FoundationEnemy => Team.ChaosInsurgency, 
				Faction.FoundationStaff => Team.FoundationForces, 
				_ => Team.OtherAlive, 
			};
		}

		public static bool CanBeSpawned(ReferenceHub player)
		{
			if (player.roleManager.CurrentRole is SpectatorRole spectatorRole)
			{
				return spectatorRole.ReadyToRespawn;
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
			CustomNetworkManager.OnClientReady += PreviousTeam.Clear;
		}

		private static void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			Team spawnableTeam = userHub.GetFaction().GetSpawnableTeam();
			PreviousTeam[userHub] = spawnableTeam;
		}
	}
}
