using PlayerRoles.FirstPersonControl.Spawnpoints;
using UnityEngine;

namespace PlayerRoles.PlayableScps
{
	public class ScpStandardSpawnpoint : SpawnpointModuleBase
	{
		[SerializeField]
		private RoomRoleSpawnpoint _roomSpawnpoint;

		public override bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot)
		{
			return _roomSpawnpoint.TryGetSpawnpoint(out position, out horizontalRot);
		}
	}
}
