namespace Interactables.Interobjects.DoorUtils
{
	public interface IDoorPermissionRequester
	{
		DoorPermissionsPolicy PermissionsPolicy { get; }

		string RequesterLogSignature { get; }
	}
}
