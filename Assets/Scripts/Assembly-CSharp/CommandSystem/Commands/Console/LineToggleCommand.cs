using System;
using DrawableLine;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(LineCommand))]
	public class LineToggleCommand : ICommand
	{
		public string Command { get; } = "toggle";

		public string[] Aliases { get; } = new string[1] { "tg" };

		public string Description { get; } = "Toggles whether the line system can generate new instances.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			bool num = !DrawableLines.IsDebugModeEnabled;
			string text = (num ? "<color=green>enabled</color>" : "<color=red>disabled</color>");
			DrawableLines.IsDebugModeEnabled = num;
			response = "<color=white>The drawable line system is now <b>" + text + "</b>.</color>";
			return true;
		}
	}
}
