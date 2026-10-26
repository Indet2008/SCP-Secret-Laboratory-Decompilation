using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using RelativePositioning;
using UnityEngine;
using Utils;

namespace Interactables.Interobjects
{
	public class ElevatorChamber : NetworkBehaviour, IServerInteractable, IInteractable
	{
		public delegate void ElevatorMoved(Bounds elevatorBounds, ElevatorChamber chamber, Vector3 deltaPos, Quaternion deltaRot);

		public enum ElevatorSequence
		{
			StartingSequence = 0,
			DoorClosing = 1,
			MovingAway = 2,
			Arriving = 3,
			DoorOpening = 4,
			Ready = 5
		}

		public static List<ElevatorChamber> AllChambers = new List<ElevatorChamber>();

		[SyncVar]
		public ElevatorGroup AssignedGroup;

		private static readonly int DoorAnimHash = Animator.StringToHash("isOpen");

		private ElevatorDoor _lastArrivedDestination;

		private List<ElevatorDoor> _floorDoors;

		private RelativeBounds _cachedBounds;

		private bool _cachedBoundsUpToDate;

		private bool _dynamicAdminLock;

		private int? _lastSetDestinationLevel;

		private byte? _queuedDestination;

		private readonly Stopwatch _sequenceStopwatch = Stopwatch.StartNew();

		private Transform _transform;

		[SerializeField]
		private Animator _doorAnimator;

		[SerializeField]
		private Vector3 _boundsCenter;

		[SerializeField]
		private float _boundsSize;

		[SerializeField]
		private float _boundsHeight;

		[SerializeField]
		private float _doorOpenTime;

		[SerializeField]
		private float _doorCloseTime;

		[SerializeField]
		private float _animationTime;

		[SerializeField]
		private float _rotationTime;

		[SerializeField]
		private AnimationCurve _translationCurve;

		[SerializeField]
		private AnimationCurve _rotationCurve;

		[SerializeField]
		private List<AudioSource> _travelSounds;

		[SyncVar]
		private byte _syncDestinationLevel;

		[SerializeField]
		private float _rotationSizeGrowMultiplier = 1.8f;

		[SerializeField]
		private float _serverLagCompensation;

		[SerializeField]
		private ElevatorWaypoint _waypoint;

		[SyncVar]
		private byte _waypointId;

		public bool IsReady => CurSequence == ElevatorSequence.Ready;

		public bool IsReadyForUserInput
		{
			get
			{
				if (IsReady)
				{
					return !_queuedDestination.HasValue;
				}
				return false;
			}
		}

		public int DestinationLevel => _syncDestinationLevel;

		public bool GoingUp { get; private set; }

		public ElevatorDoor PreviousDoor
		{
			get
			{
				if (!_floorDoors.TryGet(PreviousLevel, out var element))
				{
					return null;
				}
				return element;
			}
		}

		public ElevatorDoor DestinationDoor
		{
			get
			{
				if (_floorDoors == null || !_floorDoors.TryGet(DestinationLevel, out var element))
				{
					return null;
				}
				return element;
			}
		}

		public ElevatorDoor NextDestinationDoor
		{
			get
			{
				if (!_floorDoors.TryGet(NextLevel, out var element))
				{
					return null;
				}
				return element;
			}
		}

		public RoomIdentifier CurrentRoom
		{
			get
			{
				switch (CurSequence)
				{
				case ElevatorSequence.StartingSequence:
				case ElevatorSequence.DoorClosing:
				case ElevatorSequence.MovingAway:
					if (PreviousDoor == null || PreviousDoor.Rooms == null)
					{
						return null;
					}
					return PreviousDoor.Rooms.FirstOrDefault();
				case ElevatorSequence.Arriving:
				case ElevatorSequence.DoorOpening:
				case ElevatorSequence.Ready:
					if (DestinationDoor == null || DestinationDoor.Rooms == null)
					{
						return null;
					}
					return DestinationDoor.Rooms.FirstOrDefault();
				default:
					return null;
				}
			}
		}

		public ElevatorSequence CurSequence { get; private set; }

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public DoorLockReason ActiveLocksAnyDoors
		{
			get
			{
				DoorLockReason doorLockReason = DoorLockReason.None;
				foreach (ElevatorDoor floorDoor in _floorDoors)
				{
					doorLockReason = (DoorLockReason)((uint)doorLockReason | (uint)floorDoor.ActiveLocks);
				}
				return doorLockReason;
			}
		}

