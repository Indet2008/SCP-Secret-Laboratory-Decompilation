using System;
using System.Collections.Generic;
using System.Linq;
using MapGeneration;
using NorthwoodLib.Pools;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	[Serializable]
	public class RoomRoleSpawnpoint : ISpawnpointHandler
	{
		private List<BoundsRoleSpawnpoint> _spawnpointsCache;

		private int? _lastSeed;

		[SerializeField]
		private RoomName _fName;

		[SerializeField]
		private FacilityZone _fZone;

		[SerializeField]
		private RoomShape _fShape;

		[SerializeField]
		private Vector3 _localPoint;

		[SerializeField]
		private float _lookAngle;

		[SerializeField]
		private float _angleVar;

		[SerializeField]
		private float _width;

		[SerializeField]
		private float _length;

		[SerializeField]
		private int _wNum;

		[SerializeField]
		private int _lNum;

		[Tooltip("Specify room types that the chosen spawnpoint should strive to be a a certain meters distance from. This filter will be ignored if it filters out all room instances available.")]
		[SerializeField]
		private RoomName[] _requireDistanceFrom = new RoomName[0];

		[Tooltip("Set this to more than 0 if there are multiple instances of this room, and only ones further away from all rooms in _requireDistanceFrom than <this value> in meters should be valid spawnpoints. This filter will be ignored if it filters out all room instances available.")]
		[SerializeField]
		private int _distanceRequiredMeters;

		private static readonly RoomName[] ExcludedRooms = new RoomName[1] { RoomName.HczCheckpointToEntranceZone };

		private List<BoundsRoleSpawnpoint> Spawnpoints
		{
			get
			{
				if (_spawnpointsCache == null || _lastSeed != SeedSynchronizer.Seed)
				{
					RefreshSpawnpoints();
				}
				return _spawnpointsCache;
			}
		}

		public RoomRoleSpawnpoint(Vector3 localPoint, float lookRotation, float lookAngleVariation, float boundsWidth, float boundsLength, int spawnpointsInWidth, int spawnpointsInLength, RoomName nameFilter = RoomName.Unnamed, FacilityZone zoneFilter = FacilityZone.None, RoomShape shapeFilter = RoomShape.Undefined)
		{
			_fName = nameFilter;
			_fZone = zoneFilter;
			_fShape = shapeFilter;
			_localPoint = localPoint;
			_lookAngle = lookRotation;
			_angleVar = lookAngleVariation;
			_width = boundsWidth;
			_length = boundsLength;
			_wNum = spawnpointsInWidth;
			_lNum = spawnpointsInLength;
		}

		public RoomRoleSpawnpoint(RoomRoleSpawnpoint t)
			: this(t._localPoint, t._lookAngle, t._angleVar, t._width, t._length, t._wNum, t._lNum, t._fName, t._fZone, t._fShape)
		{
		}

		public bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot)
		{
			if (Spawnpoints.Count == 0)
			{
				position = Vector3.zero;
				horizontalRot = 0f;
				return false;
			}
			return Spawnpoints.RandomItem().TryGetSpawnpoint(out position, out horizontalRot);
		}

		public bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot, int spawnpointIndex)
		{
			position = default;
			horizontalRot = 0f;
			if (spawnpointIndex > Spawnpoints.Count - 1)
			{
				Debug.LogWarning("Provided spawnpointIndex was too high.");
				return false;
			}
			return Spawnpoints[spawnpointIndex].TryGetSpawnpoint(out position, out horizontalRot);
		}

		public void FilterSpawnpointsByDistance()
		{
			if (_distanceRequiredMeters <= 0 || _requireDistanceFrom.Length == 0)
			{
				return;
			}
			BoundsRoleSpawnpoint[] array = Spawnpoints.ToArray();
			Spawnpoints.Clear();
			List<RoomIdentifier> list = ListPool<RoomIdentifier>.Shared.Rent();
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if (_requireDistanceFrom.Contains(allRoomIdentifier.Name))
				{
					list.Add(allRoomIdentifier);
				}
			}
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].TryGetSpawnpoint(out var spawnpointPosition, out var _) && list.Any((RoomIdentifier roomType) => roomType != null && (roomType.transform.position - spawnpointPosition).sqrMagnitude < (float)(_distanceRequiredMeters * _distanceRequiredMeters)))
				{
					Spawnpoints.Add(array[i]);
				}
			}
			ListPool<RoomIdentifier>.Shared.Return(list);
		}

		public int GetRoomAmount()
		{
			return Spawnpoints.Count;
		}

		private void RefreshSpawnpoints()
		{
			if (_spawnpointsCache != null)
			{
				_spawnpointsCache.Clear();
			}
			else
			{
				_spawnpointsCache = new List<BoundsRoleSpawnpoint>();
			}
			_lastSeed = SeedSynchronizer.Seed;
			RoomName? name = ((_fName == RoomName.Unnamed) ? ((RoomName?)null) : new RoomName?(_fName));
			FacilityZone? zone = ((_fZone == FacilityZone.None) ? ((FacilityZone?)null) : new FacilityZone?(_fZone));
			RoomShape? shape = ((_fShape == RoomShape.Undefined) ? ((RoomShape?)null) : new RoomShape?(_fShape));
			foreach (RoomIdentifier item in RoomUtils.FindRooms(name, zone, shape))
			{
				if (!ExcludedRooms.Contains(item.Name))
				{
					Transform transform = item.transform;
					Bounds bounds = new Bounds(transform.TransformPoint(_localPoint), transform.rotation * new Vector3(_width, 0f, _length));
					Vector3 vector = transform.rotation * new Vector3(_wNum, 0f, _lNum);
					Vector3Int size = new Vector3Int(Mathf.RoundToInt(Mathf.Abs(vector.x)), 1, Mathf.RoundToInt(Mathf.Abs(vector.z)));
					float num = transform.rotation.eulerAngles.y + _lookAngle;
					_spawnpointsCache.Add(new BoundsRoleSpawnpoint(bounds, num - _angleVar, num + _angleVar, size));
				}
			}
			FilterSpawnpointsByDistance();
		}
	}
}
