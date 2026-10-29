namespace LabApi.Features.Wrappers
{
	public abstract class RespawnWave
	{
		public global::Respawning.Waves.TimeBasedWave Base { get; private set; }

		public global::PlayerRoles.Faction Faction => Base.TargetFaction;

		public float AdditionalSecondsPerSpawn
		{
			get
			{
				return Base.AdditionalSecondsPerSpawn;
			}
			set
			{
				Base.AdditionalSecondsPerSpawn = value;
			}
		}

		public abstract int MaxWaveSize { get; set; }

		public float AnimationTime
		{
			get
			{
				if (Base is global::Respawning.Waves.IAnimatedWave animatedWave)
				{
					return animatedWave.AnimationDuration;
				}
				return 0f;
			}
		}

		public int RespawnTokens
		{
			get
			{
				if (Base is global::Respawning.Waves.Generic.ILimitedWave limitedWave)
				{
					return limitedWave.RespawnTokens;
				}
				return 0;
			}
			set
			{
				if (Base is global::Respawning.Waves.Generic.ILimitedWave limitedWave)
				{
					limitedWave.RespawnTokens = value;
					global::Respawning.WaveUpdateMessage.ServerSendUpdate(Base, global::Respawning.UpdateMessageFlags.Tokens);
				}
			}
		}

		public float Influence
		{
			get
			{
				return global::Respawning.FactionInfluenceManager.Get(Faction);
			}
			set
			{
				global::Respawning.FactionInfluenceManager.Set(Faction, value);
			}
		}

		public float TimeLeft
		{
			get
			{
				return Base.Timer.TimeLeft;
			}
			set
			{
				Base.Timer.SetTime(Base.Timer.SpawnIntervalSeconds - value);
			}
		}

		public float PausedTime
		{
			get
			{
				return Base.Timer.PauseTimeLeft;
			}
			set
			{
				Base.Timer.Pause(value);
			}
		}

		public bool IsForcefullyPaused
		{
			get
			{
				return Base.Timer.IsForcefullyPaused;
			}
			set
			{
				Base.Timer.IsForcefullyPaused = value;
			}
		}

		public float TimePassed => Base.Timer.TimePassed;

		internal RespawnWave(global::Respawning.Waves.TimeBasedWave wave)
		{
			Base = wave;
		}

		public bool TryGetCurrentMilestone(out int influenceThreshold)
		{
			return global::Respawning.RespawnTokensManager.TryGetNextThreshold(Faction, Influence, out influenceThreshold);
		}

		public virtual void InitiateRespawn()
		{
			global::Respawning.WaveManager.InitiateRespawn(Base);
		}

		public void InstantRespawn()
		{
			global::Respawning.WaveManager.Spawn(Base);
		}

		[global::System.Obsolete("Use PlayAnnouncement(IEnumerable<Player>) instead.", true)]
		public void PlayAnnouncement()
		{
			PlayAnnouncement(global::System.Array.Empty<global::LabApi.Features.Wrappers.Player>());
		}

		public void PlayAnnouncement(global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> spawnedPlayers)
		{
			if (Base is global::Respawning.Waves.IAnnouncedWave announcedWave)
			{
				announcedWave.Announcement.PlayAnnouncement(global::System.Linq.Enumerable.ToList(global::System.Linq.Enumerable.Select(spawnedPlayers, (global::LabApi.Features.Wrappers.Player p) => p.ReferenceHub)), announcedWave);
			}
		}

		public void PlayRespawnEffect()
		{
			if (Base is global::Respawning.Waves.IAnimatedWave)
			{
				global::Respawning.WaveUpdateMessage.ServerSendUpdate(Base, global::Respawning.UpdateMessageFlags.Trigger);
			}
		}
	}
}
