using System;
using GameCore;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class LobbyLockCommand : ICommand
	{
		public string Command { get; } = "lobbylock";

		public string[] Aliases { get; } = new string[2] { "ll", "llock" };

		public string Description { get; } = "Locks or unlocks the lobby (prevents the round from starting).";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (RoundStart.RoundStarted)
			{
				response = "This command can only be ran while in the lobby.";
				return false;
			}
			RoundStart.LobbyLock = !RoundStart.LobbyLock;
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + (RoundStart.LobbyLock ? " enabled " : " disabled ") + "lobby lock.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Lobby lock " + (RoundStart.LobbyLock ? "enabled!" : "disabled!");
			return true;
		}
	}
}
