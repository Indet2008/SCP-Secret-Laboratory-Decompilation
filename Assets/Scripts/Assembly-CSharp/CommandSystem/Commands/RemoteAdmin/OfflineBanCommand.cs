using System;
using System.Linq;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class OfflineBanCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "offlineban";

		public string[] Aliases { get; } = new string[1] { "oban" };

		public string Description { get; } = "Offline bans a specified Authid/IP Address.";

		public string[] Usage { get; } = new string[3] { "AuthId/IP Address", "Duration", "Reason" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count < 3)
			{
				response = "To execute this command provide at least 3 arguments!\nUsage: oban " + this.DisplayCommandUsage();
				return false;
			}
			string text = string.Empty;
			if (arguments.Count > 2)
			{
				text = arguments.Skip(2).Aggregate((string current, string n) => current + " " + n);
			}
			long num = 0L;
			try
			{
				num = Misc.RelativeTimeToSeconds(arguments.At(1), 60);
			}
			catch
			{
				response = "Invalid time: " + arguments.At(1);
				return false;
			}
			if (num < 0)
			{
				num = 0L;
				arguments.At(1).Replace(arguments.At(1), "0");
			}
			if (num == 0L && !sender.CheckPermission(new PlayerPermissions[3]
			{
				PlayerPermissions.KickingAndShortTermBanning,
				PlayerPermissions.BanningUpToDay,
				PlayerPermissions.LongTermBanning
			}, out response))
			{
				return false;
			}
			if (num > 0 && num <= 3600 && !sender.CheckPermission(PlayerPermissions.KickingAndShortTermBanning, out response))
			{
				return false;
			}
			if (num > 3600 && num <= 86400 && !sender.CheckPermission(PlayerPermissions.BanningUpToDay, out response))
			{
				return false;
			}
			if (num > 86400 && !sender.CheckPermission(PlayerPermissions.LongTermBanning, out response))
			{
				return false;
			}
			bool flag = Misc.ValidateIpOrHostname(arguments.At(0), out var _, allowHostname: false, allowLocalhost: false);
			if (!flag && !arguments.At(0).Contains("@"))
			{
				response = "Target must be a valid UserID or IP (v4 or v6) address.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " banned an offline player with " + (flag ? "IP address" : "UserID") + " " + arguments.At(0) + ". Ban duration: " + arguments.At(1) + ". Reason: " + ((text == string.Empty) ? "(none)" : text) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			BanHandler.IssueBan(new BanDetails
			{
				OriginalName = "Unknown - offline ban",
				Id = arguments.At(0),
				IssuanceTime = TimeBehaviour.CurrentTimestamp(),
				Expires = TimeBehaviour.GetBanExpirationTime((uint)num),
				Reason = text,
				Issuer = sender.LogName
			}, flag ? BanHandler.BanType.IP : BanHandler.BanType.UserId);
			response = (flag ? "IP address " : "UserID ") + arguments.At(0) + " has been banned from this server.";
			return true;
		}
	}
}
