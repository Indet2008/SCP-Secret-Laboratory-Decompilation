using System;
using CommandSystem.Commands.RemoteAdmin.PermissionsManagement;
using CommandSystem.Commands.RemoteAdmin.PermissionsManagement.Group;
using CommandSystem.Commands.Shared;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class PermissionsManagementCommand : ParentCommand
	{
		public override string Command { get; } = "permissionsmanagement";

		public override string[] Aliases { get; } = new string[1] { "pm" };

		public override string Description { get; } = "Permissions management system. Type \"pm\" for help.";

		public static PermissionsManagementCommand Create()
		{
			PermissionsManagementCommand permissionsManagementCommand = new PermissionsManagementCommand();
			permissionsManagementCommand.LoadGeneratedCommands();
			return permissionsManagementCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count == 0)
			{
				response = "Permissions manager help:\nSyntax: " + arguments.Array[0] + " action\n\nAvailable actions:\ngroups - lists all groups\ngroup info <group name> - prints group info\ngroup grant <group name> <permission name> - grants permission to a group\ngroup revoke <group name> <permission name> - revokes permission from a group\ngroup setcolor <group name> <color name> - sets group color\ngroup settag <group name> <tag> - sets group tag\ngroup enablecover <group name> - enables badge cover for group\ngroup disablecover <group name> - disables badge cover for group\n\nusers - lists all privileged users\nsetgroup <UserID> <group name> - sets membership of user (use group name \"-1\" to remove user from group)\nreload - reloads permission file\n\n\"< >\" are only used to indicate the arguments, don't put them\nMore commands will be added in the next versions of the game";
				return true;
			}
			response = "Unknown subcommand. Type \"pm\" for a list of valid subcommands.";
			return true;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new GroupsCommand());
			RegisterCommand(new CommandSystem.Commands.RemoteAdmin.PermissionsManagement.ReloadCommand());
			RegisterCommand(new CommandSystem.Commands.RemoteAdmin.PermissionsManagement.SetGroupCommand());
			RegisterCommand(new UsersCommand());
			RegisterCommand(GroupCommand.Create());
		}
	}
}
