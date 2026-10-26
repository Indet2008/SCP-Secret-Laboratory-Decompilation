using System.Collections.Generic;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using Respawning.Waves;
using Respawning.Waves.Generic;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace Respawning
{
	public static class RespawnTokensManager
	{
		public class Milestone
		{
			public int Threshold;

			public bool Achieved;

			public Milestone(int threshold)
			{
				Threshold = threshold;
			}
		}

		public const int DefaultTokensCount = 1;

		private const int InitialTokensPool = 2;

		public static int AvailableRespawnsLeft { get; set; }

		public static Dictionary<Faction, List<Milestone>> Milestones { get; } = new Dictionary<Faction, List<Milestone>>
		{
			[Faction.FoundationStaff] = DefaultMilestone,
			[Faction.FoundationEnemy] = DefaultMilestone
		};

		private static List<Milestone> DefaultMilestone => new List<Milestone>
		{
			new Milestone(40),
			new Milestone(80),
			new Milestone(150),
			new Milestone(200)
		};

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			WaveManager.OnWaveUpdateMsgReceived += OnUpdateReceived;
			WaveManager.OnWaveSpawned += OnWaveSpawned;
			FactionInfluenceManager.InfluenceModified += OnPointsModified;
			CustomNetworkManager.OnClientReady += () =>
			{
				foreach (SpawnableWaveBase wave in WaveManager.Waves)
				{
					if (wave is ILimitedWave limitedWave)
					{
						limitedWave.RespawnTokens = limitedWave.InitialRespawnTokens;
					}
				}
				if (NetworkServer.active)
				{
					AvailableRespawnsLeft = 2;
					ResetMilestones();
				}
			};
		}

		public static bool TryGetNextThreshold(Faction faction, float influence, out int threshold)
		{
			Milestone milestone = Milestones[faction].FirstOrDefault((Milestone x) => influence < (float)x.Threshold, null);
			if (milestone == null)
			{
				threshold = -1;
				return false;
			}
			threshold = milestone.Threshold;
			return true;
		}

		private static void OnWaveSpawned(SpawnableWaveBase wave, List<ReferenceHub> _)
		{
			if (wave is ILimitedWave limitedWave)
			{
				limitedWave.RespawnTokens--;
				WaveUpdateMessage.ServerSendUpdate(wave, UpdateMessageFlags.Tokens);
			}
		}

		private static void ResetMilestones()
		{
			foreach (List<Milestone> value in Milestones.Values)
			{
				foreach (Milestone item in value)
				{
					item.Achieved = false;
				}
			}
		}

		private static bool TryAchieveMilestone(Faction faction, float influence)
		{
			foreach (Milestone item in Milestones[faction])
			{
				if (!item.Achieved && !((float)item.Threshold > influence))
				{
					AchievingMilestoneEventArgs e = new AchievingMilestoneEventArgs(faction, item.Threshold, Milestones[faction].IndexOf(item));
					ServerEvents.OnAchievingMilestone(e);
					if (e.IsAllowed)
					{
						item.Achieved = true;
						ServerEvents.OnAchievedMilestone(new AchievedMilestoneEventArgs(faction, item.Threshold, Milestones[faction].IndexOf(item)));
						return true;
					}
				}
			}
			return false;
		}

		private static void OnPointsModified(Faction faction, float newValue)
		{
			if (!NetworkServer.active || AvailableRespawnsLeft == 0 || !WaveManager.TryGet(faction, out var spawnWave) || !(spawnWave is ILimitedWave limitedWave))
			{
				return;
			}
			while (TryAchieveMilestone(faction, newValue))
			{
				limitedWave.RespawnTokens++;
				AvailableRespawnsLeft--;
				WaveUpdateMessage.ServerSendUpdate(spawnWave, UpdateMessageFlags.Tokens);
				if (AvailableRespawnsLeft != 0)
				{
					continue;
				}
				foreach (SpawnableWaveBase wave in WaveManager.Waves)
				{
					if (!(wave is IMiniWave))
					{
						WaveUpdateMessage.ServerSendUpdate(wave, UpdateMessageFlags.Max);
					}
				}
				break;
			}
			WaveUpdateMessage.ServerSendUpdate(spawnWave, UpdateMessageFlags.Tokens);
		}

		private static void OnUpdateReceived(WaveUpdateMessage msg)
		{
			if (msg.RespawnTokens.HasValue && msg.Wave is ILimitedWave limitedWave)
			{
				limitedWave.RespawnTokens = msg.RespawnTokens.Value;
			}
		}
	}
}
