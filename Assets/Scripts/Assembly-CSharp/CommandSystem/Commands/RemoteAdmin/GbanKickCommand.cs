using System;
using System.Collections.Generic;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class GbanKickCommand : ICommand, IHiddenCommand
	{
		public string Command { get; } = "gban-kick";

		public string[] Aliases { get; }

		public string Description { get; } = "Internal global banning use only.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "This command can only be executed by players in-game.";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.authManager.RemoteAdminGlobalAccess)
			{
				response = "You do not have permission to run this command. Did you mean \"ban\"?";
				return false;
			}
			if (arguments.Count != 2)
			{
				response = "To run this program, type exactly 2 argument!.";
				return false;
			}
			List<int> list = Misc.ProcessRaPlayersList(arguments.At(0));
			if (list != null && list.Count == 1)
			{
				if (ReferenceHub.TryGetHub(list[0], out var hub))
				{
					BanPlayer.GlobalBanUser(hub, playerCommandSender, arguments.At(1));
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " globally banned and kicked " + arguments.At(0) + " player.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					response = "Done! Globally banned and kicked " + arguments.At(0) + ".";
					return true;
				}
				response = "Error finding player with that ID.";
				return false;
			}
			response = "An unexpected problem has occurred during PlayerId processing. (This command only accepts one ID).";
			return false;
		}
	}
}
