using System;
using System.Collections.Generic;
using MEC;
using RoundRestarting;
using ServerOutput;
using Utils.Networking;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class RedirectCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "redirect";

		public string[] Aliases { get; } = new string[3] { "rstop", "rexit", "rquit" };

		public string Description { get; } = "Shutdowns the server and redirects all the players to a server on another port.";

		public string[] Usage { get; } = new string[1] { "port number" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (arguments.Count != 1 || !ushort.TryParse(arguments.At(0), out var result))
			{
				response = "First argument must be a valid port number.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} redirected all players to port {result}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			CustomLiteNetLib4MirrorTransport.DelayConnections = true;
			IdleMode.SetIdleMode(state: false);
			IdleMode.PauseIdleMode = true;
			ServerConsole.AddOutputEntry(default(ExitActionShutdownEntry));
			new RoundRestartMessage(RoundRestartType.RedirectRestart, 0.1f, result, reconnect: true, extendedReconnectionPeriod: false).SendToAuthenticated();
			Timing.RunCoroutine(ScheduleShutdown(), Segment.FixedUpdate);
			response = $"Players have been redirected to port {result}. Server will shutdown in a couple of seconds.";
			return true;
		}

		private IEnumerator<float> ScheduleShutdown()
		{
			yield return Timing.WaitForSeconds(5f);
			Shutdown.Quit();
		}
	}
}
