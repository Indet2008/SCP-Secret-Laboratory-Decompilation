using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using CustomPlayerEffects;
using GameCore;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MEC;
using MapGeneration;
using Mirror;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp079;
using PlayerRoles.Spectating;
using Subtitles;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	public class DecontaminationController : NetworkBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		public global::LightContainmentZoneDecontamination.DecontaminationClientTimer ClientTimer;


		public enum DecontaminationStatus : byte
		{
			None = 0,
			Disabled = 1,
			Forced = 2
		}

		[Serializable]
		public struct DecontaminationPhase
		{
			public enum PhaseFunction : byte
			{
				None = 0,
				GloballyAudible = 1,
				OpenCheckpoints = 2,
				Final = 3
			}

			public float TimeTrigger;

			public float GameTime;

			public AudioClip AnnouncementLine;

			public PhaseFunction Function;
		}

		public static DecontaminationController Singleton;

		private static readonly ElevatorGroup[] GroupsToLock = new ElevatorGroup[4]
		{
			ElevatorGroup.LczA01,
			ElevatorGroup.LczA02,
			ElevatorGroup.LczB01,
			ElevatorGroup.LczB02
		};

		public DecontaminationPhase[] DecontaminationPhases;

		public AudioSource AnnouncementAudioSource;

		[SyncVar]
		public double RoundStartTime;

		public static bool AutoDeconBroadcastEnabled;

		public static string DeconBroadcastDeconMessage;

		public static ushort DeconBroadcastDeconMessageTime;

		private DecontaminationPhase.PhaseFunction _curFunction;

		private int _nextPhase;

		private float _prevVolume;

		private bool _stopUpdating;

		private bool _elevatorsDirty;

		private bool _decontaminationBegun;

		private float _justJoinedCooldown;

		[SyncVar(hook = "OnElevatorTextChanged")]
		private string _elevatorsLockedText;

		[SyncVar(hook = "OnChangeDisableDecontamination")]
		private DecontaminationStatus _decontaminationOverride;

		[SyncVar(hook = "OnTimeOffsetChanged")]
		private float _timeOffset;

		public static double GetServerTime => NetworkTime.time - Singleton.RoundStartTime + (double)Singleton.TimeOffset;

		public string ElevatorsLockedText
		{
			get
			{
				return _elevatorsLockedText;
			}
			set
			{
				Network_elevatorsLockedText = value;
			}
		}

		private bool IsAnnouncementHearable
		{
			get
			{
				if (!ReferenceHub.TryGetPovHub(out var hub))
				{
					return false;
				}
				if (_curFunction == DecontaminationPhase.PhaseFunction.Final)
				{
					return true;
				}
				if (_curFunction == DecontaminationPhase.PhaseFunction.GloballyAudible)
				{
					return true;
				}
				return hub.GetCurrentZone() == FacilityZone.LightContainment;
			}
		}

		public bool IsDecontaminating
		{
			get
			{
				if (NetworkServer.active)
				{
					return _decontaminationBegun;
				}
				return false;
			}
		}

		public float TimeOffset
		{
			get
			{
				return _timeOffset;
			}
			set
			{
				_justJoinedCooldown = 9f;
				Network_timeOffset = value;
			}
		}

		public DecontaminationStatus DecontaminationOverride
		{
			get
			{
				return _decontaminationOverride;
			}
			set
			{
				Network_decontaminationOverride = value;
				switch (value)
				{
				case DecontaminationStatus.Forced:
					FinishDecontamination();
					break;
				case DecontaminationStatus.None:
				case DecontaminationStatus.Disabled:
					if (NetworkServer.active)
					{
						EnableElevators();
						ServerDisableDecontamination();
					}
					break;
				}
			}
		}

		public double NetworkRoundStartTime
		{
			get
			{
				return RoundStartTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref RoundStartTime, 1uL, null);
			}
		}

		public string Network_elevatorsLockedText
		{
			get
			{
				return _elevatorsLockedText;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _elevatorsLockedText, 2uL, OnElevatorTextChanged);
			}
		}

		public DecontaminationStatus Network_decontaminationOverride
		{
			get
			{
				return _decontaminationOverride;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _decontaminationOverride, 4uL, OnChangeDisableDecontamination);
			}
		}

		public float Network_timeOffset
		{
			get
			{
				return _timeOffset;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _timeOffset, 8uL, OnTimeOffsetChanged);
			}
		}

		private void OnElevatorTextChanged(string oldValue, string newValue)
		{
			SetElevatorTextClient(newValue);
		}

		private void SetElevatorTextClient(string text)
		{
			DecontaminationElevatorScreen.SetAllTexts(text);
		}

		private void OnTimeOffsetChanged(float oldValue, float newValue)
		{
			_justJoinedCooldown = 9f;
		}

		public void OnChangeDisableDecontamination(DecontaminationStatus oldValue, DecontaminationStatus newValue)
		{
			if (oldValue != newValue)
			{
				DecontaminationGas.TurnedOn = newValue == DecontaminationStatus.Forced;
			}
		}

		public void EnableElevators()
		{
			ElevatorGroup[] groupsToLock = GroupsToLock;
			for (int i = 0; i < groupsToLock.Length; i++)
			{
				if (ElevatorChamber.TryGetChamber(groupsToLock[i], out var chamber))
				{
					chamber.ServerLockAllDoors(DoorLockReason.DecontLockdown, state: false);
				}
			}
			_elevatorsDirty = false;
		}

		public void DisableElevators()
		{
			ElevatorGroup[] groupsToLock = GroupsToLock;
			for (int i = 0; i < groupsToLock.Length; i++)
			{
				if (ElevatorChamber.TryGetChamber(groupsToLock[i], out var chamber))
				{
					chamber.ServerLockAllDoors(DoorLockReason.DecontLockdown, state: true);
					if (chamber.DestinationLevel != 1)
					{
						chamber.ServerSetDestination(1, allowQueueing: true);
					}
				}
			}
			_elevatorsDirty = false;
		}

		private void ServerDisableDecontamination()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			DoorEventOpenerExtension.TriggerAction(DoorEventOpenerExtension.OpenerEventType.DeconReset);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsAlive() && allHub.GetLastKnownZone() == FacilityZone.LightContainment)
				{
					allHub.playerEffectsController.DisableEffect<Decontaminating>();
				}
			}
		}

		private void Awake()
		{
			Singleton = this;
		}

		private void Start()
		{
			if (NetworkServer.active && ConfigFile.ServerConfig.GetBool("disable_decontamination"))
			{
				DecontaminationOverride = DecontaminationStatus.Disabled;
			}
			for (int i = 0; i < DecontaminationPhases.Length; i++)
			{
				DecontaminationPhases[i].TimeTrigger *= 60f;
			}
		}

		private IEnumerator<float> KillPlayers()
		{
			float timer = 1f;
			while (Singleton != null && _decontaminationBegun && DecontaminationOverride == DecontaminationStatus.Forced)
			{
				timer -= Time.deltaTime;
				yield return float.NegativeInfinity;
				if (!(timer <= 0f))
				{
					continue;
				}
				timer = 1f;
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (allHub.IsAlive())
					{
						bool flag = allHub.GetLastKnownZone() == FacilityZone.LightContainment;
						Decontaminating effect = allHub.playerEffectsController.GetEffect<Decontaminating>();
						if (!effect.IsEnabled & flag)
						{
							allHub.playerEffectsController.EnableEffect<Decontaminating>();
						}
						else if (effect.IsEnabled && !flag)
						{
							allHub.playerEffectsController.DisableEffect<Decontaminating>();
						}
					}
				}
			}
		}

		private void FinishDecontamination()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			LczDecontaminationStartingEventArgs e = new LczDecontaminationStartingEventArgs();
			ServerEvents.OnLczDecontaminationStarting(e);
			if (e.IsAllowed)
			{
				ServerLogs.AddLog(ServerLogs.Modules.GameLogic, "Decontamination started.", ServerLogs.ServerLogType.GameEvent);
				DoorEventOpenerExtension.TriggerAction(DoorEventOpenerExtension.OpenerEventType.DeconFinish);
				DisableElevators();
				if (AutoDeconBroadcastEnabled && !_decontaminationBegun)
				{
					Broadcast.Singleton.RpcAddElement(DeconBroadcastDeconMessage, DeconBroadcastDeconMessageTime, Broadcast.BroadcastFlags.Normal);
				}
				_decontaminationBegun = true;
				Timing.RunCoroutine(KillPlayers());
				ServerEvents.OnLczDecontaminationStarted();
			}
		}

		private void Update()
		{
			if (_elevatorsDirty)
			{
				DisableElevators();
			}
			if (!_stopUpdating)
			{
				if (NetworkServer.active)
				{
					ServersideSetup();
				}
				UpdateTime();
			}
		}

		private void ServersideSetup()
		{
			if (DecontaminationOverride == DecontaminationStatus.None && RoundStartTime == 0.0 && RoundStart.singleton.Timer == -1)
			{
				NetworkRoundStartTime = NetworkTime.time;
				Debug.Log("[Decontamination] Countdown started; first announcement in " + DecontaminationPhases[0].TimeTrigger.ToString("F0") + "s.");
			}
		}

		private void UpdateTime()
		{
			if (NetworkServer.active && DecontaminationOverride != DecontaminationStatus.None)
			{
				return;
			}
			if (RoundStartTime <= 0.0)
			{
				if (RoundStartTime == -1.0)
				{
					_stopUpdating = true;
				}
				return;
			}
			if (_justJoinedCooldown < 10f)
			{
				_justJoinedCooldown += Time.deltaTime;
			}
			float num = (float)GetServerTime;
			if (num == -1f || !(num > DecontaminationPhases[_nextPhase].TimeTrigger))
			{
				return;
			}
			if (DecontaminationPhases[_nextPhase].AnnouncementLine != null && _justJoinedCooldown >= 10f)
			{
				_curFunction = DecontaminationPhases[_nextPhase].Function;
				UpdateSpeaker(hard: true);
				AnnouncementAudioSource.PlayOneShot(DecontaminationPhases[_nextPhase].AnnouncementLine);
				if (NetworkServer.active)
				{
					List<SubtitlePart> list = new List<SubtitlePart>(1);
					switch (_nextPhase)
					{
					case 0:
						list.Add(new SubtitlePart(SubtitleType.DecontaminationStart, (string[])null));
						break;
					case 1:
						list.Add(new SubtitlePart(SubtitleType.DecontaminationMinutes, "10"));
						break;
					case 2:
						list.Add(new SubtitlePart(SubtitleType.DecontaminationMinutes, "5"));
						break;
					case 3:
						list.Add(new SubtitlePart(SubtitleType.Decontamination1Minute, (string[])null));
						break;
					case 4:
						list.Add(new SubtitlePart(SubtitleType.DecontaminationCountdown, (string[])null));
						break;
					case 6:
						list.Add(new SubtitlePart(SubtitleType.DecontaminationLockdown, (string[])null));
						break;
					}
					foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
					{
						if (IsAudibleForClient(allHub))
						{
							new SubtitleMessage(list.ToArray()).SendToSpectatorsOf(allHub, includeTarget: true);
						}
					}
				}
			}
			Debug.Log($"[Decontamination] Phase {_nextPhase} reached at {num:F1}s ({DecontaminationPhases[_nextPhase].Function}).");
			if (DecontaminationPhases[_nextPhase].Function == DecontaminationPhase.PhaseFunction.Final)
			{
				DecontaminationOverride = DecontaminationStatus.Forced;
			}
			if (NetworkServer.active && DecontaminationPhases[_nextPhase].Function == DecontaminationPhase.PhaseFunction.OpenCheckpoints)
			{
				DoorEventOpenerExtension.TriggerAction(DoorEventOpenerExtension.OpenerEventType.DeconEvac);
			}
			if (_nextPhase == DecontaminationPhases.Length - 1)
			{
				_stopUpdating = true;
				return;
			}
			ServerEvents.OnLczDecontaminationAnnounced(new LczDecontaminationAnnouncedEventArgs(_nextPhase));
			_nextPhase++;
		}

		private bool IsAudibleForClient(ReferenceHub hub)
		{
			if (_curFunction == DecontaminationPhase.PhaseFunction.Final)
			{
				return true;
			}
			if (_curFunction == DecontaminationPhase.PhaseFunction.GloballyAudible)
			{
				return true;
			}
			if (hub.roleManager.CurrentRole is Scp079Role scp079Role)
			{
				return scp079Role.CurrentCamera.Room.Zone == FacilityZone.LightContainment;
			}
			return hub.GetCurrentZone() == FacilityZone.LightContainment;
		}

		private void UpdateSpeaker(bool hard)
		{
			float b = (IsAnnouncementHearable ? 1 : 0);
			float t = (hard ? 1f : (Time.deltaTime * 4f));
			_prevVolume = Mathf.Lerp(_prevVolume, b, t);
			AnnouncementSource.SetVolumeScale(AnnouncementAudioSource, _prevVolume);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteDouble(RoundStartTime);
				writer.WriteString(_elevatorsLockedText);
				GeneratedNetworkCode._Write_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(writer, _decontaminationOverride);
				writer.WriteFloat(_timeOffset);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteDouble(RoundStartTime);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteString(_elevatorsLockedText);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				GeneratedNetworkCode._Write_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(writer, _decontaminationOverride);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteFloat(_timeOffset);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref RoundStartTime, null, reader.ReadDouble());
				GeneratedSyncVarDeserialize(ref _elevatorsLockedText, OnElevatorTextChanged, reader.ReadString());
				GeneratedSyncVarDeserialize(ref _decontaminationOverride, OnChangeDisableDecontamination, GeneratedNetworkCode._Read_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(reader));
				GeneratedSyncVarDeserialize(ref _timeOffset, OnTimeOffsetChanged, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref RoundStartTime, null, reader.ReadDouble());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _elevatorsLockedText, OnElevatorTextChanged, reader.ReadString());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _decontaminationOverride, OnChangeDisableDecontamination, GeneratedNetworkCode._Read_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(reader));
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _timeOffset, OnTimeOffsetChanged, reader.ReadFloat());
			}
		}
	}
}
