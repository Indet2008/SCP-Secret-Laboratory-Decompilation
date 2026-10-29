using PlayerRoles;
using UnityEngine;

namespace OperationalGuide.ModelSpawners
{
	public class SpawnerHandler : MonoBehaviour
	{
		public ModelSpawner[] Spawners;

		public PannableObject SpawnRole(RoleTypeId roleType)
		{
			ModelSpawner[] spawners = Spawners;
			for (int i = 0; i < spawners.Length; i++)
			{
				if (spawners[i].TrySpawnRole(roleType, out var pannableObject))
				{
					return pannableObject;
				}
			}
			return null;
		}
	}
}
