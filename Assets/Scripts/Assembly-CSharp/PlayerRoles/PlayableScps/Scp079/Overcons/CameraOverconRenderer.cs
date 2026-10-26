using System.Collections.Generic;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class CameraOverconRenderer : PooledOverconRenderer
	{
		private const float MaxSqrDistanceOtherRoom = 2165f;

		private const float MaxHeightDiff = 40f;

		private const float ElevatorIconHeight = 3f;

		public static HashSet<CameraOvercon> VisibleOvercons = new HashSet<CameraOvercon>();

		public void SpawnOvercon(Scp079Camera newCamera, Scp079InteractableBase target)
		{
			if (CheckVisibility(newCamera, target))
			{
				CameraOvercon fromPool = GetFromPool<CameraOvercon>();
				fromPool.Setup(newCamera, target as Scp079Camera, isElevator: false);
				VisibleOvercons.Add(fromPool);
			}
		}

		internal override void SpawnOvercons(Scp079Camera newCamera)
		{
			ReturnAll();
			VisibleOvercons.Clear();
			foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
			{
				SpawnOvercon(newCamera, allInstance);
			}
			if (!DoorVariant.DoorsByRoom.TryGetValue(newCamera.Room, out var value))
			{
				return;
			}
			foreach (DoorVariant item in value)
			{
				if (item is ElevatorDoor { Hide079NavigationIcons: false } elevatorDoor && !(Mathf.Abs(elevatorDoor.TargetPosition.y - newCamera.Position.y) > 40f) && Scp079Camera.TryGetClosestCamera(elevatorDoor.transform.position, null, out var closest) && !(closest != newCamera))
				{
					List<ElevatorDoor> doorsForGroup = ElevatorDoor.GetDoorsForGroup(elevatorDoor.Group);
					ElevatorDoor targetElevator = doorsForGroup[(doorsForGroup.IndexOf(elevatorDoor) + 1) % doorsForGroup.Count];
					if (targetElevator.Rooms.Length == 1 && Scp079Camera.TryGetClosestCamera(targetElevator.transform.position, (Scp079Camera x) => x.Room == targetElevator.Rooms[0], out var closest2))
					{
						CameraOvercon fromPool = GetFromPool<CameraOvercon>();
						fromPool.Setup(newCamera, closest2, isElevator: true);
						fromPool.Position = elevatorDoor.transform.position + Vector3.up * 3f;
						fromPool.Rescale(newCamera);
						VisibleOvercons.Add(fromPool);
					}
				}
			}
		}

		private bool CheckVisibility(Scp079Camera cur, Scp079InteractableBase target)
		{
			if (!(target is Scp079Camera scp079Camera) || cur == scp079Camera)
			{
				return false;
			}
			Vector3 v = cur.Position - target.Position;
			if (v.MagnitudeOnlyY() > 40f)
			{
				return false;
			}
			if (cur.Room == target.Room)
			{
				return true;
			}
			if (v.sqrMagnitude > 2165f)
			{
				return false;
			}
			if (!scp079Camera.IsMain)
			{
				return false;
			}
			if (cur.Room.ConnectedRooms.Contains(scp079Camera.Room))
			{
				return true;
			}
			return false;
		}
	}
}
