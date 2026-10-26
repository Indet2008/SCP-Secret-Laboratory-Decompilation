using System;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement.Group
{
	[CommandHandler(typeof(PermissionsManagementCommand))]
	public class GroupCommand : ParentCommand
	{
		public override string Command { get; } = "group";

		public override string[] Aliases { get; } = new string[1] { "gr" };

		public override string Description { get; } = "Group management";

		public static GroupCommand Create()
		{
			GroupCommand groupCommand = new GroupCommand();
			groupCommand.LoadGeneratedCommands();
			return groupCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Invalid subcommand. Available commands: info, grant, setcolor, settag, enablecover.";
			return true;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new DisableCoverCommand());
			RegisterCommand(new EnableCoverCommand());
			RegisterCommand(new GrantCommand());
			RegisterCommand(new InfoCommand());
			RegisterCommand(new RevokeCommand());
			RegisterCommand(new SetColorCommand());
			RegisterCommand(new SetTagCommand());
		}
	}
}
