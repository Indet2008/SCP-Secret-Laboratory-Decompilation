using System;
using Mirror;
using ServerOutput;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class StopNextRoundCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "stopnextround";

		public string[] Aliases { get; } = new string[1] { "snr" };

		public string Description { get; } = "Stops the server after the next round.";

		public string[] Usage { get; } = new string[1] { "Port number to redirect players (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (sender is CommandSender sender2 && !sender2.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (!NetworkServer.active)
			{
				response = "This command can only be used on a server.";
				return false;
			}
			if (!ServerStatic.IsDedicated)
			{
				response = "This command can be only executed on a dedicated servers.";
				return false;
			}
			if (arguments.Count > 0)
			{
				if (!ushort.TryParse(arguments.At(0), out var result))
				{
					response = "First argument, if set, must be a valid port number.";
					return false;
				}
				if (result == ServerStatic.ShutdownRedirectPort)
				{
					response = $"Server is already set to redirect players to port {result}.";
					return true;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} set the server shutdown redirection port to {result}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				ServerStatic.ShutdownRedirectPort = result;
			}
			else if (ServerStatic.ShutdownRedirectPort != 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " cleared the server shutdown redirection port.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				ServerStatic.ShutdownRedirectPort = 0;
			}
			if (ServerStatic.StopNextRound == ServerStatic.NextRoundAction.Shutdown && ServerStatic.ShutdownRedirectPort == 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " canceled server stop after the round end.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				ServerStatic.StopNextRound = ServerStatic.NextRoundAction.DoNothing;
				ServerConsole.AddOutputEntry(default(ExitActionResetEntry));
				response = "Server WON'T stop after next round.";
			}
			else
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " scheduled server stop after the round end.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				ServerStatic.StopNextRound = ServerStatic.NextRoundAction.Shutdown;
				ServerConsole.AddOutputEntry(default(ExitActionShutdownEntry));
				response = "Server WILL stop after next round" + ((ServerStatic.ShutdownRedirectPort == 0) ? "" : $" and players will be redirected to port {ServerStatic.ShutdownRedirectPort}") + ".";
			}
			return true;
		}
	}
}
