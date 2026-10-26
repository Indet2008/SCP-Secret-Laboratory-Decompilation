using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class PredefinedPermsDetail : DetailBase, IDoorPermissionProvider
	{
		[SerializeField]
		private int _containmentLevel;

		[SerializeField]
		private int _armoryLevel;

		[SerializeField]
		private int _adminLevel;

		[SerializeField]
		private Color _color;

		private KeycardLevels Levels => new KeycardLevels(_containmentLevel, _armoryLevel, _adminLevel);

		public PermissionUsed PermissionsUsedCallback => null;

		public override void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template)
		{
			gfxTarget.SetPermissions(Levels, _color);
		}

		public DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			return Levels.Permissions;
		}
	}
}
