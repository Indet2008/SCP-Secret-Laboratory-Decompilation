using System;
using PlayerRoles.Voice;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class IntercomTimeoutCommand : ICommand
	{
		public string Command { get; } = "intercom-timeout";

		public string[] Aliases { get; } = new string[3] { "icomstop", "icomtimeout", "it" };

		public string Description { get; } = "Times out the intercom system if it's currently in use.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(new PlayerPermissions[6]
			{
				PlayerPermissions.KickingAndShortTermBanning,
				PlayerPermissions.BanningUpToDay,
				PlayerPermissions.LongTermBanning,
				PlayerPermissions.RoundEvents,
				PlayerPermissions.FacilityManagement,
				PlayerPermissions.PlayersManagement
			}, out response))
			{
				return false;
			}
			Intercom.State = IntercomState.Cooldown;
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " timed out the intercom speaker.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			response = "Done! Intercom speaker timed out.";
			return true;
		}
	}
}
