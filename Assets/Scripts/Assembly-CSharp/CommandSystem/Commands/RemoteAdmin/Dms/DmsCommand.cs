using System;

namespace CommandSystem.Commands.RemoteAdmin.Dms
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DmsCommand : ParentCommand, IUsageProvider
	{
		public override string Command => "deadmanswitch";

		public override string[] Aliases => new string[1] { "dms" };

		public override string Description => "Manages the Deadman's Switch.";

		public string[] Usage { get; } = new string[1] { "force/toggle/get/set" };

		public static DmsCommand Create()
		{
			DmsCommand dmsCommand = new DmsCommand();
			dmsCommand.LoadGeneratedCommands();
			return dmsCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Please specify a valid subcommand!";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new ForceCommand());
			RegisterCommand(new GetCommand());
			RegisterCommand(new SetCommand());
			RegisterCommand(new ToggleCommand());
		}
	}
}
