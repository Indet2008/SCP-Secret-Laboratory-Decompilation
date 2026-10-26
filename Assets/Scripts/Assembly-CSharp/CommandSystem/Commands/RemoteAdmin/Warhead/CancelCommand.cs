using System;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class CancelCommand : ICommand
	{
		public string Command { get; } = "cancel";

		public string[] Aliases { get; } = new string[2] { "stop", "c" };

		public string Description { get; } = "Stops the alpha warhead detonation sequence.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " cancelled warhead detonation.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			AlphaWarheadController.Singleton.CancelDetonation(null);
			response = "Detonation has been canceled.";
			return true;
		}
	}
}
