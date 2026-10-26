using System;
using Mirror;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class NextRoundCommand : ICommand
	{
		public string Command { get; } = "nextround";

		public string[] Aliases { get; } = new string[1] { "nr" };

		public string Description { get; } = "Manages server behavior when the current round ends.";

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
			bool flag = ServerStatic.ShutdownRedirectPort != 0;
			response = ServerStatic.StopNextRound switch
			{
				ServerStatic.NextRoundAction.Restart => "Server will RESTART.", 
				ServerStatic.NextRoundAction.Shutdown => (!flag) ? "Server will SHUTDOWN." : $"Server will SHUTDOWN and all players will be redirected to port {ServerStatic.ShutdownRedirectPort}.", 
				_ => "Round will normally restart.", 
			};
			return true;
		}
	}
}
