using System;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class HttpInfoCommand : ICommand
	{
		public string Command { get; } = "httpinfo";

		public string[] Aliases { get; } = new string[2] { "httpconfig", "httpconfiguration" };

		public string Description { get; } = "Returns information about the currently used HTTP handling";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = HttpQuery.GetInfo();
			return true;
		}
	}
}
