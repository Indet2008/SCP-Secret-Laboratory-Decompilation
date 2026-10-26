using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public interface ISpawnpointHandler
	{
		bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot);
	}
}
