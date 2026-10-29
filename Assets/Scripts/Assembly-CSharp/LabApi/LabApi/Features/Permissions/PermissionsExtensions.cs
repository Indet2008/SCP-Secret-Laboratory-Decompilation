namespace LabApi.Features.Permissions
{
	public static class PermissionsExtensions
	{
		public static global::System.Collections.Generic.Dictionary<global::System.Type, string[]> GetPermissionsByProvider(this global::CommandSystem.ICommandSender sender)
		{
			return global::LabApi.Features.Wrappers.Player.Get(sender)?.GetPermissionsByProvider() ?? new global::System.Collections.Generic.Dictionary<global::System.Type, string[]>();
		}

		public static string[] GetPermissions(this global::CommandSystem.ICommandSender sender)
		{
			return global::LabApi.Features.Wrappers.Player.Get(sender)?.GetPermissions() ?? global::System.Array.Empty<string>();
		}

		public static bool HasPermissions(this global::CommandSystem.ICommandSender sender, params string[] permissions)
		{
			return global::LabApi.Features.Wrappers.Player.Get(sender)?.HasPermissions(permissions) ?? (!(sender is global::RemoteAdmin.PlayerCommandSender));
		}

		public static bool HasAnyPermission(this global::CommandSystem.ICommandSender sender, params string[] permissions)
		{
			return global::LabApi.Features.Wrappers.Player.Get(sender)?.HasAnyPermission(permissions) ?? (!(sender is global::RemoteAdmin.PlayerCommandSender));
		}

		public static bool HasPermission(this global::CommandSystem.ICommandSender sender, string specificPermission)
		{
			return global::LabApi.Features.Wrappers.Player.Get(sender)?.HasPermission(specificPermission) ?? (!(sender is global::RemoteAdmin.PlayerCommandSender));
		}

		public static void AddPermissions(this global::CommandSystem.ICommandSender sender, params string[] permissions)
		{
			global::LabApi.Features.Wrappers.Player.Get(sender)?.AddPermissions(permissions);
		}

		public static void RemovePermissions(this global::CommandSystem.ICommandSender sender, params string[] permissions)
		{
			global::LabApi.Features.Wrappers.Player.Get(sender)?.RemovePermissions(permissions);
		}
	}
}
