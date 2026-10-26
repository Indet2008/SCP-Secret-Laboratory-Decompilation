using System;
using GameCore;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(ConfigCommand))]
	public class ReloadCommand : ICommand
	{
		public string Command { get; } = "reload";

		public string[] Aliases { get; } = new string[2] { "r", "rld" };

		public string Description { get; } = "Reloads the games config";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			try
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " reloaded configuration and permissions files.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				ConfigFile.ReloadGameConfigs();
				ServerStatic.RolesConfig = new YamlConfig(ServerStatic.RolesConfigPath ?? (FileManager.GetAppFolder(addSeparator: true, serverConfig: true) + "config_remoteadmin.txt"));
				ServerStatic.SharedGroupsConfig = ((ConfigSharing.Paths[4] == null) ? null : new YamlConfig(ConfigSharing.Paths[4] + "shared_groups.txt"));
				ServerStatic.SharedGroupsMembersConfig = ((ConfigSharing.Paths[5] == null) ? null : new YamlConfig(ConfigSharing.Paths[5] + "shared_groups_members.txt"));
				ServerStatic.PermissionsHandler = new PermissionsHandler(ref ServerStatic.RolesConfig, ref ServerStatic.SharedGroupsConfig, ref ServerStatic.SharedGroupsMembersConfig);
			}
			catch (Exception arg)
			{
				response = $"Failed to reload the configuration file. Error: {arg}";
				return false;
			}
			response = "Configuration file successfully reloaded. Some of the changes will be applied in the next round.";
			return true;
		}
	}
}
