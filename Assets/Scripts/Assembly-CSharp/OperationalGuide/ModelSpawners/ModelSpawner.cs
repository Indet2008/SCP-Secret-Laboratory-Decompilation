using System.Collections.Generic;
using PlayerRoles;
using UnityEngine;

namespace OperationalGuide.ModelSpawners
{
	public class ModelSpawner : MonoBehaviour
	{
		public GameObject StandPrefab;

		protected Dictionary<RoleTypeId, PannableObject> AlreadySpawnedRoles = new Dictionary<RoleTypeId, PannableObject>();

		public virtual bool TrySpawnRole(RoleTypeId role, out PannableObject pannableObject)
		{
			pannableObject = null;
			return false;
		}
	}
}
