using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using MapGeneration.Distributors;
using Mirror;
using UnityEngine;

namespace RelativePositioning
{
	public class LockerWaypoint : WaypointBase
	{
		public struct LockerWaypointAssignMessage : NetworkMessage
		{
			public uint LockerNetId;

			public byte Chamber;

			public byte WaypointId;
		}

		private static readonly HashSet<LockerWaypoint> AllInstances = new HashSet<LockerWaypoint>();

		private static readonly Collider[] PickupDetectionNonAlloc = new Collider[16];

		private static readonly CachedLayerMask PickupDetectionLayer = new CachedLayerMask("InteractableNoPlayerCollision");

		[SerializeField]
		private Locker _assignedLocker;

		[SerializeField]
		private LockerChamber _trackedChamber;

		[SerializeField]
		private Bounds _localBounds;

		private readonly List<ItemPickupBase> _adoptedPickups = new List<ItemPickupBase>();

		private Transform _transformCache;

		private bool _trCacheSet;

		private bool _moving;

		private int? _chamberId;

		private byte? _prevWaypointId;

		private byte ChamberIndex
		{
			get
			{
				int valueOrDefault = _chamberId.GetValueOrDefault();
				if (!_chamberId.HasValue)
				{
					valueOrDefault = _assignedLocker.Chambers.IndexOf(_trackedChamber);
					_chamberId = valueOrDefault;
				}
				return (byte)_chamberId.Value;
			}
		}

		private Transform CachedTr
		{
			get
			{
				if (!_trCacheSet)
				{
					_transformCache = base.transform;
					_trCacheSet = true;
				}
				return _transformCache;
			}
		}

		private Bounds WorldspaceBounds
		{
			get
			{
				CachedTr.GetPositionAndRotation(out var position, out var rotation);
				Vector3 center = position + rotation * _localBounds.center;
				Vector3 size = (rotation * _localBounds.size).Abs();
				return new Bounds(center, size);
			}
		}

		protected override float SqrDistanceTo(Vector3 pos)
		{
			if (!_moving || !WorldspaceBounds.Contains(pos))
			{
				return float.MaxValue;
			}
			return -1f;
		}

		public override Vector3 GetWorldspacePosition(Vector3 relPosition)
		{
			return CachedTr.TransformPoint(relPosition);
		}

		public override Vector3 GetRelativePosition(Vector3 worldPoint)
		{
			return CachedTr.InverseTransformPoint(worldPoint);
		}

		public override Quaternion GetWorldspaceRotation(Quaternion relRotation)
		{
			return CachedTr.rotation * relRotation;
		}

		public override Quaternion GetRelativeRotation(Quaternion worldRot)
		{
			return Quaternion.Inverse(CachedTr.rotation) * worldRot;
		}

		protected override void Start()
		{
			base.Start();
			AllInstances.Add(this);
			_trackedChamber.OnDoorStatusSet += OnDoorSet;
			ItemPickupBase.OnPickupAdded += OnPickupAdded;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			AllInstances.Remove(this);
			_trackedChamber.OnDoorStatusSet -= OnDoorSet;
			ItemPickupBase.OnPickupAdded -= OnPickupAdded;
		}

		private void OnDoorSet()
		{
			if (NetworkServer.active && !_moving)
			{
				byte valueOrDefault = _prevWaypointId.GetValueOrDefault();
				if (!_prevWaypointId.HasValue)
				{
					valueOrDefault = FindFreeId();
					_prevWaypointId = valueOrDefault;
				}
				ServerSetWaypoint(_prevWaypointId.Value);
			}
		}

		private void OnPickupAdded(ItemPickupBase ipb)
		{
			if (_moving && WorldspaceBounds.Contains(ipb.Position))
			{
				_adoptedPickups.Add(ipb);
				ipb.transform.SetParent(CachedTr);
			}
		}

		private void Update()
		{
			if (_moving)
			{
				AdoptPickups();
				if (NetworkServer.active && _trackedChamber.CanInteract)
				{
					ServerSetWaypoint(0);
				}
			}
		}

		private void ServerSetWaypoint(byte waypointId)
		{
			ClientSetWaypoint(waypointId);
			NetworkServer.SendToReady(new LockerWaypointAssignMessage
			{
				LockerNetId = _assignedLocker.netId,
				Chamber = ChamberIndex,
				WaypointId = waypointId
			});
		}

		private void ClientSetWaypoint(byte waypointId)
		{
			_moving = waypointId != 0;
			RevalidateAdoptedPickups();
			if (_moving)
			{
				SetId(waypointId);
				AdoptPickups();
			}
		}

		private void AdoptPickups()
		{
			Bounds worldspaceBounds = WorldspaceBounds;
			int num = Physics.OverlapBoxNonAlloc(worldspaceBounds.center, worldspaceBounds.extents, PickupDetectionNonAlloc, Quaternion.identity, PickupDetectionLayer);
			for (int i = 0; i < num; i++)
			{
				if (PickupDetectionNonAlloc[i].transform.TryGetComponentInParent<ItemPickupBase>(out var comp) && worldspaceBounds.Contains(comp.Position) && !(comp.transform.parent == CachedTr))
				{
					_adoptedPickups.Add(comp);
					comp.transform.SetParent(CachedTr);
				}
			}
		}

		private void RevalidateAdoptedPickups()
		{
			Bounds worldspaceBounds = WorldspaceBounds;
			for (int num = _adoptedPickups.Count - 1; num >= 0; num--)
			{
				ItemPickupBase itemPickupBase = _adoptedPickups[num];
				bool flag = itemPickupBase == null;
				Rigidbody component;
				if (flag || !worldspaceBounds.Contains(itemPickupBase.Position))
				{
					if (!flag)
					{
						itemPickupBase.transform.SetParent(null);
					}
					_adoptedPickups.RemoveAt(num);
				}
				else if (NetworkServer.active && itemPickupBase.TryGetComponent<Rigidbody>(out component))
				{
					component.WakeUp();
				}
			}
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.green;
			Gizmos.DrawWireCube(WorldspaceBounds.center, WorldspaceBounds.size);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<LockerWaypointAssignMessage>(ClientProcessMessage);
			};
		}

		private static void ClientProcessMessage(LockerWaypointAssignMessage msg)
		{
			if (NetworkServer.active)
			{
				return;
			}
			foreach (LockerWaypoint allInstance in AllInstances)
			{
				if (allInstance._assignedLocker.netId == msg.LockerNetId && allInstance.ChamberIndex == msg.Chamber)
				{
					allInstance.ClientSetWaypoint(msg.WaypointId);
					break;
				}
			}
		}
	}
}
