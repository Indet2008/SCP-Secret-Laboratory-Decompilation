using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class WaveCommand : ParentCommand, IUsageProvider
	{
		public override string Command { get; } = "wave";

		public override string[] Aliases { get; } = new string[1] { "wv" };

		public override string Description { get; } = "Controls or displays information about the Wave system.";

		public string[] Usage { get; } = new string[3] { "set/get/list/spawn", "<wave>", "[type] [value]" };

		public static WaveCommand Create()
		{
			WaveCommand waveCommand = new WaveCommand();
			waveCommand.LoadGeneratedCommands();
			return waveCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Unknown subcommand.\nUsage: " + Command + " " + this.DisplayCommandUsage() + ".";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new WaveDebugCommand());
			RegisterCommand(new WaveForcePauseCommand());
			RegisterCommand(new WaveListCommand());
			RegisterCommand(new WaveSetCommand());
			RegisterCommand(new WaveSpawnCommand());
		}
	}
}
