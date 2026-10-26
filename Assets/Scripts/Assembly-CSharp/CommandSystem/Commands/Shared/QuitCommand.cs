using System;
using Mirror;
using Query;
using RemoteAdmin;
using ServerOutput;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class QuitCommand : ICommand
	{
		public string Command { get; } = "quit";

		public string[] Aliases { get; } = new string[2] { "exit", "stop" };

		public string Description { get; } = "Quit the game.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if ((sender is QueryCommandSender || sender is PlayerCommandSender) && (arguments.Count == 0 || !arguments.At(0).Equals("-y", StringComparison.OrdinalIgnoreCase)))
			{
				response = "[WARNING] This command stops the entire server. It doesn't disconnect you from the server.\nTo confirm server shutdown add \"-y\" argument.";
				if (sender is QueryCommandSender)
				{
					response += "\nTo disconnect from query use \"disconnect\" command.";
				}
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (NetworkServer.active)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " stopped the server.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			IdleMode.SetIdleMode(state: false);
			ServerConsole.AddOutputEntry(default(ExitActionShutdownEntry));
			Shutdown.Quit();
			response = "<size=50>GOODBYE!</size>";
			return true;
		}
	}
}
