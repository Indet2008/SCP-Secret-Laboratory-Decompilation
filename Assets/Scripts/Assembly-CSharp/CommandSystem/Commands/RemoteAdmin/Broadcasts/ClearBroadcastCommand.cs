using System;

namespace CommandSystem.Commands.RemoteAdmin.Broadcasts
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ClearBroadcastCommand : ICommand
	{
		public string Command { get; } = "clearbroadcasts";

		public string[] Aliases { get; } = new string[5] { "cl", "clearbc", "bcclear", "clearalert", "alertclear" };

		public string Description { get; } = "Clears all active administrative broadcasts.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Broadcasting, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " cleared all broadcasts.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			Broadcast.Singleton.RpcClearElements();
			response = "All broadcasts cleared.";
			return true;
		}
	}
}
