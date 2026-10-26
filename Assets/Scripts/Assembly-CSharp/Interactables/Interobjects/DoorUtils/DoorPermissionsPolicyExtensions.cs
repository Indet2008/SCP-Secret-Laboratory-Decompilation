using CustomPlayerEffects;
using InventorySystem.Items;

namespace Interactables.Interobjects.DoorUtils
{
	public static class DoorPermissionsPolicyExtensions
	{
		public static bool HasFlagAll(this DoorPermissionFlags perm, DoorPermissionFlags flag)
		{
			return (perm & flag) == flag;
		}

		public static bool HasFlagAny(this DoorPermissionFlags perm, DoorPermissionFlags flag)
		{
			return (perm & flag) != 0;
		}

		public static bool CheckPermissions(this IDoorPermissionRequester requester, IDoorPermissionProvider provider, out PermissionUsed callback)
		{
			return requester.PermissionsPolicy.CheckPermissions(provider, requester, out callback);
		}

		public static bool CheckPermissions(this IDoorPermissionRequester requester, ReferenceHub player, out PermissionUsed callback)
		{
			return requester.PermissionsPolicy.CheckPermissions(player, requester, out callback);
		}

		public static DoorPermissionFlags GetCombinedPermissions(this ReferenceHub hub, IDoorPermissionRequester requester)
		{
			if (hub == null)
			{
				return DoorPermissionFlags.None;
			}
			if (hub.serverRoles.BypassMode)
			{
				return DoorPermissionFlags.All;
			}
			DoorPermissionFlags doorPermissionFlags = DoorPermissionFlags.None;
			foreach (StatusEffectBase enabledEffect in hub.playerEffectsController.EnabledEffects)
			{
				if (enabledEffect is IDoorPermissionProvider doorPermissionProvider)
				{
					doorPermissionFlags |= doorPermissionProvider.GetPermissions(requester);
				}
			}
			if (hub.roleManager.CurrentRole is IDoorPermissionProvider doorPermissionProvider2)
			{
				doorPermissionFlags |= doorPermissionProvider2.GetPermissions(requester);
			}
			ItemBase curInstance = hub.inventory.CurInstance;
			if (curInstance != null && curInstance is IDoorPermissionProvider doorPermissionProvider3)
			{
				doorPermissionFlags |= doorPermissionProvider3.GetPermissions(requester);
			}
			return doorPermissionFlags;
		}
	}
}
