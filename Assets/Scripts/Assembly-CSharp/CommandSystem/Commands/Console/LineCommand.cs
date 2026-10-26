using System;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class LineCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "line";

		public override string[] Aliases { get; } = new string[4] { "debugline", "drawline", "drawableline", "lines" };

		public override string Description { get; } = "Controls or displays information about the Wave system.";

		public string[] Usage { get; } = new string[2] { "help/toggle/test/duration", "[value]" };

		public static LineCommand Create()
		{
			LineCommand lineCommand = new LineCommand();
			lineCommand.LoadGeneratedCommands();
			return lineCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Unknown subcommand.\nUsage: " + Command + " " + this.DisplayCommandUsage() + ".";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new LineDurationCommand());
			RegisterCommand(new LineHelpCommand());
			RegisterCommand(new LineTestCommand());
			RegisterCommand(new LineToggleCommand());
		}
	}
}
