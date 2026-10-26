using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Achievements;
using Footprinting;
using GameCore;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Usables.Scp244;
using LabApi.Events.Arguments.WarheadEvents;
using LabApi.Events.Handlers;
using LightContainmentZoneDecontamination;
using MapGeneration;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using Subtitles;
using UnityEngine;
using Utils.Networking;
using Utils.NonAllocLINQ;

public class AlphaWarheadController : NetworkBehaviour
{
	[Serializable]
	public class DetonationScenario
	{
		public AlphaWarheadScenarioAnnouncer Announcer;

		public int TimeToDetonate;

		public float AdditionalTime;

		public float TotalTime => (float)TimeToDetonate + AdditionalTime;
	}

	public DetonationScenario[] StartScenarios;

	public DetonationScenario[] ResumeScenarios;

	public DetonationScenario DeadmanSwitchScenario;

	public byte DefaultScenarioId;

	[SyncVar]
	public AlphaWarheadSyncInfo Info;

	[SyncVar]
	public double CooldownEndTime;

	internal static bool AutoWarheadBroadcastEnabled;

	internal static string WarheadBroadcastMessage;

	internal static string WarheadExplodedBroadcastMessage;

	internal static ushort WarheadBroadcastMessageTime;

	internal static ushort WarheadExplodedBroadcastMessageTime;

	internal static bool LockGatesOnCountdown;

	public const float InevitableTime = 10f;

	private bool _doorsAlreadyOpen;

	private bool _blastDoorsShut;

	private bool _openDoors;

	private int _cooldown;

	private bool _isAutomatic;

	private bool _fogEnabled;

	private float _autoDetonateTime;

	private bool _autoDetonate;

	private bool _autoDetonateLock;

	private Footprint _triggeringPlayer;

	private AlphaWarheadSyncInfo _prevInfo;

	private AlphaWarheadScenarioAnnouncer _lastAnnouncer;

	public bool AlreadyDetonated { get; private set; }

	public DetonationScenario CurScenario => Info.ScenarioType switch
	{
		WarheadScenarioType.Start => StartScenarios[Info.ScenarioId], 
		WarheadScenarioType.Resume => ResumeScenarios[Info.ScenarioId], 
		WarheadScenarioType.DeadmanSwitch => DeadmanSwitchScenario, 
		_ => null, 
	};

	public int WarheadKills { get; private set; }

	public bool IsLocked { get; set; }

	public static AlphaWarheadController Singleton { get; private set; }

	public static bool SingletonSet { get; private set; }

	public static ReferenceHub WarheadTriggeredby
	{
		get
		{
			if (!SingletonSet)
			{
				return null;
			}
			return Singleton._triggeringPlayer.Hub;
		}
	}

	public static bool Detonated
	{
		get
		{
			if (InProgress)
			{
				return TimeUntilDetonation == 0f;
			}
			return false;
		}
	}

	public static bool InProgress
	{
		get
		{
			if (SingletonSet)
			{
				return Singleton.Info.InProgress;
			}
			return false;
		}
	}

	public static float TimeUntilDetonation => Mathf.Max(0f, (float)(Singleton.Info.StartTime + (double)Singleton.CurScenario.TotalTime - NetworkTime.time));

