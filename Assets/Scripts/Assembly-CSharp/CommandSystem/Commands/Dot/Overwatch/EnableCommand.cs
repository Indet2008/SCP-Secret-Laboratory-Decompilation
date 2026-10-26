using System;

namespace CommandSystem.Commands.Dot.Overwatch
{
	[CommandHandler(typeof(OverwatchCommand))]
	public class EnableCommand : ICommand
	{
		public string Command { get; } = "enable";

		public string[] Aliases { get; } = new string[3] { "on", "true", "1" };

		public string Description { get; } = "Enables overwatch.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			return OverwatchCommand.SetOverwatchStatus(sender, 1, out response);
		}
	}
}
