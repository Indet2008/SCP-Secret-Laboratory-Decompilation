using System;
using System.Collections.Generic;
using UnityEngine;

namespace RelativePositioning
{
	public abstract class WaypointBase : MonoBehaviour
	{
		private static readonly bool[] SetWaypoints = new bool[255];

		private static readonly byte[] WaypointIndexes = new byte[255];

		private static readonly WaypointBase[] AllWaypoints = new WaypointBase[255];

		private static readonly HashSet<byte> OccupiedIdFinder = new HashSet<byte>(255);

		private byte _id;

		private byte _index;

		protected virtual bool AutoAssign => true;

		protected abstract float SqrDistanceTo(Vector3 pos);

		public abstract Vector3 GetWorldspacePosition(Vector3 relPosition);

		public abstract Vector3 GetRelativePosition(Vector3 worldPos);

		public virtual Quaternion GetWorldspaceRotation(Quaternion relRotation)
		{
			return relRotation;
		}

		public virtual Quaternion GetRelativeRotation(Quaternion worldRot)
		{
			return worldRot;
		}

		protected virtual void Start()
		{
			if (AutoAssign)
			{
				AssignSelfToList();
			}
		}

		protected virtual void OnDestroy()
		{
			RemoveSelfFromList();
		}

		protected virtual void AssignSelfToList()
		{
			for (byte b = 1; b < byte.MaxValue; b++)
			{
				if (!SetWaypoints[b])
				{
					_index = b;
					AllWaypoints[b] = this;
					SetWaypoints[b] = true;
					return;
				}
			}
			Debug.LogError("Could not add waypoint '" + base.name + "' - the list is full.");
		}

		protected virtual void RemoveSelfFromList()
		{
			AllWaypoints[_index] = null;
			SetWaypoints[_index] = false;
		}

		protected void SetId(byte newId)
		{
			if (newId == 0)
			{
				throw new InvalidOperationException("Cannot assign ID of 0 to a waypoint. This ID is reserved for the value of null.");
			}
			_id = newId;
			WaypointIndexes[_id] = _index;
		}

		protected byte FindFreeId()
		{
			OccupiedIdFinder.Clear();
			for (byte b = 1; b < byte.MaxValue; b++)
			{
				if (SetWaypoints[b])
				{
					OccupiedIdFinder.Add(AllWaypoints[b]._id);
				}
			}
			for (byte b2 = 1; b2 < byte.MaxValue; b2++)
			{
				if (!OccupiedIdFinder.Contains(b2))
				{
					return b2;
				}
			}
			Debug.LogError("Could find an empty id for '" + base.name + "'.");
			return 0;
		}

		private static void ExtractWaypointData(Vector3 worldPoint, bool extractPoint, Quaternion worldRot, bool extractRot, out byte closestId, out Vector3 relPoint, out Quaternion relRot)
		{
			float num = float.MaxValue;
			relPoint = Vector3.zero;
			relRot = Quaternion.identity;
			closestId = 0;
			WaypointBase waypointBase = null;
			for (byte b = 1; b < byte.MaxValue; b++)
			{
				if (SetWaypoints[b])
				{
					WaypointBase waypointBase2 = AllWaypoints[b];
					float num2 = waypointBase2.SqrDistanceTo(worldPoint);
					if (!(num2 > num))
					{
						num = num2;
						waypointBase = waypointBase2;
						closestId = waypointBase2._id;
					}
				}
			}
			if (closestId != 0)
			{
				if (extractPoint)
				{
					relPoint = waypointBase.GetRelativePosition(worldPoint);
				}
				if (extractRot)
				{
					relRot = waypointBase.GetRelativeRotation(worldRot);
				}
			}
		}

		public static void GetRelativePositionAndRotation(Vector3 worldPoint, Quaternion worldRot, out byte closestId, out Vector3 relPoint, out Quaternion relRot)
		{
			ExtractWaypointData(worldPoint, extractPoint: true, worldRot, extractRot: true, out closestId, out relPoint, out relRot);
		}

		public static void GetRelativePosition(Vector3 worldPoint, out byte closestId, out Vector3 rel)
		{
			ExtractWaypointData(worldPoint, extractPoint: true, Quaternion.identity, extractRot: false, out closestId, out rel, out var _);
		}

		public static void GetRelativeRotation(Vector3 center, Quaternion worldRot, out byte closestId, out Quaternion rel)
		{
			ExtractWaypointData(center, extractPoint: false, worldRot, extractRot: true, out closestId, out var _, out rel);
		}

		public static Vector3 GetWorldPosition(byte id, Vector3 point)
		{
			if (!TryGetWaypoint(id, out var wp))
			{
				return point;
			}
			return wp.GetWorldspacePosition(point);
		}

		public static Quaternion GetRelativeRotation(byte id, Quaternion rot)
		{
			if (!TryGetWaypoint(id, out var wp))
			{
				return rot;
			}
			return wp.GetRelativeRotation(rot);
		}

		public static Quaternion GetWorldRotation(byte id, Quaternion rot)
		{
			if (!TryGetWaypoint(id, out var wp))
			{
				return rot;
			}
			return wp.GetWorldspaceRotation(rot);
		}

		public static bool TryGetWaypoint(byte id, out WaypointBase wp)
		{
			int num = WaypointIndexes[id];
			bool result = SetWaypoints[num];
			wp = AllWaypoints[num];
			return result;
		}

		public static bool TryGetWaypoint<T>(byte id, out T wp) where T : class
		{
			wp = null;
			if (!TryGetWaypoint(id, out var wp2))
			{
				return false;
			}
			wp = wp2 as T;
			return wp != null;
		}
	}
}
