using System;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class DisableCommand : ICommand
	{
		public string Command { get; } = "disable";

		public string[] Aliases { get; } = new string[1] { "d" };

		public string Description { get; } = "Disables the alpha warhead.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disabled the warhead.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			AlphaWarheadOutsitePanel.nukeside.Networkenabled = false;
			response = "Warhead has been disabled.";
			return true;
		}
	}
}
