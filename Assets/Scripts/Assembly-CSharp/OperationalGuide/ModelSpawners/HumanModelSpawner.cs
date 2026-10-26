namespace OperationalGuide.ModelSpawners
{
	public class HumanModelSpawner : global::OperationalGuide.ModelSpawners.ModelSpawner
	{
		private readonly global::UnityEngine.Vector3 _standOffset;

		private readonly global::UnityEngine.Vector3 _modelSizeModifer;

		public override bool TrySpawnRole(global::PlayerRoles.RoleTypeId role, out global::OperationalGuide.PannableObject pannableObject)
		{ pannableObject = default;
			return default;
		}

		public HumanModelSpawner()
		{
		}
	}
}