	public AlphaWarheadSyncInfo NetworkInfo
	{
		get
		{
			return Info;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref Info, 1uL, null);
		}
	}

	public double NetworkCooldownEndTime
	{
		get
		{
			return CooldownEndTime;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref CooldownEndTime, 2uL, null);
		}
	}

	public static event Action<bool> OnProgressChanged;

	public static event Action OnDetonated;

	private void Awake()
	{
		Singleton = this;
		SingletonSet = true;
	}

	private void Start()
	{
		if (!NetworkServer.active)
		{
			return;
		}
		NetworkCooldownEndTime = 0.0;
		_autoDetonateTime = ConfigFile.ServerConfig.GetFloat("auto_warhead_start_minutes") * 60f;
		_autoDetonate = _autoDetonateTime > 0f;
		_autoDetonateLock = ConfigFile.ServerConfig.GetBool("auto_warhead_lock");
		_openDoors = ConfigFile.ServerConfig.GetBool("open_doors_on_countdown", def: true);
		_cooldown = ConfigFile.ServerConfig.GetInt("warhead_cooldown", 40);
		AlphaWarheadSyncInfo networkInfo = default;
		int num = ConfigFile.ServerConfig.GetInt("warhead_tminus_start_duration", 90);
		networkInfo.ScenarioId = DefaultScenarioId;
		for (byte b = 0; b < StartScenarios.Length; b++)
		{
			if (StartScenarios[b].TimeToDetonate == num)
			{
				networkInfo.ScenarioId = b;
			}
		}
		NetworkInfo = networkInfo;
		ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(OnConfigReloaded));
	}

	private void OnDestroy()
	{
		SingletonSet = false;
		ConfigFile.OnConfigReloaded = (Action)Delegate.Remove(ConfigFile.OnConfigReloaded, new Action(OnConfigReloaded));
	}

	private void Update()
	{
		if (Info != _prevInfo)
		{
			OnInfoUpdated();
			_prevInfo = Info;
		}
		if (Info.InProgress)
		{
			_lastAnnouncer.UpdateActive();
		}
		UpdateFog();
		UpdateScreens();
		ServerUpdateDetonationTime();
		ServerUpdateAutonuke();
	}

	private int _lastScreenSecond = int.MinValue;

	private void UpdateScreens()
	{
		int num;
		string text;
		bool showInevitableWarn = false;
		if (Detonated && Info.InProgress)
		{
			num = -1;
			text = "<color=red>DETONATED</color>";
		}
		else if (Info.InProgress)
		{
			float timeUntilDetonation = TimeUntilDetonation;
			num = Mathf.CeilToInt(timeUntilDetonation * 10f);
			text = "<color=red>" + timeUntilDetonation.ToString("00.0", System.Globalization.CultureInfo.InvariantCulture) + "</color>";
			showInevitableWarn = timeUntilDetonation <= 10f;
		}
		else
		{
			num = -2;
			text = (IsLocked ? "<color=orange>LOCKED</color>" : (AlphaWarheadActivationPanel.IsUnlocked ? "<color=green>READY</color>" : "<color=#8f8f8f>STANDBY</color>"));
			num -= (IsLocked ? 1 : 0) + (AlphaWarheadActivationPanel.IsUnlocked ? 2 : 0);
		}
		if (num != _lastScreenSecond)
		{
			_lastScreenSecond = num;
			AlphaWarheadScreen.SetScreen(text, showInevitableWarn);
		}
	}

	private static bool TryGetBroadcaster(out Broadcast broadcaster)
	{
		broadcaster = null;
		if (ReferenceHub.TryGetLocalHub(out var hub))
		{
			return hub.TryGetComponent<Broadcast>(out broadcaster);
		}
		return false;
	}

	private void OnInfoUpdated()
	{
		bool inProgress = Info.InProgress;
		if (inProgress == _prevInfo.InProgress)
		{
			return;
		}
		OnProgressChanged?.Invoke(inProgress);
		if (inProgress)
		{
			if (_lastAnnouncer != null)
			{
				_lastAnnouncer.Clear();
			}
			_lastAnnouncer = CurScenario.Announcer;
			_lastAnnouncer.OnStarted();
		}
		else if (_lastAnnouncer != null)
		{
			_lastAnnouncer.OnCancelled();
		}
	}

	public void ForceTime(float remaining)
	{
		InstantPrepare();
		StartDetonation(isAutomatic: false, suppressSubtitles: true);
		AlphaWarheadSyncInfo info = Info;
		remaining -= CurScenario.TotalTime;
		info.StartTime = NetworkTime.time + (double)remaining;
		NetworkInfo = info;
	}

	public void InstantPrepare()
	{
		AlphaWarheadSyncInfo info = Info;
		info.StartTime = 0.0;
		NetworkInfo = info;
		NetworkCooldownEndTime = 0.0;
	}

	public void StartDetonation(bool isAutomatic = false, bool suppressSubtitles = false, ReferenceHub trigger = null)
	{
		if (Info.InProgress || CooldownEndTime > NetworkTime.time || IsLocked)
		{
			return;
		}
		AlphaWarheadSyncInfo info = Info;
		info.StartTime = NetworkTime.time;
		WarheadStartingEventArgs e = new WarheadStartingEventArgs((trigger == null) ? ReferenceHub.HostHub : trigger, isAutomatic, suppressSubtitles, info);
		WarheadEvents.OnStarting(e);
		if (!e.IsAllowed)
		{
			return;
		}
		isAutomatic = e.IsAutomatic;
		suppressSubtitles = e.SuppressSubtitles;
		info = e.WarheadState;
		trigger = e.Player.ReferenceHub;
		_isAutomatic = isAutomatic;
		AlreadyDetonated = false;
		if (isAutomatic)
		{
			IsLocked |= _autoDetonateLock;
			if (!AlreadyDetonated && !Info.InProgress && AutoWarheadBroadcastEnabled && TryGetBroadcaster(out var broadcaster))
			{
				broadcaster.RpcAddElement(WarheadBroadcastMessage, WarheadBroadcastMessageTime, Broadcast.BroadcastFlags.Normal);
			}
			_autoDetonate = false;
		}
		_doorsAlreadyOpen = false;
		ServerLogs.AddLog(ServerLogs.Modules.Warhead, "Countdown started.", ServerLogs.ServerLogType.GameEvent);
		_triggeringPlayer = new Footprint(trigger);
		NetworkInfo = info;
		WarheadEvents.OnStarted(new WarheadStartedEventArgs((trigger == null) ? ReferenceHub.HostHub : trigger, isAutomatic, suppressSubtitles, info));
		if (!suppressSubtitles)
		{
			SubtitleType subtitle = CurScenario.Announcer.Subtitle;
			string text = CurScenario.TimeToDetonate.ToString();
			new SubtitleMessage(new SubtitlePart(subtitle, text)).SendToAuthenticated();
		}
	}

	public void CancelDetonation()
	{
		CancelDetonation(null);
	}

	public void CancelDetonation(ReferenceHub disabler)
	{
		if (!Info.InProgress || TimeUntilDetonation <= 10f || IsLocked)
		{
			return;
		}
		AlphaWarheadSyncInfo info = Info;
		WarheadStoppingEventArgs e = new WarheadStoppingEventArgs((disabler == null) ? ReferenceHub.HostHub : disabler, info);
		WarheadEvents.OnStopping(e);
		if (!e.IsAllowed)
		{
			return;
		}
		info = e.WarheadState;
		disabler = e.Player.ReferenceHub;
		ServerLogs.AddLog(ServerLogs.Modules.Warhead, "Detonation cancelled.", ServerLogs.ServerLogType.GameEvent);
		if (TimeUntilDetonation <= 15f && disabler != null)
		{
			AchievementHandlerBase.ServerAchieve(disabler.connectionToClient, AchievementName.ThatWasClose);
		}
		info.StartTime = 0.0;
		int num = (int)Mathf.Min(TimeUntilDetonation, CurScenario.TimeToDetonate);
		int num2 = int.MaxValue;
		info.ScenarioType = WarheadScenarioType.Resume;
		for (byte b = 0; b < ResumeScenarios.Length; b++)
		{
			int num3 = ResumeScenarios[b].TimeToDetonate - num;
			if (num3 >= 0 && num3 <= num2)
			{
				num2 = num3;
				info.ScenarioId = b;
			}
		}
		NetworkInfo = info;
		NetworkCooldownEndTime = NetworkTime.time + (double)_cooldown;
		DoorEventOpenerExtension.TriggerAction(DoorEventOpenerExtension.OpenerEventType.WarheadCancel);
		if (NetworkServer.active)
		{
			_isAutomatic = false;
			new SubtitleMessage(new SubtitlePart(SubtitleType.AlphaWarheadCancelled, (string[])null)).SendToAuthenticated();
			WarheadEvents.OnStopped(new WarheadStoppedEventArgs((disabler == null) ? ReferenceHub.HostHub : disabler, info));
		}
	}

	private void Detonate()
	{
		ReferenceHub hub = ((_triggeringPlayer.Hub == null) ? ReferenceHub.HostHub : _triggeringPlayer.Hub);
		WarheadDetonatingEventArgs e = new WarheadDetonatingEventArgs(hub);
		WarheadEvents.OnDetonating(e);
		if (!e.IsAllowed)
		{
			return;
		}
		_triggeringPlayer = new Footprint(e.Player.ReferenceHub);
		OnDetonated?.Invoke();
		if (_isAutomatic && !AlreadyDetonated && !Info.InProgress && AutoWarheadBroadcastEnabled && TryGetBroadcaster(out var broadcaster))
		{
			broadcaster.RpcAddElement(WarheadExplodedBroadcastMessage, WarheadExplodedBroadcastMessageTime, Broadcast.BroadcastFlags.Normal);
		}
		ServerLogs.AddLog(ServerLogs.Modules.Warhead, "Warhead detonated.", ServerLogs.ServerLogType.GameEvent);
		if (DecontaminationController.Singleton.DecontaminationOverride != DecontaminationController.DecontaminationStatus.Disabled)
		{
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, "LCZ decontamination has been disabled by detonation of the Alpha Warhead.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			DecontaminationController.Singleton.DecontaminationOverride = DecontaminationController.DecontaminationStatus.Disabled;
		}
		AlreadyDetonated = true;
		HashSet<Team> hashSet = new HashSet<Team>();
		foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
		{
			PlayerRoleBase currentRole = allHub.roleManager.CurrentRole;
			if (allHub.IsAlive() && (!(currentRole is IFpcRole fpcRole) || CanBeDetonated(fpcRole.FpcModule.Position)))
			{
				hashSet.Add(allHub.GetTeam());
				if (allHub.playerStats.DealDamage(new WarheadDamageHandler()))
				{
					WarheadKills++;
				}
			}
		}
		foreach (Scp244DeployablePickup instance in Scp244DeployablePickup.Instances)
		{
			if (CanBeDetonated(instance.transform.position, includeOnlyLifts: true))
			{
				instance.DestroySelf();
			}
		}
		foreach (DoorVariant allDoor in DoorVariant.AllDoors)
		{
			if (allDoor is ElevatorDoor elevatorDoor)
			{
				elevatorDoor.NetworkActiveLocks = (ushort)(elevatorDoor.ActiveLocks | 4);
			}
		}
		RpcShake(achieve: true);
		WarheadEvents.OnDetonated(new WarheadDetonatedEventArgs(hub));
	}

	private static bool CanBeDetonated(Vector3 pos, bool includeOnlyLifts = false)
	{
		if (pos.GetZone() != FacilityZone.Surface && !includeOnlyLifts)
		{
			return true;
		}
		foreach (ElevatorChamber allChamber in ElevatorChamber.AllChambers)
		{
			if (allChamber.WorldspaceBounds.Contains(pos))
			{
				return true;
			}
		}
		return false;
	}

	private void OnConfigReloaded()
	{
		if (!InProgress)
		{
			return;
		}
		foreach (DoorVariant allDoor in DoorVariant.AllDoors)
		{
			if (allDoor is PryableDoor pryableDoor)
			{
				if (LockGatesOnCountdown)
				{
					pryableDoor.NetworkTargetState = true;
					pryableDoor.ServerChangeLock(DoorLockReason.Warhead, newState: true);
				}
				else
				{
					pryableDoor.ServerChangeLock(DoorLockReason.Warhead, newState: false);
				}
			}
		}
	}

	[ClientRpc]
	public void RpcShake(bool achieve)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteBool(achieve);
		SendRPCInternal("System.Void AlphaWarheadController::RpcShake(System.Boolean)", 1208415683, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	private void UpdateFog()
	{
	}

	[ServerCallback]
	private void ServerUpdateAutonuke()
	{
		if (NetworkServer.active && NetworkServer.active && RoundStart.RoundStarted && _autoDetonate && !AlreadyDetonated && !Info.InProgress && !(RoundStart.RoundLength.TotalSeconds < (double)_autoDetonateTime))
		{
			StartDetonation(isAutomatic: true);
		}
	}

	[ServerCallback]
	private void ServerUpdateDetonationTime()
	{
		if (!NetworkServer.active || !NetworkServer.active || !Info.InProgress)
		{
			return;
		}
		if (!_blastDoorsShut && TimeUntilDetonation < 2f)
		{
			_blastDoorsShut = true;
			BlastDoor.Instances.ForEach((BlastDoor x) =>
			{
				x.ServerSetTargetState(isOpen: false);
			});
		}
		if (_openDoors && !_doorsAlreadyOpen && TimeUntilDetonation < (float)CurScenario.TimeToDetonate)
		{
			_doorsAlreadyOpen = true;
			DoorEventOpenerExtension.TriggerAction(DoorEventOpenerExtension.OpenerEventType.WarheadStart);
		}
		if (!AlreadyDetonated && !(TimeUntilDetonation > 0f))
		{
			Detonate();
		}
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcShake__Boolean(bool achieve)
	{
	}

	protected static void InvokeUserCode_RpcShake__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcShake called on server.");
		}
		else
		{
			((AlphaWarheadController)obj).UserCode_RpcShake__Boolean(reader.ReadBool());
		}
	}

	static AlphaWarheadController()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(AlphaWarheadController), "System.Void AlphaWarheadController::RpcShake(System.Boolean)", InvokeUserCode_RpcShake__Boolean);
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteAlphaWarheadSyncInfo(Info);
			writer.WriteDouble(CooldownEndTime);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteAlphaWarheadSyncInfo(Info);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteDouble(CooldownEndTime);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref Info, null, reader.ReadAlphaWarheadSyncInfo());
			GeneratedSyncVarDeserialize(ref CooldownEndTime, null, reader.ReadDouble());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref Info, null, reader.ReadAlphaWarheadSyncInfo());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref CooldownEndTime, null, reader.ReadDouble());
		}
	}
}
