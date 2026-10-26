using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class NoopCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "noop";

		public string[] Aliases { get; }

		public string Description { get; } = "Technical command that doesn't do anything (noop = no operation).";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = null;
			return true;
		}
	}
}
