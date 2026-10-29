namespace LabApi.Loader.Features.Commands
{
	[global::CommandSystem.CommandHandler(typeof(global::LabApi.Loader.Features.Commands.LabApiParentCommand))]
	public class PluginPermissionsCommand : global::CommandSystem.ICommand
	{
		public string Command { get; } = "permissions";

		public string[] Aliases { get; } = new string[2] { "p", "perms" };

		public string Description { get; } = "Shows your LabAPI plugin permissions.";

		public bool Execute(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, [global::System.Diagnostics.CodeAnalysis.UnscopedRef] out string response)
		{
			response = "You have the following LabAPI plugin permissions:\n";
			foreach (var (type2, array2) in global::LabApi.Features.Permissions.PermissionsExtensions.GetPermissionsByProvider(sender))
			{
				response = response + type2.Name + ":\n";
				if (array2.Length == 0)
				{
					response += "- No permissions.\n";
					continue;
				}
				response = global::System.Linq.Enumerable.Aggregate(array2, response, (string current, string perm) => current + "+ " + perm + "\n");
			}
			return true;
		}
	}
}
