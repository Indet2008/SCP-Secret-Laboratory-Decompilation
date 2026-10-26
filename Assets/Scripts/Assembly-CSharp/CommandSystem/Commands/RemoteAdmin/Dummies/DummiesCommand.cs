using System;

namespace CommandSystem.Commands.RemoteAdmin.Dummies
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DummiesCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "dummies";

		public override string[] Aliases { get; } = new string[1] { "dummy" };

		public override string Description { get; } = "Controls dummies in the facility.";

		public string[] Usage { get; } = new string[1] { "spawn/destroy/follow" };

		public static DummiesCommand Create()
		{
			DummiesCommand dummiesCommand = new DummiesCommand();
			dummiesCommand.LoadGeneratedCommands();
			return dummiesCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Please specify a valid subcommand (" + Usage[0] + ").";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new ActionDummyCommand());
			RegisterCommand(new DestroyDummyCommand());
			RegisterCommand(new FollowDummyCommand());
			RegisterCommand(new SpawnDummyCommand());
		}
	}
}
