using System;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement.Group
{
	[CommandHandler(typeof(GroupCommand))]
	public class SetTagCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "settag";

		public string[] Aliases { get; } = new string[1] { "setag" };

		public string Description { get; } = "Sets the badge text for a group.";

		public string[] Usage { get; } = new string[2] { "Group Name", "Tag" };

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
			string text = arguments.At(0);
			string value = arguments.At(1);
			if (ServerStatic.PermissionsHandler.GetGroup(text) == null)
			{
				response = "Group can't be found.";
				return false;
			}
			ServerStatic.RolesConfig.SetString(text + "_badge", value);
			ServerStatic.PermissionsHandler = new PermissionsHandler(ref ServerStatic.RolesConfig, ref ServerStatic.SharedGroupsConfig, ref ServerStatic.SharedGroupsMembersConfig);
			response = "Group tag updated.";
			return true;
		}
	}
}
