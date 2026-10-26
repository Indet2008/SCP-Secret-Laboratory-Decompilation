using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class HelloCommand : ICommand
	{
		public string Command { get; } = "hello";

		public string[] Aliases { get; }

		public string Description { get; } = "Hi!";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Hello World!";
			return true;
		}
	}
}
