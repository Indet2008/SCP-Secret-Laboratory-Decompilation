using System.Linq;
using UnityEngine;
using UnityEngine.Serialization;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public class StandardSpawnpointHandler : SpawnpointModuleBase
	{
		[SerializeField]
		[FormerlySerializedAs("_spawnpoints")]
		protected RoomRoleSpawnpoint[] Spawnpoints;

		public override bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot)
		{
			position = default;
			horizontalRot = 0f;
			RoomRoleSpawnpoint[] validSpawnpoints = GetValidSpawnpoints(Spawnpoints);
			if (validSpawnpoints.Length == 0)
			{
				return false;
			}
			return validSpawnpoints.RandomItem().TryGetSpawnpoint(out position, out horizontalRot);
		}

		protected static RoomRoleSpawnpoint[] GetValidSpawnpoints(RoomRoleSpawnpoint[] allSpawnpoints)
		{
			return allSpawnpoints.Where((RoomRoleSpawnpoint x) => x.GetRoomAmount() > 0).ToArray();
		}
	}
}
