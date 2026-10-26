using System;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement.Group
{
	[CommandHandler(typeof(GroupCommand))]
	public class EnableCoverCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "enablecover";

		public string[] Aliases { get; }

		public string Description { get; } = "Enables badge cover for a group.";

		public string[] Usage { get; } = new string[1] { "Group Name" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			string text = arguments.At(0);
			if (ServerStatic.PermissionsHandler.GetGroup(text) == null)
			{
				response = "Group can't be found.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled cover for group " + text + ".", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			ServerStatic.RolesConfig.SetString(text + "_cover", "true");
			ServerStatic.PermissionsHandler = new PermissionsHandler(ref ServerStatic.RolesConfig, ref ServerStatic.SharedGroupsConfig, ref ServerStatic.SharedGroupsMembersConfig);
			response = "Enabled cover for group " + text + ".";
			return true;
		}
	}
}