		public DoorLockReason ActiveLocksAllDoors
		{
			get
			{
				DoorLockReason doorLockReason = (DoorLockReason)ushort.MaxValue;
				foreach (ElevatorDoor floorDoor in _floorDoors)
				{
					doorLockReason = (DoorLockReason)((uint)doorLockReason & (uint)floorDoor.ActiveLocks);
				}
				return doorLockReason;
			}
		}

		public bool DynamicAdminLock
		{
			get
			{
				return _dynamicAdminLock;
			}
			set
			{
				_dynamicAdminLock = value;
				if (value)
				{
					UpdateDynamicLock();
					return;
				}
				_floorDoors.ForEach((ElevatorDoor x) =>
				{
					x.NetworkActiveLocks = (ushort)(x.ActiveLocks & 0xFFF7);
				});
			}
		}

		public RelativeBounds WorldspaceBounds
		{
			get
			{
				if (!_cachedBoundsUpToDate)
				{
					Vector3 vector = _transform.right * _boundsCenter.x;
					Vector3 vector2 = _transform.up * _boundsCenter.y;
					Vector3 vector3 = _transform.forward * _boundsCenter.z;
					Vector3 origin = _transform.position + vector + vector2 + vector3;
					_cachedBounds = new RelativeBounds(origin, new Vector3(_boundsSize, _boundsHeight, _boundsSize), _transform.rotation);
					_cachedBoundsUpToDate = true;
				}
				return _cachedBounds;
			}
		}

		public int NextLevel => (DestinationLevel + 1) % _floorDoors.Count;

		public IReadOnlyCollection<ElevatorDoor> FloorDoors => _floorDoors;

		public int PreviousLevel => (DestinationLevel - 1 + _floorDoors.Count) % _floorDoors.Count;

		private float TargetLagCompensation
		{
			get
			{
				if (!NetworkServer.active)
				{
					return 0f;
				}
				return _serverLagCompensation;
			}
		}

		public float SequenceElapsed => (float)_sequenceStopwatch.Elapsed.TotalSeconds;

		public ElevatorGroup NetworkAssignedGroup
		{
			get
			{
				return AssignedGroup;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref AssignedGroup, 1uL, null);
			}
		}

