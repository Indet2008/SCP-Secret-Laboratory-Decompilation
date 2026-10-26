using System;
using System.Collections.Generic;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class GotoCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "goto";

		public string[] Aliases { get; }

		public string Description { get; } = "Teleports you to the specified player.";

		public string[] Usage { get; } = new string[1] { "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!playerCommandSender.ReferenceHub.IsAlive())
			{
				response = "Command disabled when you are not alive!";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null || list.Count != 1)
			{
				response = "This commands you to specify exactly one specific player!";
				return false;
			}
			if (playerCommandSender.ReferenceHub.TryOverridePosition(list[0].transform.position))
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " teleported themself to player " + list[0].LoggedNameFromRefHub() + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				response = "Done!";
				return true;
			}
			response = "Your current role does not support this operation.";
			return false;
		}
	}
}
