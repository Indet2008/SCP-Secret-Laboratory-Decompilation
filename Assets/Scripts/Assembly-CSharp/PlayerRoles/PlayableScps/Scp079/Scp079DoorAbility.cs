using System;
using AudioPooling;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.PlayableScps.Scp079.Overcons;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public abstract class Scp079DoorAbility : Scp079KeyAbilityBase
	{
		protected DoorVariant LastDoor;

		private static string _deniedText;

		private int _lastCost;

		private bool _lastActionValid;

		private int _failMessageAux;

		private bool _failMessageDenied;

		public override bool IsVisible
		{
			get
			{
				if (Scp079CursorManager.LockCameras)
				{
					return false;
				}
				if (OverconManager.Singleton.HighlightedOvercon is DoorOvercon doorOvercon && doorOvercon != null)
				{
					LastDoor = doorOvercon.Target;
					return true;
				}
				return false;
			}
		}

		public override bool IsReady
		{
			get
			{
				DoorAction targetAction = TargetAction;
				_lastActionValid = ValidateAction(targetAction, LastDoor, base.CurrentCamSync.CurrentCamera);
				_lastCost = GetCostForDoor(targetAction, LastDoor);
				if (_lastActionValid)
				{
					return (float)_lastCost <= base.AuxManager.CurrentAux;
				}
				return false;
			}
		}

		public override string FailMessage
		{
			get
			{
				if (!_failMessageDenied)
				{
					if (!(base.AuxManager.CurrentAux < (float)_failMessageAux))
					{
						return null;
					}
					return GetNoAuxMessage(_failMessageAux);
				}
				return _deniedText;
			}
		}

		protected abstract DoorAction TargetAction { get; }

		public static event Action<Scp079Role, DoorVariant> OnServerAnyDoorInteraction;

		protected abstract int GetCostForDoor(DoorAction action, DoorVariant door);

		protected override void Trigger()
		{
			ClientSendCmd();
		}

		protected override void Start()
		{
			base.Start();
			_deniedText = Translations.Get(Scp079HudTranslation.DoorAccessDenied);
			base.CurrentCamSync.OnCameraChanged += () =>
			{
				_failMessageAux = 0;
				_failMessageDenied = false;
			};
		}

		public override void OnFailMessageAssigned()
		{
			_failMessageDenied = !_lastActionValid;
			_failMessageAux = _lastCost;
		}

		public void PlayConfirmationSound(AudioClip sound)
		{
			if (base.Role.IsLocalPlayer || base.Owner.IsLocallySpectated())
			{
				AudioSourcePoolManager.Play2D(sound);
			}
		}

		public static bool ValidateAction(DoorAction action, DoorVariant door, Scp079Camera currentCamera)
		{
			if (!CheckVisibility(door, currentCamera))
			{
				return false;
			}
			DoorLockReason activeLocks = (DoorLockReason)door.ActiveLocks;
			if (activeLocks.HasFlagFast(DoorLockReason.Warhead) || activeLocks.HasFlagFast(DoorLockReason.Isolation))
			{
				return false;
			}
			DoorLockMode mode = DoorLockUtils.GetMode((DoorLockReason)door.ActiveLocks);
			if (door is IDamageableDoor { IsDestroyed: not false })
			{
				return false;
			}
			if (mode.HasFlagFast(DoorLockMode.ScpOverride))
			{
				return true;
			}
			switch (action)
			{
			case DoorAction.Opened:
				return mode.HasFlagFast(DoorLockMode.CanOpen);
			case DoorAction.Closed:
				return mode.HasFlagFast(DoorLockMode.CanClose);
			case DoorAction.Locked:
				if (mode != DoorLockMode.FullLock)
				{
					return !(door is CheckpointDoor);
				}
				return false;
			case DoorAction.Unlocked:
				return true;
			default:
				return false;
			}
		}

		public static bool CheckVisibility(DoorVariant door, Scp079Camera currentCamera)
		{
			RoomIdentifier[] rooms = door.Rooms;
			for (int i = 0; i < rooms.Length; i++)
			{
				if (!(rooms[i] != currentCamera.Room))
				{
					if (door is INonInteractableDoor nonInteractableDoor)
					{
						return !nonInteractableDoor.IgnoreLockdowns;
					}
					return true;
				}
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Scp079DoorLockChanger.OnServerDoorLocked += (Scp079Role role, DoorVariant dv) =>
			{
				OnServerAnyDoorInteraction?.Invoke(role, dv);
			};
			Scp079DoorStateChanger.OnServerDoorToggled += (Scp079Role role, DoorVariant dv) =>
			{
				OnServerAnyDoorInteraction?.Invoke(role, dv);
			};
			Scp079ElevatorStateChanger.OnServerElevatorDoorClosed += (Scp079Role role, ElevatorDoor dv) =>
			{
				OnServerAnyDoorInteraction?.Invoke(role, dv);
			};
			Scp079LockdownRoomAbility.OnServerDoorLocked += (Scp079Role role, DoorVariant dv) =>
			{
				OnServerAnyDoorInteraction?.Invoke(role, dv);
			};
		}
	}
}
