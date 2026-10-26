using System;
using GameCore;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using Respawning;
using Respawning.Waves;
using Respawning.Waves.Generic;
using UnityEngine;
using Utils.Networking;

public static class DeadmanSwitch
{
	public struct DeadMansSequenceActiveMessage : NetworkMessage
	{
		public bool IsActive;
	}

	private const float DefaultActivationTime = 240f;

	private const float WaveSpawnActivationTime = 210f;

	private const float MiniWaveSpawnActivationDelay = 60f;

	private const float ScpHealMaxHpPercentage = 0.3f;

	private const float ScpHealHpFlat = 250f;

	private static bool _forceCountdownToggle;

	private static float _countdownTimer;

	public static bool ForceCountdownToggle
	{
		get
		{
			return _forceCountdownToggle;
		}
		set
		{
			if (!value)
			{
				Reset();
			}
			_forceCountdownToggle = value;
		}
	}

	public static bool IsSequenceActive { get; private set; }

	public static bool IsDeadmanSwitchEnabled { get; private set; }

	public static float CountdownTimeLeft
	{
		get
		{
			return _countdownTimer;
		}
		set
		{
			_countdownTimer = Mathf.Min(value, CountdownMaxTime);
		}
	}

	public static float CountdownMaxTime { get; set; }

	public static void Reset(bool resetSequence = true)
	{
		_countdownTimer = ConfigFile.ServerConfig.GetFloat("dms_activation_time", 240f);
		if (resetSequence)
		{
			IsSequenceActive = false;
			new DeadMansSequenceActiveMessage
			{
				IsActive = false
			}.SendToAuthenticated();
		}
	}

	public static void InitiateProtocol()
	{
		DeadmanSequenceActivatingEventArgs e = new DeadmanSequenceActivatingEventArgs();
		ServerEvents.OnDeadmanSequenceActivating(e);
		if (!e.IsAllowed)
		{
			Reset();
			return;
		}
		IsSequenceActive = true;
		new DeadMansSequenceActiveMessage
		{
			IsActive = true
		}.SendToAuthenticated();
		StartWarhead();
		ServerEvents.OnDeadmanSequenceActivated();
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		CustomNetworkManager.OnClientReady += () =>
		{
			ReloadConfigs();
			_forceCountdownToggle = false;
			IsSequenceActive = false;
			NetworkClient.ReplaceHandler<DeadMansSequenceActiveMessage>(ClientMessageReceived);
		};
		StaticUnityMethods.OnUpdate += OnUpdate;
		WaveManager.OnWaveTrigger += OnWaveSpawned;
		ReferenceHub.OnPlayerAdded += SyncValues;
		ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(ReloadConfigs));
	}

	private static void OnWaveSpawned(SpawnableWaveBase wave)
	{
		if (wave is IMiniWave)
		{
			CountdownTimeLeft += 60f;
		}
		else if (!IsSequenceActive && !(CountdownTimeLeft >= 210f))
		{
			CountdownTimeLeft = 210f;
		}
	}

	private static void ReloadConfigs()
	{
		IsDeadmanSwitchEnabled = ConfigFile.ServerConfig.GetBool("dms_enabled", def: true);
		CountdownMaxTime = ConfigFile.ServerConfig.GetFloat("dms_activation_time", 240f);
		Reset(resetSequence: false);
	}

	private static void OnUpdate()
	{
		if (!NetworkServer.active || !AlphaWarheadController.SingletonSet || AlphaWarheadController.Singleton.AlreadyDetonated || IsSequenceActive)
		{
			return;
		}
		if (!ForceCountdownToggle)
		{
			if (!IsDeadmanSwitchEnabled || !WaveManager.TryGet<NtfSpawnWave>(out var spawnWave) || !WaveManager.TryGet<ChaosSpawnWave>(out var spawnWave2))
			{
				return;
			}
			ILimitedWave limitedWave = spawnWave;
			if (limitedWave == null)
			{
				return;
			}
			ILimitedWave limitedWave2 = spawnWave2;
			if (limitedWave2 == null || limitedWave.RespawnTokens > 0 || limitedWave2.RespawnTokens > 0)
			{
				return;
			}
		}
		_countdownTimer -= Time.deltaTime;
		if (!(_countdownTimer >= 0f))
		{
			InitiateProtocol();
		}
	}

	private static void StartWarhead()
	{
		AlphaWarheadController singleton = AlphaWarheadController.Singleton;
		AlphaWarheadSyncInfo info = singleton.Info;
		if (info.ScenarioType != WarheadScenarioType.DeadmanSwitch)
		{
			info.ScenarioType = WarheadScenarioType.DeadmanSwitch;
			singleton.NetworkInfo = info;
			OnActivationHeal();
			singleton.InstantPrepare();
			singleton.StartDetonation();
			singleton.IsLocked = true;
		}
	}

	private static void OnActivationHeal()
	{
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			PlayerRoleBase currentRole = allHub.roleManager.CurrentRole;
			if (currentRole.Team == Team.SCPs && currentRole.RoleTypeId != RoleTypeId.Scp0492 && currentRole is IHealthbarRole)
			{
				HealthStat module = allHub.playerStats.GetModule<HealthStat>();
				float num = module.MaxValue * 0.3f;
				float num2 = 250f;
				if (module.CurValue + 250f > module.MaxValue)
				{
					num2 = module.MaxValue - module.CurValue;
				}
				if (module.CurValue >= num)
				{
					module.CurValue += num2;
				}
				else
				{
					module.CurValue = num + 250f;
				}
			}
		}
	}

	private static void ClientMessageReceived(DeadMansSequenceActiveMessage message)
	{
		if (!NetworkServer.active)
		{
			IsSequenceActive = message.IsActive;
		}
	}

	private static void SyncValues(ReferenceHub hub)
	{
		if (NetworkServer.active)
		{
			hub.connectionToClient.Send(new DeadMansSequenceActiveMessage
			{
				IsActive = IsSequenceActive
			});
		}
	}
}
