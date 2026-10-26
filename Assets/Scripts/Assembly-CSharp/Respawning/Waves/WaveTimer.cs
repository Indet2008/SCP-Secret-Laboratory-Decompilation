using MapGeneration;
using Mirror;
using Respawning.Waves.Generic;
using UnityEngine;

namespace Respawning.Waves
{
	public class WaveTimer
	{
		public const float CountdownPauseThresholdSeconds = 30f;

		private bool _isForcefullyPaused;

		private readonly TimeBasedWave _wave;

		private float _pauseTimer;

		public float TimePassed { get; private set; }

		public float DefaultSpawnInterval { get; set; }

		public float SpawnIntervalSeconds { get; set; }

		public float TimeLeft => SpawnIntervalSeconds - TimePassed;

		public bool IsReadyToSpawn => TimePassed >= SpawnIntervalSeconds;

		public bool IsPaused
		{
			get
			{
				if (!(_pauseTimer > Time.time) && !IsOutOfRespawns)
				{
					if (DeadmanSwitch.IsSequenceActive)
					{
						return !AlphaWarheadController.Detonated;
					}
					return false;
				}
				return true;
			}
		}

		public bool IsForcefullyPaused
		{
			get
			{
				return _isForcefullyPaused;
			}
			set
			{
				_isForcefullyPaused = value;
				if (NetworkServer.active)
				{
					WaveUpdateMessage.ServerSendUpdate(_wave, UpdateMessageFlags.None);
				}
			}
		}

		public float PauseTimeLeft => Mathf.Max(_pauseTimer - Time.time, 0f);

		private bool IsOutOfRespawns
		{
			get
			{
				if (_wave is ILimitedWave limitedWave)
				{
					return limitedWave.RespawnTokens <= 0;
				}
				return false;
			}
		}

		public WaveTimer(TimeBasedWave wave)
		{
			DefaultSpawnInterval = wave.InitialSpawnInterval;
			_wave = wave;
			StaticUnityMethods.OnUpdate += Update;
			SeedSynchronizer.OnGenerationFinished += OnMapGenerated;
			WaveManager.OnWaveUpdateMsgReceived += OnUpdateMessageReceived;
		}

		public void AddTime(float seconds)
		{
			SetTime(TimePassed + seconds);
		}

		public void SetTime(float seconds)
		{
			TimePassed = seconds;
			if (NetworkServer.active)
			{
				WaveUpdateMessage.ServerSendUpdate(_wave, UpdateMessageFlags.Timer);
			}
		}

		public void Reset(bool resetSpawnInterval = true)
		{
			TimePassed = 0f;
			if (resetSpawnInterval)
			{
				SpawnIntervalSeconds = DefaultSpawnInterval;
			}
			WaveUpdateMessage.ServerSendUpdate(_wave, UpdateMessageFlags.Timer);
		}

		public void Pause(float duration)
		{
			_pauseTimer = Time.time + duration;
			if (NetworkServer.active)
			{
				WaveUpdateMessage.ServerSendUpdate(_wave, UpdateMessageFlags.Pause);
			}
		}

		public void Destroy()
		{
			StaticUnityMethods.OnUpdate -= Update;
			SeedSynchronizer.OnGenerationFinished -= OnMapGenerated;
			WaveManager.OnWaveUpdateMsgReceived -= OnUpdateMessageReceived;
		}

		private void Update()
		{
			if (!IsForcefullyPaused && (!IsPaused || !(TimeLeft <= 30f)) && RoundSummary.RoundInProgress())
			{
				TimePassed += Time.deltaTime;
			}
		}

		private void OnUpdateMessageReceived(WaveUpdateMessage msg)
		{
			if (_wave == msg.Wave)
			{
				if (msg.SpawnIntervalSeconds.HasValue)
				{
					SpawnIntervalSeconds = msg.SpawnIntervalSeconds.Value;
				}
				if (msg.TimePassed.HasValue)
				{
					TimePassed = msg.TimePassed.Value;
				}
				if (msg.PauseDuration.HasValue)
				{
					_pauseTimer = msg.PauseDuration.Value;
				}
				_isForcefullyPaused = msg.IsForcePaused;
			}
		}

		private void OnMapGenerated()
		{
			Reset();
		}
	}
}
