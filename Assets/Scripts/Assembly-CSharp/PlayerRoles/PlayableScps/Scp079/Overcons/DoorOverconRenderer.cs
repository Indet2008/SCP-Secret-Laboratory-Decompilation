using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class DoorOverconRenderer : PooledOverconRenderer
	{
		private const float DoorHeight = 1.25f;

		internal override void SpawnOvercons(Scp079Camera newCamera)
		{
			ReturnAll();
			if (!DoorVariant.DoorsByRoom.TryGetValue(newCamera.Room, out var value))
			{
				return;
			}
			foreach (DoorVariant item in value)
			{
				if (!Scp079DoorAbility.CheckVisibility(item, newCamera))
				{
					continue;
				}
				Vector3 vector;
				if (item is CheckpointDoor checkpointDoor)
				{
					Vector3 zero = Vector3.zero;
					DoorVariant[] subDoors = checkpointDoor.SubDoors;
					foreach (DoorVariant doorVariant in subDoors)
					{
						zero += doorVariant.transform.position;
					}
					vector = zero / checkpointDoor.SubDoors.Length;
				}
				else
				{
					vector = item.transform.position;
				}
				DoorOvercon fromPool = GetFromPool<DoorOvercon>();
				fromPool.Target = item;
				fromPool.transform.position = vector + Vector3.up * 1.25f;
				fromPool.Rescale(newCamera);
			}
		}
	}
}
