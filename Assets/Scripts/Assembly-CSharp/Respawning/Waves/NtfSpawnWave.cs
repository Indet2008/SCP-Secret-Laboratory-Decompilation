using System.Collections.Generic;
using PlayerRoles;
using Respawning.Announcements;
using Respawning.Config;
using Respawning.Waves.Generic;
using UnityEngine;

namespace Respawning.Waves
{
	public class NtfSpawnWave : TimeBasedWave, IAnimatedWave, ILimitedWave, IAnnouncedWave
	{
		public float CaptainPercent = 0.125f;

		public float SergeantPercent = 0.3f;

		public override float InitialSpawnInterval => 330f;

		public int InitialRespawnTokens { get; set; } = 1;

		public int RespawnTokens { get; set; }

		public override int MaxWaveSize
		{
			get
			{
				if (!(Configuration is PrimaryWaveConfig<NtfSpawnWave> primaryWaveConfig))
				{
					return 0;
				}
				return Mathf.CeilToInt((float)ReferenceHub.AllHubs.Count * primaryWaveConfig.SizePercentage);
			}
		}

		public override Faction TargetFaction => Faction.FoundationStaff;

		public float AnimationDuration => 17.95f;

		public bool IsAnimationPlaying { get; set; }

		public WaveAnnouncementBase Announcement { get; } = new NtfWaveAnnouncement(Team.FoundationForces);

		public override IWaveConfig Configuration { get; } = new PrimaryWaveConfig<NtfSpawnWave>();

		public override void PopulateQueue(Queue<RoleTypeId> queueToFill, int playersToSpawn)
		{
			int num = Mathf.FloorToInt((float)playersToSpawn * CaptainPercent);
			int num2 = Mathf.FloorToInt((float)playersToSpawn * SergeantPercent);
			for (int i = 0; i < num; i++)
			{
				queueToFill.Enqueue(RoleTypeId.NtfCaptain);
			}
			for (int j = 0; j < num2; j++)
			{
				queueToFill.Enqueue(RoleTypeId.NtfSergeant);
			}
			int num3 = num + num2;
			for (int k = 0; k < playersToSpawn - num3; k++)
			{
				queueToFill.Enqueue(RoleTypeId.NtfPrivate);
			}
		}
	}
}
