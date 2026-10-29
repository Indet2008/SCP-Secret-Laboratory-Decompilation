namespace LabApi.Features.Permissions.Providers
{
	public class PermissionGroup
	{
		public static global::LabApi.Features.Permissions.Providers.PermissionGroup Default => new global::LabApi.Features.Permissions.Providers.PermissionGroup(global::System.Array.Empty<string>(), global::System.Array.Empty<string>());

		public static global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Permissions.Providers.PermissionGroup> DefaultPermissionGroups => new global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Permissions.Providers.PermissionGroup> { ["default"] = Default };

		public string[] InheritedGroups { get; set; }

		public string[] Permissions { get; set; }

		[global::YamlDotNet.Serialization.YamlIgnore]
		public bool IsRoot { get; set; }

		[global::YamlDotNet.Serialization.YamlIgnore]
		internal global::System.Collections.Generic.HashSet<string> SpecialPermissionsSuperset { get; } = new global::System.Collections.Generic.HashSet<string>();

		public PermissionGroup()
			: this(global::System.Array.Empty<string>(), global::System.Array.Empty<string>())
		{
		}

		public PermissionGroup(string[] inheritedGroups, string[] permissions)
		{
			InheritedGroups = inheritedGroups;
			Permissions = permissions;
		}
	}
}
