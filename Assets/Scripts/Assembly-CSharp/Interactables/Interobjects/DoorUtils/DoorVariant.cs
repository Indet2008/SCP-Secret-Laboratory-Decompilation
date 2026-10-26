using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Interactables.Interobjects.DoorButtons;
using Interactables.Verification;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using MapGeneration.StaticHelpers;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles;
using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public abstract class DoorVariant : NetworkBehaviour, IServerInteractable, IInteractable, IRoomConnector, IDoorPermissionRequester, IBlockStaticBatching
	{
		[Flags]
		private enum CollisionsDisablingReasons : byte
		{
			DoorClosing = 1,
			Scp106 = 2
		}

		public static readonly HashSet<DoorVariant> AllDoors = new HashSet<DoorVariant>();

		public static readonly Dictionary<RoomIdentifier, HashSet<DoorVariant>> DoorsByRoom = new Dictionary<RoomIdentifier, HashSet<DoorVariant>>();

		[SyncVar]
		public bool TargetState;

		[SyncVar]
		public ushort ActiveLocks;

		[SyncVar]
		public byte DoorId;

		public bool CanSeeThrough;

		[NonSerialized]
		public string DoorName;

		public DoorPermissionsPolicy RequiredPermissions;

		public BoxCollider[] IgnoredColliders;

		private bool _prevState;

		private ushort _prevLock;

		private byte _existenceCooldown = byte.MaxValue;

		private ReferenceHub _triggerPlayer;

		private CollisionsDisablingReasons _collidersStatus;

		private bool _collidersActivationPending;

		private float _remainingDeniedCooldown;

		private static int _serverDoorIdClock;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public RoomIdentifier[] Rooms { get; private set; }

		public bool IsVisibleThrough
		{
			get
			{
				if (!CanSeeThrough)
				{
					return GetExactState() > 0f;
				}
				return true;
			}
		}

		public bool RoomsAlreadyRegistered { get; private set; }

		public BoxCollider[] AllColliders { get; private set; }

		[field: SerializeField]
		public ButtonVariant[] Buttons { get; private set; }

		public bool IsMoving
		{
			get
			{
				float exactState = GetExactState();
				if (!(exactState > 0f) || TargetState)
				{
					if (exactState < 1f)
					{
						return TargetState;
					}
					return false;
				}
				return true;
			}
		}

		public DoorPermissionsPolicy PermissionsPolicy => RequiredPermissions;

		public string RequesterLogSignature
		{
			get
			{
				if (TryGetComponent<DoorNametagExtension>(out var component))
				{
					return "Door_" + component.GetName;
				}
				if (!RoomsAlreadyRegistered || Rooms.Length == 0)
				{
					return "Door_UNKNOWN";
				}
				return "Door_" + Rooms[0].Name;
			}
		}

		protected float DeniedCooldown => 1f;

		public bool NetworkTargetState
		{
			get
			{
				return TargetState;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref TargetState, 1uL, null);
			}
		}

		public ushort NetworkActiveLocks
		{
			get
			{
				return ActiveLocks;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref ActiveLocks, 2uL, null);
			}
		}

		public byte NetworkDoorId
		{
			get
			{
				return DoorId;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref DoorId, 4uL, null);
			}
		}

		public static event Action<DoorVariant> OnInstanceCreated;

		public static event Action<DoorVariant> OnInstanceRemoved;

		public event Action OnRoomsRegistered;

		public event Action OnStateChanged;

		public event Action OnLockChanged;

		[Server]
		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Interactables.Interobjects.DoorUtils.DoorVariant::ServerInteract(ReferenceHub,System.Byte)' called when server was not active");
				return;
			}
			bool canOpen = RequiredPermissions.CheckPermissions(ply, this, out var callback);
			bool pluginRequestSent = false;
			if (ActiveLocks > 0 && !TryResolveLock(ply, out pluginRequestSent))
			{
				if (_remainingDeniedCooldown <= 0f)
				{
					_remainingDeniedCooldown = DeniedCooldown;
					LockBypassDenied(ply, colliderId);
					callback?.Invoke(this, success: false);
				}
				PlayerEvents.OnInteractedDoor(new PlayerInteractedDoorEventArgs(ply, this, canOpen: false));
			}
			else
			{
				if (!AllowInteracting(ply, colliderId))
				{
					return;
				}
				if (!pluginRequestSent)
				{
					PlayerInteractingDoorEventArgs e = new PlayerInteractingDoorEventArgs(ply, this, canOpen);
					PlayerEvents.OnInteractingDoor(e);
					if (!e.IsAllowed)
					{
						return;
					}
					canOpen = e.CanOpen;
				}
				else
				{
					canOpen = true;
				}
				if (canOpen)
				{
					NetworkTargetState = !TargetState;
					_triggerPlayer = ply;
					if (DoorName != null)
					{
						ServerLogs.AddLog(ServerLogs.Modules.Door, ply.LoggedNameFromRefHub() + " " + (TargetState ? "opened" : "closed") + " " + DoorName + ".", ServerLogs.ServerLogType.GameEvent);
					}
					callback?.Invoke(this, success: true);
				}
				else if (_remainingDeniedCooldown <= 0f)
				{
					_remainingDeniedCooldown = DeniedCooldown;
					PermissionsDenied(ply, colliderId);
					DoorEvents.TriggerAction(this, DoorAction.AccessDenied, ply);
					callback?.Invoke(this, success: false);
				}
				PlayerEvents.OnInteractedDoor(new PlayerInteractedDoorEventArgs(ply, this, canOpen));
			}
		}

		[Server]
		public void ServerChangeLock(DoorLockReason reason, bool newState)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Interactables.Interobjects.DoorUtils.DoorVariant::ServerChangeLock(Interactables.Interobjects.DoorUtils.DoorLockReason,System.Boolean)' called when server was not active");
				return;
			}
			DoorLockReason activeLocks = (DoorLockReason)ActiveLocks;
			activeLocks = ((!newState) ? ((DoorLockReason)((uint)activeLocks & (uint)(ushort)(~(int)reason))) : (activeLocks | reason));
			if ((uint)ActiveLocks != (uint)activeLocks)
			{
				if (newState)
				{
					if (ActiveLocks == 0)
					{
						DoorEvents.TriggerAction(this, DoorAction.Locked, null);
					}
				}
				else if (ActiveLocks != 0)
				{
					DoorEvents.TriggerAction(this, DoorAction.Unlocked, null);
				}
			}
			NetworkActiveLocks = (ushort)activeLocks;
		}

		public abstract void LockBypassDenied(ReferenceHub ply, byte colliderId);

		public abstract bool AnticheatPassageApproved();

		public abstract void PermissionsDenied(ReferenceHub ply, byte colliderId);

		public abstract bool AllowInteracting(ReferenceHub ply, byte colliderId);

		public abstract float GetExactState();

		public abstract bool IsConsideredOpen();

		protected virtual void LockChanged(ushort prevValue)
		{
		}

		internal virtual void TargetStateChanged()
		{
		}

		protected virtual void Awake()
		{
			AllColliders = GetColliders();
			ButtonVariant[] buttons = Buttons;
			for (int i = 0; i < buttons.Length; i++)
			{
				buttons[i].Init(this);
			}
			if (NetworkServer.active)
			{
				_serverDoorIdClock++;
				if (_serverDoorIdClock > 255)
				{
					_serverDoorIdClock = 1;
				}
				NetworkDoorId = (byte)_serverDoorIdClock;
			}
			AllDoors.Add(this);
			if (SeedSynchronizer.MapGenerated)
			{
				RegisterRooms();
			}
			OnInstanceCreated?.Invoke(this);
		}

		protected virtual void OnDestroy()
		{
			AllDoors.Remove(this);
			if (Rooms == null)
			{
				return;
			}
			RoomIdentifier[] rooms = Rooms;
			foreach (RoomIdentifier key in rooms)
			{
				if (DoorsByRoom.TryGetValue(key, out var value))
				{
					value.Remove(this);
				}
			}
			OnInstanceRemoved?.Invoke(this);
		}

		protected virtual void Update()
		{
			if (_existenceCooldown == 0)
			{
				if (_prevLock != ActiveLocks)
				{
					LockChanged(_prevLock);
					ServerEvents.OnDoorLockChanged(new DoorLockChangedEventArgs(this, _prevLock, ActiveLocks));
					OnLockChanged?.Invoke();
					_prevLock = ActiveLocks;
				}
				if (_prevState != TargetState)
				{
					TargetStateChanged();
					OnStateChanged?.Invoke();
					DoorEvents.TriggerAction(this, (!TargetState) ? DoorAction.Closed : DoorAction.Opened, _triggerPlayer);
					_triggerPlayer = null;
					if (NetworkServer.active)
					{
						if (TargetState)
						{
							_collidersStatus &= ~CollisionsDisablingReasons.DoorClosing;
						}
						else
						{
							_collidersStatus |= CollisionsDisablingReasons.DoorClosing;
							_collidersActivationPending = true;
						}
						SetColliders();
					}
					_prevState = TargetState;
				}
			}
			else
			{
				_existenceCooldown--;
			}
			if (NetworkServer.active && _remainingDeniedCooldown > 0f)
			{
				_remainingDeniedCooldown -= Time.deltaTime;
			}
			if (_collidersActivationPending && !AnticheatPassageApproved())
			{
				_collidersActivationPending = false;
				_collidersStatus &= ~CollisionsDisablingReasons.DoorClosing;
				SetColliders();
			}
		}

		private bool TryResolveLock(ReferenceHub ply, out bool pluginRequestSent)
		{
			pluginRequestSent = false;
			if (ply.serverRoles.BypassMode)
			{
				return true;
			}
			DoorLockMode mode = DoorLockUtils.GetMode((DoorLockReason)ActiveLocks);
			if (mode.HasFlagFast(DoorLockMode.CanClose) && TargetState)
			{
				return true;
			}
			if (mode.HasFlagFast(DoorLockMode.CanOpen) && !TargetState)
			{
				return true;
			}
			if (mode.HasFlagFast(DoorLockMode.ScpOverride) && ply.IsSCP())
			{
				return true;
			}
			PlayerInteractingDoorEventArgs e = new PlayerInteractingDoorEventArgs(ply, this, canOpen: false);
			PlayerEvents.OnInteractingDoor(e);
			pluginRequestSent = true;
			if (!e.IsAllowed)
			{
				return false;
			}
			if (e.CanOpen)
			{
				return true;
			}
			return false;
		}

		private BoxCollider[] GetColliders()
		{
			List<BoxCollider> list = ListPool<BoxCollider>.Shared.Rent();
			GetComponentsInChildren(list);
			for (int num = list.Count - 1; num >= 0; num--)
			{
				Collider collider = list[num];
				Collider[] ignoredColliders = IgnoredColliders;
				if (ignoredColliders.Contains(collider) || collider.TryGetComponent<ButtonVariant>(out var _))
				{
					list.RemoveAt(num);
				}
			}
			BoxCollider[] result = list.ToArray();
			ListPool<BoxCollider>.Shared.Return(list);
			return result;
		}

		private void SetColliders()
		{
			BoxCollider[] allColliders = AllColliders;
			for (int i = 0; i < allColliders.Length; i++)
			{
				allColliders[i].isTrigger = _collidersStatus != (CollisionsDisablingReasons)0;
			}
		}

		private void RegisterRooms()
		{
			Vector3 position = base.transform.position;
			int num = 0;
			for (int i = 0; i < IRoomConnector.WorldDirections.Length; i++)
			{
				if ((position + IRoomConnector.WorldDirections[i]).TryGetRoom(out var room) && DoorsByRoom.GetOrAddNew(room).Add(this))
				{
					IRoomConnector.RoomsNonAlloc[num] = room;
					num++;
				}
			}
			Rooms = new RoomIdentifier[num];
			Array.Copy(IRoomConnector.RoomsNonAlloc, Rooms, num);
			OnRoomsRegistered?.Invoke();
			RoomsAlreadyRegistered = true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationStage += OnMapStage;
			RoomIdentifier.OnRemoved += (RoomIdentifier x) =>
			{
				DoorsByRoom.Remove(x);
			};
		}

		private static void OnMapStage(MapGenerationPhase stage)
		{
			if (stage != MapGenerationPhase.ParentRoomRegistration)
			{
				return;
			}
			foreach (DoorVariant allDoor in AllDoors)
			{
				allDoor.RegisterRooms();
			}
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
				writer.WriteBool(TargetState);
				writer.WriteUShort(ActiveLocks);
				NetworkWriterExtensions.WriteByte(writer, DoorId);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteBool(TargetState);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteUShort(ActiveLocks);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, DoorId);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref TargetState, null, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref ActiveLocks, null, reader.ReadUShort());
				GeneratedSyncVarDeserialize(ref DoorId, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref TargetState, null, reader.ReadBool());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref ActiveLocks, null, reader.ReadUShort());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref DoorId, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}
