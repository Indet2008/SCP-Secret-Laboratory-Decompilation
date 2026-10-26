using System;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class EnableCommand : ICommand
	{
		public string Command { get; } = "enable";

		public string[] Aliases { get; } = new string[1] { "e" };

		public string Description { get; } = "Enables the alpha warhead.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled the warhead.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			AlphaWarheadOutsitePanel.nukeside.Networkenabled = true;
			response = "Warhead has been enabled.";
			return true;
		}
	}
}
