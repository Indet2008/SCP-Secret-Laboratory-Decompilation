using System;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement
{
	[CommandHandler(typeof(PermissionsManagementCommand))]
	public class SetGroupCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "setgroup";

		public string[] Aliases { get; }

		public string Description { get; } = "Sets a player's group. (Use \"-1\" as the group name to remove a group.)";

		public string[] Usage { get; } = new string[2] { "UserId", "Group (-1 to remove)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			string text = arguments.At(1);
			if (text == "-1")
			{
				text = null;
			}
			else if (ServerStatic.PermissionsHandler.GetGroup(text) == null)
			{
				response = "Group can't be found.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " set server group of " + arguments.At(0) + " to " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			ServerStatic.RolesConfig.SetStringDictionaryItem("Members", arguments.At(0), text);
			ServerStatic.PermissionsHandler = new PermissionsHandler(ref ServerStatic.RolesConfig, ref ServerStatic.SharedGroupsConfig, ref ServerStatic.SharedGroupsMembersConfig);
			response = "User permissions updated. If user is online, please use \"setgroup\" command to change it now (without this command, new role will be applied during next round).";
			return true;
		}
	}
}
