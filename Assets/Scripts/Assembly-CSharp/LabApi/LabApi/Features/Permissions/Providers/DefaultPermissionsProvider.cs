namespace LabApi.Features.Permissions.Providers
{
	public class DefaultPermissionsProvider : global::LabApi.Features.Permissions.IPermissionsProvider
	{
		private const string LoggerPrefix = "[PERMISSIONS_PROVIDER]";

		private const string PermissionsFileName = "permissions.yml";

		private readonly global::System.IO.FileInfo _permissions;

		private global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Permissions.Providers.PermissionGroup> _permissionsDictionary = new global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Permissions.Providers.PermissionGroup>();

		public DefaultPermissionsProvider()
		{
			_permissions = new global::System.IO.FileInfo(global::System.IO.Path.Combine(global::LabApi.Loader.Features.Paths.PathManager.Configs.FullName, "permissions.yml"));
			if (!_permissions.Exists)
			{
				global::LabApi.Features.Console.Logger.Warn("[PERMISSIONS_PROVIDER] Permissions file not found. Creating a new one.");
				LoadDefaultPermissions();
				SavePermissions();
				return;
			}
			try
			{
				_permissionsDictionary = global::Serialization.YamlParser.Deserializer.Deserialize<global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Permissions.Providers.PermissionGroup>>(global::System.IO.File.ReadAllText(_permissions.FullName));
				ReloadPermissions();
				SavePermissions();
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error("[PERMISSIONS_PROVIDER] Failed to load permissions from file " + _permissions.FullName + ".");
				global::LabApi.Features.Console.Logger.Error(message);
				throw;
			}
		}

		public string[] GetPermissions(global::LabApi.Features.Wrappers.Player player)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup playerGroup = GetPlayerGroup(player);
			return GetPermissions(playerGroup);
		}

		public bool HasPermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup group = GetPlayerGroup(player);
			return global::System.Linq.Enumerable.All(permissions, (string permission) => HasPermission(group, permission));
		}

		public bool HasAnyPermission(global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup group = GetPlayerGroup(player);
			return global::System.Linq.Enumerable.Any(permissions, (string permission) => HasPermission(group, permission));
		}

		public bool HasPermission(global::LabApi.Features.Wrappers.Player player, string specificPermission)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup playerGroup = GetPlayerGroup(player);
			return HasPermission(playerGroup, specificPermission);
		}

		public void AddPermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup playerGroup = GetPlayerGroup(player);
			string[] permissions2 = playerGroup.Permissions;
			int num = 0;
			string[] array = new string[permissions2.Length + permissions.Length];
			global::System.ReadOnlySpan<string> readOnlySpan = new global::System.ReadOnlySpan<string>(permissions2);
			readOnlySpan.CopyTo(new global::System.Span<string>(array).Slice(num, readOnlySpan.Length));
			num += readOnlySpan.Length;
			global::System.ReadOnlySpan<string> readOnlySpan2 = new global::System.ReadOnlySpan<string>(permissions);
			readOnlySpan2.CopyTo(new global::System.Span<string>(array).Slice(num, readOnlySpan2.Length));
			num += readOnlySpan2.Length;
			playerGroup.Permissions = array;
			ReloadPermissions();
			SavePermissions();
		}

		public void RemovePermissions(global::LabApi.Features.Wrappers.Player player, params string[] permissions)
		{
			global::LabApi.Features.Permissions.Providers.PermissionGroup playerGroup = GetPlayerGroup(player);
			playerGroup.Permissions = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Except<string>(playerGroup.Permissions, permissions));
			ReloadPermissions();
			SavePermissions();
		}

		void global::LabApi.Features.Permissions.IPermissionsProvider.ReloadPermissions()
		{
			ReloadPermissions();
		}

		private global::LabApi.Features.Permissions.Providers.PermissionGroup GetPlayerGroup(global::LabApi.Features.Wrappers.Player player)
		{
			return global::System.Collections.Generic.CollectionExtensions.GetValueOrDefault(_permissionsDictionary, player.PermissionsGroupName ?? "default") ?? global::LabApi.Features.Permissions.Providers.PermissionGroup.Default;
		}

		private string[] GetPermissions(global::LabApi.Features.Permissions.Providers.PermissionGroup group)
		{
			global::System.Collections.Generic.List<string> list = global::NorthwoodLib.Pools.ListPool<string>.Shared.Rent();
			list.AddRange(group.Permissions);
			list.AddRange(group.SpecialPermissionsSuperset);
			string[] inheritedGroups = group.InheritedGroups;
			foreach (string key in inheritedGroups)
			{
				if (_permissionsDictionary.TryGetValue(key, out global::LabApi.Features.Permissions.Providers.PermissionGroup value))
				{
					list.AddRange(GetPermissions(value));
				}
			}
			return list.ToArray();
		}

		private bool HasPermission(global::LabApi.Features.Permissions.Providers.PermissionGroup group, string permission)
		{
			if (group.IsRoot)
			{
				return true;
			}
			if (group.Permissions.Contains<string>(permission))
			{
				return true;
			}
			if (permission.Contains("."))
			{
				string text = permission[..permission.LastIndexOf(".", global::System.StringComparison.Ordinal)];
				if (group.SpecialPermissionsSuperset.Contains(text + ".*"))
				{
					return true;
				}
			}
			string[] inheritedGroups = group.InheritedGroups;
			foreach (string key in inheritedGroups)
			{
				if (_permissionsDictionary.TryGetValue(key, out global::LabApi.Features.Permissions.Providers.PermissionGroup value) && HasPermission(value, permission))
				{
					return true;
				}
			}
			return false;
		}

		private void LoadDefaultPermissions()
		{
			_permissionsDictionary = global::LabApi.Features.Permissions.Providers.PermissionGroup.DefaultPermissionGroups;
			ReloadPermissions();
		}

		private void ReloadPermissions()
		{
			foreach (global::LabApi.Features.Permissions.Providers.PermissionGroup value in _permissionsDictionary.Values)
			{
				value.SpecialPermissionsSuperset.Clear();
				string[] permissions = value.Permissions;
				foreach (string text in permissions)
				{
					if (text == ".*")
					{
						value.IsRoot = true;
						break;
					}
					if (text.Contains(".*"))
					{
						string text2 = text[..text.LastIndexOf(".", global::System.StringComparison.Ordinal)];
						value.SpecialPermissionsSuperset.Add(text2 + ".*");
					}
				}
			}
		}

		private void SavePermissions()
		{
			global::System.IO.File.WriteAllText(_permissions.FullName, global::Serialization.YamlParser.Serializer.Serialize(_permissionsDictionary));
		}
	}
}
