using System;
using RoundRestarting;

namespace CommandSystem.Commands.RemoteAdmin.ServerEvent
{
	[CommandHandler(typeof(ServerEventCommand))]
	public class RoundRestartCommand : ICommand
	{
		public string Command { get; } = "ROUND_RESTART";

		public string[] Aliases { get; } = new string[3] { "RR", "RESTART", "ROUNDRESTART" };

		public string Description { get; } = "Restarts the current round.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " forced round restart.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			RoundRestart.InitiateRoundRestart();
			response = "Round restart forced.";
			return true;
		}
	}
}
