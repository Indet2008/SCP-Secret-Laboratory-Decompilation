namespace LabApi.Features.Permissions
{
	public interface IPermissionsProvider
	{
		string[] GetPermissions(global::LabApi.Features.Wrappers.Player player);

		bool HasPermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions);

		bool HasAnyPermission(global::LabApi.Features.Wrappers.Player player, params string[] permissions);

		bool HasPermission(global::LabApi.Features.Wrappers.Player player, string specificPermission)
		{
			return HasAnyPermission(player, specificPermission);
		}

		void AddPermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions);

		void RemovePermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions);

		void ReloadPermissions()
		{
		}
	}
}
