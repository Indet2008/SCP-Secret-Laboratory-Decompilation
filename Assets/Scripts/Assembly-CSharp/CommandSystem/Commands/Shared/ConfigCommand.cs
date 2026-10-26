using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class ConfigCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "config";

		public override string[] Aliases { get; } = new string[1] { "cfg" };

		public override string Description { get; } = "Allows for config debugging and reloading";

		public string[] Usage { get; } = new string[1] { "Reload/Path/Value/Open" };

		public static ConfigCommand Create()
		{
			ConfigCommand configCommand = new ConfigCommand();
			configCommand.LoadGeneratedCommands();
			return configCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Please specify a valid subcommand! The valid commands are: Reload/Path/Value/Open.";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new OpenCommand());
			RegisterCommand(new PathCommand());
			RegisterCommand(new ReloadCommand());
			RegisterCommand(new ValueCommand());
		}
	}
}
