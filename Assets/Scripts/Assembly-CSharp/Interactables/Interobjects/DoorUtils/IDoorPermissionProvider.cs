namespace Interactables.Interobjects.DoorUtils
{
	public interface IDoorPermissionProvider
	{
		PermissionUsed PermissionsUsedCallback { get; }

		DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester);
	}
}
