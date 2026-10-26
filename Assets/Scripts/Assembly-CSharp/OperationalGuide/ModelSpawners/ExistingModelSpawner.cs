namespace OperationalGuide.ModelSpawners
{
	public class ExistingModelSpawner : global::OperationalGuide.ModelSpawners.ModelSpawner
	{
		public global::OperationalGuide.ModelSpawners.ExistingModel[] ExistingModels;

		public override bool TrySpawnRole(global::PlayerRoles.RoleTypeId role, out global::OperationalGuide.PannableObject pannableObject)
		{ pannableObject = default;
			return default;
		}

		public ExistingModelSpawner()
		{
		}
	}
}
