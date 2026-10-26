using System.Collections.Generic;
using Interactables.Interobjects;
using MapGeneration.StaticHelpers;
using UnityEngine;

namespace MapGeneration
{
	public static class RoomUtils
	{
		private static readonly CachedLayerMask RoomDetectionMask = new CachedLayerMask("Default", "InvisibleCollider", "Fence");

		private static readonly List<RoomIdentifier> RoomsNonAlloc = new List<RoomIdentifier>();

		public static Vector3Int PositionToCoords(Vector3 position)
		{
			return new Vector3Int(Mathf.RoundToInt(position.x / RoomIdentifier.GridScale.x), Mathf.RoundToInt(position.y / RoomIdentifier.GridScale.y), Mathf.RoundToInt(position.z / RoomIdentifier.GridScale.z));
		}

		public static Vector3 CoordsToCenterPos(Vector3Int position)
		{
			Vector3 zero = Vector3.zero;
			for (int i = 0; i < 3; i++)
			{
				zero[i] = (float)position[i] * RoomIdentifier.GridScale[i];
			}
			return zero;
		}

		public static bool TryFindRoom(RoomName? name, FacilityZone? zone, RoomShape? shape, out RoomIdentifier foundRoom)
		{
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if ((!name.HasValue || name == allRoomIdentifier.Name) && (!zone.HasValue || zone == allRoomIdentifier.Zone) && (!shape.HasValue || shape == allRoomIdentifier.Shape))
				{
					foundRoom = allRoomIdentifier;
					return true;
				}
			}
			foundRoom = null;
			return false;
		}

		public static List<RoomIdentifier> FindRooms(RoomName? name, FacilityZone? zone, RoomShape? shape, List<RoomIdentifier> list = null)
		{
			if (list == null)
			{
				RoomsNonAlloc.Clear();
				list = RoomsNonAlloc;
			}
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if ((!name.HasValue || name == allRoomIdentifier.Name) && (!zone.HasValue || zone == allRoomIdentifier.Zone) && (!shape.HasValue || shape == allRoomIdentifier.Shape))
				{
					list.Add(allRoomIdentifier);
				}
			}
			return list;
		}

		public static bool TryGetRoom(this Vector3 worldPos, out RoomIdentifier room)
		{
			Vector3Int key = PositionToCoords(worldPos);
			if (RoomIdentifier.RoomsByCoords.TryGetValue(key, out room))
			{
				return true;
			}
			if (TryRaycastRoom(worldPos, Vector3.up, out room))
			{
				return true;
			}
			if (TryRaycastRoom(worldPos, Vector3.down, out room))
			{
				return true;
			}
			room = null;
			return false;
		}

		public static bool TryGetCurrentRoomByBounds(this Vector3 worldPos, out RoomIdentifier room)
		{
			room = null;
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if (allRoomIdentifier.WorldspaceBounds.Contains(worldPos))
				{
					room = allRoomIdentifier;
					return true;
				}
			}
			return false;
		}

		public static bool TryGetCurrentRoom(this ReferenceHub hub, out RoomIdentifier room)
		{
			return hub.CurrentRoomPlayerCache.TryGetCurrent(out room);
		}

		public static bool TryGetLastKnownRoom(this ReferenceHub hub, out RoomIdentifier room)
		{
			return hub.CurrentRoomPlayerCache.TryGetLastValid(out room);
		}

		public static FacilityZone GetZone(this Vector3 worldPos)
		{
			if (!worldPos.TryGetRoom(out var room))
			{
				return FacilityZone.None;
			}
			return room.Zone;
		}

		public static FacilityZone GetCurrentZone(this ReferenceHub hub)
		{
			if (!hub.TryGetCurrentRoom(out var room))
			{
				return FacilityZone.None;
			}
			return room.Zone;
		}

		public static FacilityZone GetLastKnownZone(this ReferenceHub hub)
		{
			if (!hub.TryGetLastKnownRoom(out var room))
			{
				return FacilityZone.None;
			}
			return room.Zone;
		}

		public static bool CompareCoords(this Vector3 lhs, Vector3 rhs)
		{
			return PositionToCoords(lhs) == PositionToCoords(rhs);
		}

		private static bool TryRaycastRoom(Vector3 pos, Vector3 dir, out RoomIdentifier room)
		{
			if (Physics.Raycast(new Ray(pos, dir), out var hitInfo, 15f, RoomDetectionMask) && hitInfo.collider != null)
			{
				Transform transform = hitInfo.collider.transform;
				if (transform.TryGetComponentInParent<IRoomObject>(out var comp))
				{
					room = comp.OriginalRoom;
					return room != null;
				}
				if (transform.TryGetComponentInParent<RoomIdentifier>(out room))
				{
					return room != null;
				}
				if (transform.TryGetComponentInParent<ElevatorChamber>(out var comp2))
				{
					room = comp2.CurrentRoom;
					return room != null;
				}
			}
			room = null;
			return false;
		}
	}
}
