using System;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class IdCommand : ICommand
	{
		public string Command { get; } = "id";

		public string[] Aliases { get; } = new string[1] { "myid" };

		public string Description { get; } = "Displays your current player ID.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			ReferenceHub localHub = ReferenceHub.LocalHub;
			if (localHub == null)
			{
				response = "You must join a server to execute this command.";
				return false;
			}
			response = $"Your Player ID on the current server: {localHub.PlayerId}";
			return true;
		}
	}
}
