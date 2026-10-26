using System;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class GlobalTagCommand : ICommand
	{
		public string Command { get; } = "globaltag";

		public string[] Aliases { get; } = new string[3] { "gtag", "gtg", "gt" };

		public string Description { get; } = "Shows your global tag.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.serverRoles.RefreshGlobalTag())
			{
				response = "You don't have a global tag.";
				return false;
			}
			response = "Global tag refreshed.";
			return true;
		}
	}
}
