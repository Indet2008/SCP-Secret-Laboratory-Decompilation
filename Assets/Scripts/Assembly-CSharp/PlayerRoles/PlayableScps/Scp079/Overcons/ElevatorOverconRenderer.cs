using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class ElevatorOverconRenderer : PooledOverconRenderer
	{
		private const float Height = 1.25f;

		internal override void SpawnOvercons(Scp079Camera newCamera)
		{
			ReturnAll();
			if (!DoorVariant.DoorsByRoom.TryGetValue(newCamera.Room, out var value))
			{
				return;
			}
			foreach (DoorVariant item in value)
			{
				if (item is ElevatorDoor elevatorDoor)
				{
					ElevatorOvercon fromPool = GetFromPool<ElevatorOvercon>();
					fromPool.Target = elevatorDoor;
					fromPool.transform.position = elevatorDoor.transform.position + Vector3.up * 1.25f;
					fromPool.Rescale(newCamera);
				}
			}
		}
	}
}
