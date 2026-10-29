using PlayerRoles;
using PlayerRoles.FirstPersonControl.Thirdperson;

namespace OperationalGuide.ModelSpawners
{
	public class ExistingModelSpawner : ModelSpawner
	{
		public ExistingModel[] ExistingModels;

		public override bool TrySpawnRole(RoleTypeId role, out PannableObject pannableObject)
		{
			ExistingModel[] existingModels = ExistingModels;
			for (int i = 0; i < existingModels.Length; i++)
			{
				ExistingModel existingModel = existingModels[i];
				if (existingModel.RoleType == role)
				{
					CharacterModel[] models = existingModel.Models;
					for (int j = 0; j < models.Length; j++)
					{
						models[j].SetAsOwnerless();
					}
					pannableObject = existingModel.PannableObject;
					return true;
				}
			}
			pannableObject = null;
			return false;
		}
	}
}
