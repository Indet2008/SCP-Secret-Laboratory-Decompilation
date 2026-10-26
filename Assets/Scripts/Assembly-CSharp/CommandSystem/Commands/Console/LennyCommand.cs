using System;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class LennyCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "lenny";

		public string[] Aliases { get; }

		public string Description { get; } = "( \u0361° \u035cʖ \u0361°)";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "<size=200>( \u0361° \u035cʖ \u0361°)</size>";
			return true;
		}
	}
}
