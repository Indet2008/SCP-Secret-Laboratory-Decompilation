using System;

namespace CommandSystem.Commands.Dot.Overwatch
{
	[CommandHandler(typeof(OverwatchCommand))]
	public class DisableCommand : ICommand
	{
		public string Command { get; } = "disable";

		public string[] Aliases { get; } = new string[3] { "off", "false", "0" };

		public string Description { get; } = "Disables overwatch.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			return OverwatchCommand.SetOverwatchStatus(sender, 0, out response);
		}
	}
}
