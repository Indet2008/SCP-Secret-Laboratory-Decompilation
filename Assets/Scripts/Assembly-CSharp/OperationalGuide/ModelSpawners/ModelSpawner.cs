namespace OperationalGuide.ModelSpawners
{
	public class ModelSpawner : global::UnityEngine.MonoBehaviour
	{
		public global::UnityEngine.GameObject StandPrefab;

		protected global::System.Collections.Generic.Dictionary<global::PlayerRoles.RoleTypeId, global::OperationalGuide.PannableObject> AlreadySpawnedRoles;

		public virtual bool TrySpawnRole(global::PlayerRoles.RoleTypeId role, out global::OperationalGuide.PannableObject pannableObject)
		{ pannableObject = default;
			return default;
		}

		public ModelSpawner()
		{
		}
	}
}
