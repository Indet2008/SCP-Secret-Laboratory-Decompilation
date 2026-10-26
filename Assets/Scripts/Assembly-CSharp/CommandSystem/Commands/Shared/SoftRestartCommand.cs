using System;
using Mirror;
using RoundRestarting;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class SoftRestartCommand : ICommand
	{
		public string Command { get; } = "softrestart";

		public string[] Aliases { get; } = new string[2] { "srestart", "sr" };

		public string Description { get; } = "Restarts the server, but tells all the players to reconnect after the restart.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!NetworkServer.active)
			{
				response = "This command can only be used on a server.";
				return false;
			}
			if (sender is CommandSender sender2 && !sender2.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (!ServerStatic.IsDedicated)
			{
				response = "This command can be only executed on a dedicated servers.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " performed a soft server restart.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			ServerStatic.StopNextRound = ServerStatic.NextRoundAction.Restart;
			RoundRestart.ChangeLevel(noShutdownMessage: true);
			response = "Server will softly restart in a couple of seconds.";
			return true;
		}
	}
}
