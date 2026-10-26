using System.Collections.Generic;
using System.Linq;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public class Scp244TransferCondition
	{
		private static readonly Vector3 DoorDetectionThickness = new Vector3(3f, 100f, 3f);

		private const float MinimalDoorGapSqrt = 9f;

		private const float BorderDoorCheck = 1.05f;

		public readonly Bounds BoundsToEncapsulate;

		public readonly DoorVariant[] Doors;

		public readonly float ClosestPoint;

		private Scp244TransferCondition(Bounds b, DoorVariant[] dv, Scp244DeployablePickup scp)
		{
			Vector3 position = scp.transform.position;
			ClosestPoint = Vector3.Distance(position, b.ClosestPoint(position));
			BoundsToEncapsulate = b;
			Doors = dv ?? new DoorVariant[0];
		}

		public static Scp244TransferCondition[] GenerateTransferConditions(Scp244DeployablePickup scp244)
		{
			List<Scp244TransferCondition> list = new List<Scp244TransferCondition>();
			Vector3 position = scp244.transform.position;
			Vector3Int startCoords = RoomUtils.PositionToCoords(position);
			if (!position.TryGetRoom(out var room))
			{
				Bounds b = new Bounds(scp244.transform.position, Vector3.one * scp244.MaxDiameter * 2f);
				list.Add(new Scp244TransferCondition(b, null, scp244));
				return list.ToArray();
			}
			List<Bounds> list2 = new List<Bounds>();
			HashSet<Vector3> hashSet = new HashSet<Vector3>();
			Bounds boundsOfEntireRoom = GetBoundsOfEntireRoom(room);
			HashSet<DoorVariant> hashSet2 = new HashSet<DoorVariant>();
			list2.Add(boundsOfEntireRoom);
			List<Vector3Int> list3 = new List<Vector3Int>();
			AddNearbyRooms(list3, startCoords, room);
			foreach (Vector3Int item in list3)
			{
				if (RoomIdentifier.RoomsByCoords.TryGetValue(item, out var value) && !(value == null))
				{
					list2.Add(value.WorldspaceBounds);
				}
			}
			foreach (Bounds item2 in list2)
			{
				if (hashSet.Add(item2.center))
				{
					Bounds bounds = new Bounds(boundsOfEntireRoom.center, DoorDetectionThickness);
					bounds.Encapsulate(item2.center);
					AddDoorsFromRoom(hashSet2, bounds, boundsOfEntireRoom.center, list2);
					AddDoorsFromRoom(hashSet2, bounds, item2.center, list2);
					list.Add(new Scp244TransferCondition(item2, hashSet2.ToArray(), scp244));
					hashSet2.Clear();
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				if (!(list[i].ClosestPoint < scp244.MaxDiameter))
				{
					list.RemoveAt(i);
					i--;
				}
			}
			return list.ToArray();
		}

		private static Bounds GetBoundsOfEntireRoom(RoomIdentifier rid)
		{
			Bounds result = new Bounds(rid.transform.position, Vector3.zero);
			Vector3 gridScale = RoomIdentifier.GridScale;
			result.Encapsulate(new Bounds(Vector3.Scale(rid.MainCoords, gridScale), gridScale));
			result.Encapsulate(rid.WorldspaceBounds);
			return result;
		}

		private static void AddNearbyRooms(List<Vector3Int> nearbyRooms, Vector3Int startCoords, RoomIdentifier startRoom)
		{
			if (!DoorVariant.DoorsByRoom.TryGetValue(startRoom, out var value))
			{
				return;
			}
			Vector3 position = startRoom.transform.position;
			foreach (DoorVariant item in value)
			{
				Vector3 vector = item.transform.position - position;
				Vector3Int vector3Int = RoomUtils.PositionToCoords(position + vector * 1.05f);
				if (vector3Int != startCoords)
				{
					nearbyRooms.Add(vector3Int);
				}
			}
		}

		private static void AddDoorsFromRoom(HashSet<DoorVariant> doors, Bounds bounds, Vector3 room, List<Bounds> allBounds)
		{
			if (!RoomIdentifier.RoomsByCoords.TryGetValue(RoomUtils.PositionToCoords(room), out var value) || !DoorVariant.DoorsByRoom.TryGetValue(value, out var value2))
			{
				return;
			}
			foreach (DoorVariant item in value2)
			{
				Vector3 position = item.transform.position;
				if (!bounds.Contains(position))
				{
					continue;
				}
				int num = 0;
				foreach (Bounds allBound in allBounds)
				{
					if (!(allBound.SqrDistance(position) > 9f) && ++num > 1)
					{
						doors.Add(item);
						break;
					}
				}
			}
		}
	}
}
