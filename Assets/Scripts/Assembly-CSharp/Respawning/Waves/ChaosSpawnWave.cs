using System.Collections.Generic;
using PlayerRoles;
using Respawning.Announcements;
using Respawning.Config;
using Respawning.Waves.Generic;
using UnityEngine;

namespace Respawning.Waves
{
	public class ChaosSpawnWave : TimeBasedWave, IAnimatedWave, ILimitedWave, IAnnouncedWave
	{
		public float LogicerPercent = 0.2f;

		public float ShotgunPercent = 0.3f;

		public override float InitialSpawnInterval => 330f;

		public int InitialRespawnTokens { get; set; } = 1;

		public int RespawnTokens { get; set; }

		public override int MaxWaveSize
		{
			get
			{
				if (!(Configuration is PrimaryWaveConfig<ChaosSpawnWave> primaryWaveConfig))
				{
					return 0;
				}
				return Mathf.CeilToInt((float)ReferenceHub.AllHubs.Count * primaryWaveConfig.SizePercentage);
			}
		}

		public override Faction TargetFaction => Faction.FoundationEnemy;

		public float AnimationDuration => 13.49f;

		public bool IsAnimationPlaying { get; set; }

		public WaveAnnouncementBase Announcement { get; } = new ChaosWaveAnnouncement();

		public override IWaveConfig Configuration { get; } = new PrimaryWaveConfig<ChaosSpawnWave>();

		public override void PopulateQueue(Queue<RoleTypeId> queueToFill, int playersToSpawn)
		{
			int num = Mathf.FloorToInt((float)playersToSpawn * LogicerPercent);
			int num2 = Mathf.FloorToInt((float)playersToSpawn * ShotgunPercent);
			for (int i = 0; i < num; i++)
			{
				queueToFill.Enqueue(RoleTypeId.ChaosRepressor);
			}
			for (int j = 0; j < num2; j++)
			{
				queueToFill.Enqueue(RoleTypeId.ChaosMarauder);
			}
			for (int k = 0; k < playersToSpawn - num2 - num; k++)
			{
				queueToFill.Enqueue(RoleTypeId.ChaosRifleman);
			}
		}
	}
}
