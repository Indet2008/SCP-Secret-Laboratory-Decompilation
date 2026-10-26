using System;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class HideTagCommand : ICommand
	{
		public string Command { get; } = "hidetag";

		public string[] Aliases { get; } = new string[2] { "htag", "ht" };

		public string Description { get; } = "Hides your tag.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			ServerRoles serverRoles = playerCommandSender.ReferenceHub.serverRoles;
			if (serverRoles.HasBadgeHidden)
			{
				response = "Your badge is already hidden.";
				return false;
			}
			if (!serverRoles.TryHideTag())
			{
				response = "Your don't have any badge.";
				return false;
			}
			response = "Tag hidden.";
			return true;
		}
	}
}
