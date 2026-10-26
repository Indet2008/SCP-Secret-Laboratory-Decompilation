using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class UnbanCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "unban";

		public string[] Aliases { get; } = new string[1] { "pardon" };

		public string Description { get; } = "Unbans the specified AuthID or IP Address.";

		public string[] Usage { get; } = new string[2] { "id/ip", "AuthID/IP Address" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.LongTermBanning, out response))
			{
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			switch (arguments.At(0))
			{
			case "id":
			case "playerid":
			case "player":
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " unbanned player with id " + arguments.At(1) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				BanHandler.RemoveBan(arguments.At(1), BanHandler.BanType.UserId);
				response = "Done!";
				return true;
			case "ip":
			case "address":
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " unbanned IP address " + arguments.At(1) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				BanHandler.RemoveBan(arguments.At(1), BanHandler.BanType.IP);
				response = "Done!";
				return true;
			default:
				response = $"Incorrect syntax! Usage: unban{Usage}";
				return false;
			}
		}
	}
}
