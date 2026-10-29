namespace LabApi.Features.Permissions
{
	public static class PermissionsManager
	{
		private const string LoggerPrefix = "[PERMISSIONS]";

		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::LabApi.Features.Permissions.IPermissionsProvider> PermissionProviders = new global::System.Collections.Generic.Dictionary<global::System.Type, global::LabApi.Features.Permissions.IPermissionsProvider>();

		public static void RegisterProvider<T>() where T : global::LabApi.Features.Permissions.IPermissionsProvider, new()
		{
			if (PermissionProviders.ContainsKey(typeof(T)))
			{
				global::LabApi.Features.Console.Logger.Warn("[PERMISSIONS] The permission provider of type " + typeof(T).FullName + " is already registered.");
				return;
			}
			global::LabApi.Features.Permissions.IPermissionsProvider permissionsProvider = new T();
			if (permissionsProvider == null)
			{
				global::LabApi.Features.Console.Logger.Error("[PERMISSIONS] Failed to create an instance of the permission provider of type " + typeof(T).FullName + ".");
			}
			else
			{
				PermissionProviders.Add(typeof(T), permissionsProvider);
			}
		}

		public static void UnregisterProvider<T>() where T : global::LabApi.Features.Permissions.IPermissionsProvider, new()
		{
			if (!PermissionProviders.Remove(typeof(T)))
			{
				global::LabApi.Features.Console.Logger.Warn("[PERMISSIONS] Failed to unregister the permission provider of type " + typeof(T).FullName + ". It is not registered.");
			}
		}

		public static global::LabApi.Features.Permissions.IPermissionsProvider? GetProvider<T>() where T : global::LabApi.Features.Permissions.IPermissionsProvider, new()
		{
			if (PermissionProviders.TryGetValue(typeof(T), out global::LabApi.Features.Permissions.IPermissionsProvider value))
			{
				return value;
			}
			global::LabApi.Features.Console.Logger.Warn("[PERMISSIONS] The permission provider of type " + typeof(T).FullName + " is not registered.");
			return null;
		}

		public static global::System.Collections.Generic.Dictionary<global::System.Type, string[]> GetPermissionsByProvider(this global::LabApi.Features.Wrappers.Player player)
		{
			return global::System.Linq.Enumerable.ToDictionary<global::System.Collections.Generic.KeyValuePair<global::System.Type, global::LabApi.Features.Permissions.IPermissionsProvider>, global::System.Type, string[]>(PermissionProviders, (global::System.Collections.Generic.KeyValuePair<global::System.Type, global::LabApi.Features.Permissions.IPermissionsProvider> x) => x.Key, (global::System.Collections.Generic.KeyValuePair<global::System.Type, global::LabApi.Features.Permissions.IPermissionsProvider> x) => x.Value.GetPermissions(player));
		}

		public static string[] GetPermissions(this global::LabApi.Features.Wrappers.Player player)
		{
			return global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.SelectMany(PermissionProviders.Values, (global::LabApi.Features.Permissions.IPermissionsProvider x) => x.GetPermissions(player)));
		}

		public static bool HasPermissions(this global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			return global::System.Linq.Enumerable.Any(PermissionProviders.Values, (global::LabApi.Features.Permissions.IPermissionsProvider x) => x.HasPermissions(player, permissions));
		}

		public static bool HasAnyPermission(this global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			return global::System.Linq.Enumerable.Any(PermissionProviders.Values, (global::LabApi.Features.Permissions.IPermissionsProvider x) => x.HasAnyPermission(player, permissions));
		}

		public static bool HasPermission(this global::LabApi.Features.Wrappers.Player player, string specificPermission)
		{
			return global::System.Linq.Enumerable.Any(PermissionProviders.Values, (global::LabApi.Features.Permissions.IPermissionsProvider x) => x.HasPermission(player, specificPermission));
		}

		public static void AddPermissions(this global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			foreach (global::LabApi.Features.Permissions.IPermissionsProvider value in PermissionProviders.Values)
			{
				value.AddPermissions(player, permissions);
			}
		}

		public static void RemovePermissions(this global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			foreach (global::LabApi.Features.Permissions.IPermissionsProvider value in PermissionProviders.Values)
			{
				value.RemovePermissions(player, permissions);
			}
		}

		public static void ReloadAllPermissionsProviders()
		{
			foreach (global::LabApi.Features.Permissions.IPermissionsProvider value in PermissionProviders.Values)
			{
				value.ReloadPermissions();
			}
		}
	}
}
