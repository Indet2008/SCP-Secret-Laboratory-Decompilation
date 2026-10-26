using System;
using Query;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class DisconnectCommand : ICommand
	{
		public string Command { get; } = "disconnect";

		public string[] Aliases { get; } = new string[1] { "dc" };

		public string Description { get; } = "Disconnect from server.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (sender is QueryCommandSender queryCommandSender)
			{
				queryCommandSender.Disconnect();
				response = "";
				return true;
			}
			response = "This command can be only executed on a game client or server query client!";
			return false;
		}
	}
}
