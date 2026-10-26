using System;

namespace CommandSystem.Commands.RemoteAdmin.ServerEvent
{
	[CommandHandler(typeof(ServerEventCommand))]
	public class DetonationStartCommand : ICommand
	{
		public string Command { get; } = "DETONATION_START";

		public string[] Aliases { get; }

		public string Description { get; } = "Force the alpha warhead detonation to start.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			AlphaWarheadController.Singleton.InstantPrepare();
			bool isLocked = AlphaWarheadController.Singleton.IsLocked;
			AlphaWarheadController.Singleton.IsLocked = false;
			AlphaWarheadController.Singleton.StartDetonation();
			AlphaWarheadController.Singleton.IsLocked = isLocked;
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " started warhead detonation.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Warhead detonation started.";
			return true;
		}
	}
}
