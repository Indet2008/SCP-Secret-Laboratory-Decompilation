using System.Collections.Generic;
using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using Respawning.Waves.Generic;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace Respawning.Waves
{
	public abstract class MiniWaveBase<TMainWave, TCounterWave> : TimeBasedWave, IMiniWave, ILimitedWave where TMainWave : SpawnableWaveBase where TCounterWave : SpawnableWaveBase
	{
		public const float TimeLeftReductionThreshold = 120f;

		public const float TeamDeathSecondsCompensation = 5f;

		public const float InfluenceNeededToUnlock = 10f;

		public const float SecondsIncreasePenalization = 60f;

		public const float AvailabilityDuration = 150f;

		public const float InfluencePerSpectator = 2f;

		private float _cachedInfluenceCount;

		private float _availabilityTimer;

		private bool _mainWaveSpawned;

		private bool _waveFailedObjective;

		public override float InitialSpawnInterval => 150f;

		public float WaveSizeMultiplier { get; set; } = 0.2f;

		public override int MaxWaveSize => Mathf.CeilToInt((float)ReferenceHub.AllHubs.Count * WaveSizeMultiplier);

		public override bool ReceiveObjectiveRewards => false;

		public override bool PauseOnTrigger => false;

		public int InitialRespawnTokens { get; set; }

		public int RespawnTokens { get; set; }

		public virtual RoleTypeId DefaultRole { get; set; }

		public virtual RoleTypeId SpecialRole { get; set; }

		public void Unlock(bool ignoreConfig = false)
		{
			if (ignoreConfig || !NetworkServer.active || Configuration.IsEnabled)
			{
				RespawnTokens = 1;
				WaveUpdateMessage.ServerSendUpdate(this, UpdateMessageFlags.Tokens);
			}
		}

		public void ResetTokens()
		{
			RespawnTokens = InitialRespawnTokens;
			WaveUpdateMessage.ServerSendUpdate(this, UpdateMessageFlags.Tokens);
		}

		public float GetInfluenceDifference(float? newValue)
		{
			if (!newValue.HasValue)
			{
				newValue = FactionInfluenceManager.Get(TargetFaction);
			}
			return newValue.Value - _cachedInfluenceCount;
		}

		public override void PopulateQueue(Queue<RoleTypeId> queueToFill, int playersToSpawn)
		{
			queueToFill.Enqueue(SpecialRole);
			for (int i = 0; i < playersToSpawn - 1; i++)
			{
				queueToFill.Enqueue(DefaultRole);
			}
		}

		protected override void OnAnyWaveSpawned(SpawnableWaveBase wave, List<ReferenceHub> _)
		{
			_mainWaveSpawned = wave is TMainWave;
			if (wave == this && WaveManager.TryGet<TMainWave>(out var spawnWave) && spawnWave is TimeBasedWave timeBasedWave)
			{
				Unlock();
				timeBasedWave.Timer.AddTime(-60f);
				return;
			}
			base.Timer.Reset();
			if (!_mainWaveSpawned)
			{
				ResetTokens();
				return;
			}
			int num = ReferenceHub.AllHubs.Count((ReferenceHub h) => h.roleManager.CurrentRole is SpectatorRole spectatorRole && spectatorRole.ReadyToRespawn);
			float num2 = 2f * (float)num;
			_waveFailedObjective = false;
			_availabilityTimer = Time.time + 150f;
			_cachedInfluenceCount = FactionInfluenceManager.Get(TargetFaction) - num2;
		}

		public override void OnWaveSpawned()
		{
		}

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			PlayerStats.OnAnyPlayerDied += OnPlayerDeath;
			FactionInfluenceManager.InfluenceModified += OnInfluenceModified;
			StaticUnityMethods.OnUpdate += OnUpdate;
		}

		protected override void OnInstanceReset()
		{
			base.OnInstanceReset();
			_availabilityTimer = 0f;
			_cachedInfluenceCount = 0f;
			_mainWaveSpawned = false;
			_waveFailedObjective = false;
		}

		protected override void OnInstanceDestroyed()
		{
			base.OnInstanceDestroyed();
			PlayerStats.OnAnyPlayerDied -= OnPlayerDeath;
			FactionInfluenceManager.InfluenceModified -= OnInfluenceModified;
			StaticUnityMethods.OnUpdate -= OnUpdate;
		}

		private void OnPlayerDeath(ReferenceHub victim, DamageHandlerBase dh)
		{
			if (_mainWaveSpawned && !(base.Timer.TimeLeft <= 120f) && victim.GetFaction() == TargetFaction)
			{
				base.Timer.AddTime(5f);
			}
		}

		private void OnInfluenceModified(Faction faction, float newValue)
		{
			if (_mainWaveSpawned && TargetFaction == faction && !(_availabilityTimer <= Time.time) && !(GetInfluenceDifference(newValue) < 10f))
			{
				Unlock();
			}
		}

		private void OnUpdate()
		{
			if (_mainWaveSpawned && RespawnTokens <= 0 && !_waveFailedObjective && !(_availabilityTimer > Time.time))
			{
				_waveFailedObjective = true;
				if (WaveManager.TryGet<TCounterWave>(out var spawnWave) && spawnWave is IMiniWave miniWave)
				{
					miniWave.Unlock();
				}
			}
		}
	}
}
