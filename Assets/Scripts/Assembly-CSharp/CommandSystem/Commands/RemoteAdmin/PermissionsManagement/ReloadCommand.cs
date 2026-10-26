using System;
using GameCore;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement
{
	[CommandHandler(typeof(PermissionsManagementCommand))]
	public class ReloadCommand : ICommand
	{
		public string Command { get; } = "reload";

		public string[] Aliases { get; } = new string[1] { "rl" };

		public string Description { get; } = "Reloads the permissions file.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " reloaded permissions files.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			ConfigFile.ReloadGameConfigs();
			ServerStatic.RolesConfig.Reload();
			ServerStatic.SharedGroupsConfig = ((ConfigSharing.Paths[4] == null) ? null : new YamlConfig(ConfigSharing.Paths[4] + "shared_groups.txt"));
			ServerStatic.SharedGroupsMembersConfig = ((ConfigSharing.Paths[5] == null) ? null : new YamlConfig(ConfigSharing.Paths[5] + "shared_groups_members.txt"));
			ServerStatic.PermissionsHandler = new PermissionsHandler(ref ServerStatic.RolesConfig, ref ServerStatic.SharedGroupsConfig, ref ServerStatic.SharedGroupsMembersConfig);
			response = "Permissions file reloaded.";
			return true;
		}
	}
}