		public byte Network_syncDestinationLevel
		{
			get
			{
				return _syncDestinationLevel;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncDestinationLevel, 2uL, null);
			}
		}

		public byte Network_waypointId
		{
			get
			{
				return _waypointId;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _waypointId, 4uL, null);
			}
		}

		public static event ElevatorMoved OnElevatorMoved;

		public static event Action<ElevatorChamber> OnElevatorSpawned;

		public static event Action<ElevatorChamber> OnElevatorRemoved;

		public event Action OnSequenceChanged;

		public static bool TryGetChamber(ElevatorGroup group, out ElevatorChamber chamber)
		{
			foreach (ElevatorChamber allChamber in AllChambers)
			{
				if (allChamber.AssignedGroup == group)
				{
					chamber = allChamber;
					return true;
				}
			}
			chamber = null;
			return false;
		}

		public override void OnStartServer()
		{
			base.OnStartServer();
			Network_waypointId = _waypoint.ServerAssignId();
		}

		public override void OnStartClient()
		{
			base.OnStartClient();
			if (!NetworkServer.active)
			{
				_waypoint.ClientAssignId(_waypointId);
			}
		}

		private void ForceDestination(int level)
		{
			ElevatorDoor elevatorDoor = _floorDoors[level];
			if (_lastArrivedDestination != null)
			{
				if (NetworkServer.active)
				{
					_lastArrivedDestination.NetworkTargetState = false;
				}
				GoingUp = _lastArrivedDestination.TargetPosition.y < elevatorDoor.TargetPosition.y;
				CurSequence = ElevatorSequence.StartingSequence;
				_sequenceStopwatch.Restart();
			}
			else
			{
				if (NetworkServer.active)
				{
					elevatorDoor.NetworkTargetState = true;
				}
				base.transform.SetPositionAndRotation(elevatorDoor.TargetPosition, elevatorDoor.transform.rotation);
				_lastArrivedDestination = elevatorDoor;
				ElevatorSequence curSequence = CurSequence;
				CurSequence = ElevatorSequence.Ready;
				UpdateDynamicLock();
				SetInnerDoor(state: true);
				OnSequenceChanged?.Invoke();
				ServerEvents.OnElevatorSequenceChanged(new ElevatorSequenceChangedEventArgs(this, curSequence, CurSequence));
			}
			_lastSetDestinationLevel = level;
		}

		private void SetInnerDoor(bool state)
		{
			_doorAnimator.SetBool(DoorAnimHash, state);
			_cachedBoundsUpToDate = false;
		}

		private void Awake()
		{
			_transform = base.transform;
			CurSequence = ElevatorSequence.Ready;
		}

		private void Start()
		{
			AllChambers.Add(this);
			_floorDoors = ElevatorDoor.GetDoorsForGroup(AssignedGroup);
			if (NetworkServer.active)
			{
				ServerSetDestination(UnityEngine.Random.Range(0, _floorDoors.Count), allowQueueing: false);
			}
			OnElevatorSpawned?.Invoke(this);
		}

		private void OnDestroy()
		{
			AllChambers.Remove(this);
			OnElevatorRemoved?.Invoke(this);
		}

		private void Update()
		{
			ElevatorSequence curSequence = CurSequence;
			UpdateDestination();
			UpdateSequence();
			if (curSequence != CurSequence)
			{
				OnSequenceChanged?.Invoke();
				ServerEvents.OnElevatorSequenceChanged(new ElevatorSequenceChangedEventArgs(this, curSequence, CurSequence));
			}
		}

		protected override void OnValidate()
		{
			base.OnValidate();
			_cachedBoundsUpToDate = false;
		}

		public void ServerLockAllDoors(DoorLockReason lockReason, bool state)
		{
			foreach (ElevatorDoor floorDoor in _floorDoors)
			{
				if (state)
				{
					floorDoor.NetworkActiveLocks = (ushort)((uint)floorDoor.ActiveLocks | (uint)lockReason);
				}
				else
				{
					floorDoor.NetworkActiveLocks = (ushort)(floorDoor.ActiveLocks & (ushort)(~(int)lockReason));
				}
			}
		}

		public void ServerSetDestination(int level, bool allowQueueing)
		{
			if (IsReady || !allowQueueing)
			{
				Network_syncDestinationLevel = (byte)level;
				_queuedDestination = null;
			}
			else
			{
				_queuedDestination = (byte)level;
			}
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			bool isAllowed = true;
			if (!IsReadyForUserInput)
			{
				isAllowed = false;
			}
			if (DestinationDoor.ActiveLocks != 0)
			{
				isAllowed = false;
			}
			ElevatorPanel panel = ElevatorPanel.AllPanels.First((ElevatorPanel n) => n.AssignedChamber == this && n.ColliderId == colliderId);
			PlayerInteractingElevatorEventArgs obj = new PlayerInteractingElevatorEventArgs(ply, this, panel)
			{
				IsAllowed = isAllowed
			};
			PlayerEvents.OnInteractingElevator(obj);
			if (obj.IsAllowed)
			{
				ServerSetDestination(NextLevel, allowQueueing: false);
				PlayerEvents.OnInteractedElevator(new PlayerInteractedElevatorEventArgs(ply, this, panel));
			}
		}

		private void UpdateDestination()
		{
			if (NetworkServer.active && _queuedDestination.HasValue && IsReady)
			{
				Network_syncDestinationLevel = _queuedDestination.Value;
				_queuedDestination = null;
			}
			if (_lastSetDestinationLevel != DestinationLevel && DestinationLevel >= 0 && DestinationLevel < _floorDoors.Count)
			{
				ForceDestination(DestinationLevel);
			}
		}

		private void UpdateSequence()
		{
			switch (CurSequence)
			{
			case ElevatorSequence.StartingSequence:
				if (!(SequenceElapsed < TargetLagCompensation))
				{
					_travelSounds.ForEach((AudioSource x) =>
					{
						x.Play();
					});
					_sequenceStopwatch.Restart();
					CurSequence = ElevatorSequence.DoorClosing;
					SetInnerDoor(state: false);
				}
				break;
			case ElevatorSequence.MovingAway:
			case ElevatorSequence.Arriving:
			{
				Transform transform = base.transform;
				RelativeBounds worldspaceBounds = WorldspaceBounds;
				transform.GetPositionAndRotation(out var position, out var rotation);
				UpdateMovement(transform, CurSequence == ElevatorSequence.Arriving);
				_cachedBoundsUpToDate = false;
				Vector3 deltaPos = transform.position - position;
				Quaternion deltaRot = transform.rotation * Quaternion.Inverse(rotation);
				OnElevatorMoved?.Invoke(worldspaceBounds.Bounds, this, deltaPos, deltaRot);
				_waypoint.OnMoved(deltaPos, deltaRot);
				break;
			}
			case ElevatorSequence.DoorClosing:
				if (!(SequenceElapsed < _doorCloseTime))
				{
					CurSequence = ElevatorSequence.MovingAway;
					_sequenceStopwatch.Restart();
				}
				break;
			case ElevatorSequence.DoorOpening:
				if (!(SequenceElapsed < _doorOpenTime + TargetLagCompensation))
				{
					CurSequence = ElevatorSequence.Ready;
				}
				break;
			}
		}

		private void UpdateMovement(Transform t, bool arriving)
		{
			ElevatorDoor elevatorDoor = _floorDoors[DestinationLevel];
			float num = _animationTime - TargetLagCompensation;
			float num2 = Mathf.Clamp01(SequenceElapsed / num);
			UpdateRotation(t, elevatorDoor, num2, arriving);
			if (arriving)
			{
				Vector3 a = (GoingUp ? elevatorDoor.BottomPosition : elevatorDoor.TopPosition);
				t.position = Vector3.Lerp(a, elevatorDoor.TargetPosition, _translationCurve.Evaluate(num2));
				if (!(num2 < 1f))
				{
					if (NetworkServer.active)
					{
						elevatorDoor.NetworkTargetState = true;
					}
					SetInnerDoor(state: true);
					_lastArrivedDestination = elevatorDoor;
					UpdateDynamicLock();
					CurSequence = ElevatorSequence.DoorOpening;
					_sequenceStopwatch.Restart();
				}
			}
			else
			{
				Vector3 b = (GoingUp ? _lastArrivedDestination.TopPosition : _lastArrivedDestination.BottomPosition);
				t.position = Vector3.Lerp(_lastArrivedDestination.TargetPosition, b, 1f - _translationCurve.Evaluate(1f - num2));
				if (!(num2 < 1f))
				{
					t.SetParent(elevatorDoor.transform.parent);
					CurSequence = ElevatorSequence.Arriving;
					_sequenceStopwatch.Restart();
				}
			}
		}

		private void UpdateRotation(Transform t, ElevatorDoor dest, float f, bool arriving)
		{
			if (arriving)
			{
				f++;
			}
			f = Mathf.InverseLerp(_rotationTime, 2f - _rotationTime, f);
			Quaternion rotation = _lastArrivedDestination.transform.rotation;
			Quaternion rotation2 = dest.transform.rotation;
			t.rotation = Quaternion.Lerp(rotation, rotation2, _rotationCurve.Evaluate(f));
		}

		private void UpdateDynamicLock()
		{
			if (!_dynamicAdminLock)
			{
				return;
			}
			for (int i = 0; i < _floorDoors.Count; i++)
			{
				if (i == DestinationLevel)
				{
					ElevatorDoor elevatorDoor = _floorDoors[i];
					elevatorDoor.NetworkActiveLocks = (ushort)(elevatorDoor.ActiveLocks & 0xFFF7);
				}
				else
				{
					ElevatorDoor elevatorDoor2 = _floorDoors[i];
					elevatorDoor2.NetworkActiveLocks = (ushort)(elevatorDoor2.ActiveLocks | 8);
				}
			}
		}

		private void OnDrawGizmosSelected()
		{
			List<Vector3> list = WorldspaceBounds.GetWireframePoints().ToList();
			Gizmos.color = Color.green;
			for (int i = 1; i < list.Count - 1; i++)
			{
				Gizmos.DrawLine(list[i - 1], list[i]);
			}
			Gizmos.color = Color.red;
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				Vector3 vector = WorldspaceBounds.LocalToWorld(WorldspaceBounds.WorldToLocal(hub.transform.position));
				Gizmos.DrawLine(WorldspaceBounds.Origin, vector);
				Gizmos.DrawSphere(vector, 0.1f);
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
				GeneratedNetworkCode._Write_Interactables_002EInterobjects_002EElevatorGroup(writer, AssignedGroup);
				NetworkWriterExtensions.WriteByte(writer, _syncDestinationLevel);
				NetworkWriterExtensions.WriteByte(writer, _waypointId);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				GeneratedNetworkCode._Write_Interactables_002EInterobjects_002EElevatorGroup(writer, AssignedGroup);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncDestinationLevel);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _waypointId);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref AssignedGroup, null, GeneratedNetworkCode._Read_Interactables_002EInterobjects_002EElevatorGroup(reader));
				GeneratedSyncVarDeserialize(ref _syncDestinationLevel, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref _waypointId, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref AssignedGroup, null, GeneratedNetworkCode._Read_Interactables_002EInterobjects_002EElevatorGroup(reader));
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncDestinationLevel, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _waypointId, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}
