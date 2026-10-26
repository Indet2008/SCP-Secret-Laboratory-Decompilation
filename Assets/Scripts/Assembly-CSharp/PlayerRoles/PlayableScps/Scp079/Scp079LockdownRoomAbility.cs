using System;
using System.Collections.Generic;
using System.Text;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079LockdownRoomAbility : Scp079KeyAbilityBase, IScp079LevelUpNotifier, IScp079AuxRegenModifier
	{
		private enum ValidationError
		{
			None = 0,
			Unknown = 1,
			NotEnoughAux = 6,
			TierTooLow = 8,
			Cooldown = 31,
			NoDoors = 32
		}

		[SerializeField]
		private int _minimalTierIndex;

		[SerializeField]
		private float[] _regenerationPerTier;

		[SerializeField]
		private float _lockdownDuration;

		[SerializeField]
		private float _cooldown;

		[SerializeField]
		private int _cost;

		[SerializeField]
		private float _minStateToClose;

		[SerializeField]
		private AudioClip _lockdownStartSound;

		[SerializeField]
		private AudioClip _lockdownEndSound;

		private string _nameFormat;

		private string _failMessage;

		private string _unlockText;

		private double _nextUseTime;

		private bool _hasFailMessage;

		private bool _lockdownInEffect;

		private Scp079DoorLockChanger _doorLockChanger;

		private readonly HashSet<DoorVariant> _roomDoors = new HashSet<DoorVariant>();

		private readonly HashSet<DoorVariant> _doorsToLockDown = new HashSet<DoorVariant>();

		private readonly HashSet<DoorVariant> _alreadyLockedDown = new HashSet<DoorVariant>();

		private RoomIdentifier _lastLockedRoom;

		public override ActionName ActivationKey => ActionName.Scp079Lockdown;

		public override bool IsReady => ErrorCode == Scp079HudTranslation.Zoom;

		public override bool IsVisible
		{
			get
			{
				if (!Scp079CursorManager.LockCameras)
				{
					return ErrorCode != Scp079HudTranslation.HigherTierRequired;
				}
				return false;
			}
		}

		public override string AbilityName => string.Format(_nameFormat, _cost);

		public override bool DummyEmulationSupport => true;

		public override string FailMessage
		{
			get
			{
				if (!_hasFailMessage)
				{
					return null;
				}
				return ErrorCode switch
				{
					Scp079HudTranslation.Zoom => null, 
					Scp079HudTranslation.NotEnoughAux => GetNoAuxMessage(_cost), 
					Scp079HudTranslation.LockdownCooldown => _failMessage + "\n" + base.AuxManager.GenerateCustomETA(Mathf.CeilToInt(RemainingCooldown)), 
					_ => _failMessage, 
				};
			}
		}

		public float AuxRegenMultiplier
		{
			get
			{
				if (RemainingLockdownDuration == 0f)
				{
					return 1f;
				}
				int accessTierIndex = base.TierManager.AccessTierIndex;
				int a = _regenerationPerTier.Length - 1;
				return _regenerationPerTier[Mathf.Min(a, accessTierIndex)];
			}
		}

		public string AuxReductionMessage { get; private set; }

		private Scp079HudTranslation ErrorCode
		{
			get
			{
				if (base.TierManager.AccessTierIndex < _minimalTierIndex)
				{
					return Scp079HudTranslation.HigherTierRequired;
				}
				if (!_roomDoors.Any((DoorVariant x) => ValidateDoor(x)))
				{
					return Scp079HudTranslation.LockdownNoDoorsError;
				}
				if (RemainingCooldown > 0f)
				{
					return Scp079HudTranslation.LockdownCooldown;
				}
				if (base.AuxManager.CurrentAuxFloored < _cost)
				{
					return Scp079HudTranslation.NotEnoughAux;
				}
				return Scp079HudTranslation.Zoom;
			}
		}

		private float RemainingCooldown
		{
			get
			{
				return Mathf.Max(0f, (float)(_nextUseTime - NetworkTime.time));
			}
			set
			{
				_nextUseTime = NetworkTime.time + (double)value;
			}
		}

		private float RemainingLockdownDuration => Mathf.Max(0f, (float)(_nextUseTime - (double)_cooldown - NetworkTime.time));

		public static event Action<Scp079Role, RoomIdentifier> OnServerLockdown;

		public static event Action<Scp079Role, DoorVariant> OnServerDoorLocked;

		private void ServerInitLockdown()
		{
			_lockdownInEffect = true;
			_lastLockedRoom = base.CurrentCamSync.CurrentCamera.Room;
			_doorsToLockDown.UnionWith(_roomDoors);
			OnServerLockdown?.Invoke(base.CastRole, _lastLockedRoom);
		}

		private void ServerCancelLockdown()
		{
			Scp079CancellingRoomLockdownEventArgs e = new Scp079CancellingRoomLockdownEventArgs(base.Owner, _lastLockedRoom);
			Scp079Events.OnCancellingRoomLockdown(e);
			if (!e.IsAllowed)
			{
				return;
			}
			_lockdownInEffect = false;
			RemainingCooldown = _cooldown;
			foreach (DoorVariant item in _alreadyLockedDown)
			{
				item.ServerChangeLock(DoorLockReason.Lockdown079, newState: false);
			}
			_doorsToLockDown.Clear();
			_alreadyLockedDown.Clear();
			ServerSendRpc(toAll: true);
			Scp079Events.OnCancelledRoomLockdown(new Scp079CancelledRoomLockdownEventArgs(base.Owner, _lastLockedRoom));
		}

		private bool ValidateDoor(DoorVariant dv)
		{
			Scp079Camera currentCamera = base.CurrentCamSync.CurrentCamera;
			if (Scp079DoorAbility.ValidateAction(DoorAction.Closed, dv, currentCamera))
			{
				return Scp079DoorAbility.ValidateAction(DoorAction.Locked, dv, currentCamera);
			}
			return false;
		}

		protected override void Start()
		{
			base.Start();
			_nameFormat = Translations.Get(Scp079HudTranslation.Lockdown);
			_unlockText = Translations.Get(Scp079HudTranslation.LockdownAvailable);
			AuxReductionMessage = Translations.Get(Scp079HudTranslation.LockdownAuxPause);
			base.CurrentCamSync.OnCameraChanged += () =>
			{
				_hasFailMessage = false;
				_failMessage = null;
				_roomDoors.Clear();
				if (DoorVariant.DoorsByRoom.TryGetValue(base.CurrentCamSync.CurrentCamera.Room, out var value))
				{
					_roomDoors.UnionWith(value);
				}
			};
			GetSubroutine<Scp079DoorLockChanger>(out _doorLockChanger);
		}

		protected override void Update()
		{
			base.Update();
			if (!_lockdownInEffect || !NetworkServer.active)
			{
				return;
			}
			if (RemainingLockdownDuration <= 0f)
			{
				ServerCancelLockdown();
				return;
			}
			foreach (DoorVariant item in _doorsToLockDown)
			{
				if (ValidateDoor(item) && !_alreadyLockedDown.Contains(item) && (!item.TargetState || !(item.GetExactState() < _minStateToClose)))
				{
					item.NetworkTargetState = false;
					item.ServerChangeLock(DoorLockReason.Lockdown079, newState: true);
					if (item == _doorLockChanger.LockedDoor)
					{
						_doorLockChanger.ServerUnlock();
					}
					base.RewardManager.MarkRooms(item.Rooms);
					OnServerDoorLocked?.Invoke(base.CastRole, item);
					_alreadyLockedDown.Add(item);
				}
			}
		}

		protected override void Trigger()
		{
			ClientSendCmd();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (ErrorCode == Scp079HudTranslation.Zoom && !base.LostSignalHandler.Lost)
			{
				Scp079LockingDownRoomEventArgs e = new Scp079LockingDownRoomEventArgs(base.Owner, base.CurrentCamSync.CurrentCamera.Room);
				Scp079Events.OnLockingDownRoom(e);
				if (!e.IsAllowed)
				{
					return;
				}
				base.AuxManager.CurrentAux -= _cost;
				RemainingCooldown = _lockdownDuration + _cooldown;
				ServerInitLockdown();
				Scp079Events.OnLockedDownRoom(new Scp079LockedDownRoomEventArgs(base.Owner, base.CurrentCamSync.CurrentCamera.Room));
			}
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteDouble(_nextUseTime);
			writer.WriteBool(_lockdownInEffect);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_nextUseTime = reader.ReadDouble();
			_doorLockChanger.PlayConfirmationSound(reader.ReadBool() ? _lockdownStartSound : _lockdownEndSound);
		}

		public override void OnFailMessageAssigned()
		{
			base.OnFailMessageAssigned();
			_hasFailMessage = true;
			_failMessage = Translations.Get(ErrorCode);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_nextUseTime = 0.0;
			if (NetworkServer.active)
			{
				ServerCancelLockdown();
			}
		}

		public static bool IsLockedDown(DoorVariant dv)
		{
			return ((DoorLockReason)dv.ActiveLocks).HasFlagFast(DoorLockReason.Lockdown079);
		}

		public bool WriteLevelUpNotification(StringBuilder sb, int newLevel)
		{
			if (newLevel != _minimalTierIndex)
			{
				return false;
			}
			sb.AppendFormat(_unlockText, $"[{new ReadableKeyCode(ActivationKey)}]");
			return true;
		}
	}
}
