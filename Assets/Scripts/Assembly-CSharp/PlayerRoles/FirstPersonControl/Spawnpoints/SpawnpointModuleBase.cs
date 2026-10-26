using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public abstract class SpawnpointModuleBase : MonoBehaviour, ISpawnpointHandler
	{
		[field: SerializeField]
		public PlayerRoleBase Role { get; private set; }

		public abstract bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot);

		private void OnValidate()
		{
			if (!(Role != null))
			{
				Role = GetComponent<PlayerRoleBase>();
			}
		}
	}
}
