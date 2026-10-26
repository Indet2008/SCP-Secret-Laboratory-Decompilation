using System;
using GameCore;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class ContactCommand : ICommand
	{
		public string Command { get; } = "contact";

		public string[] Aliases { get; }

		public string Description { get; } = "Return the contact email address of the server.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (sender is PlayerCommandSender playerCommandSender && !playerCommandSender.ReferenceHub.serverRoles.RemoteAdmin && !playerCommandSender.ReferenceHub.authManager.BypassBansFlagSet && !playerCommandSender.ReferenceHub.isLocalPlayer)
			{
				response = "You don't have permissions to execute this command.";
				return false;
			}
			response = "Contact email address: " + ConfigFile.ServerConfig.GetString("contact_email");
			return true;
		}
	}
}
