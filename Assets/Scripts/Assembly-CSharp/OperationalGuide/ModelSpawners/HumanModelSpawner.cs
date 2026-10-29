using System.Collections.Generic;
using PlayerRoles;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace OperationalGuide.ModelSpawners
{
	public class HumanModelSpawner : ModelSpawner
	{
		private readonly Vector3 _standOffset = new Vector3(0f, -0.074f, 0f);

		private readonly Vector3 _modelSizeModifer = Vector3.one * 1.1f;

		// Spawns an ownerless copy of the human role's third-person model on a stand; only the requested role stays visible.
		public override bool TrySpawnRole(RoleTypeId role, out PannableObject pannableObject)
		{
			if (!PlayerRoleLoader.TryGetRoleTemplate<HumanRole>(role, out var result))
			{
				pannableObject = null;
				GameCore.Console.AddDebugLog("MISCEL", string.Format("[HumanModelSpawner] Couldn't spawn: {0}", role), MessageImportance.LessImportant);
				return false;
			}
			if (!AlreadySpawnedRoles.TryGetValue(role, out pannableObject))
			{
				GameObject gameObject = Object.Instantiate(result.FpcModule.CharacterModelTemplate, base.gameObject.transform);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localScale = _modelSizeModifer;
				gameObject.GetComponent<AnimatedCharacterModel>().SetAsOwnerless();
				FirearmObject firearmObject = gameObject.AddComponent<FirearmObject>();
				firearmObject.InventoryModel = gameObject.GetComponent<InventorySubcontroller>();
				GameObject gameObject2 = Object.Instantiate(StandPrefab, gameObject.transform);
				gameObject2.transform.localPosition = _standOffset;
				AlreadySpawnedRoles[role] = firearmObject;
				pannableObject = firearmObject;
			}
			foreach (KeyValuePair<RoleTypeId, PannableObject> alreadySpawnedRole in AlreadySpawnedRoles)
			{
				alreadySpawnedRole.Value.gameObject.SetActive(alreadySpawnedRole.Key == role);
			}
			return true;
		}
	}
}
