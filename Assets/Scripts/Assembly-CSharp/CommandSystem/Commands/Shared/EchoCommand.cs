using System;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class EchoCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "echo";

		public string[] Aliases { get; }

		public string Description { get; } = "Echoes the input back to the sender.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (sender is PlayerCommandSender playerCommandSender && !playerCommandSender.ReferenceHub.serverRoles.RemoteAdmin)
			{
				response = "You don't have permissions to use this command!";
				return false;
			}
			response = "Echo response: " + string.Join(" ", arguments);
			return true;
		}
	}
}
