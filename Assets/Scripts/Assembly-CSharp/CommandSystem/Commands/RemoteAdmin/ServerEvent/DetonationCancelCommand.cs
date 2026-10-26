using System;

namespace CommandSystem.Commands.RemoteAdmin.ServerEvent
{
	[CommandHandler(typeof(ServerEventCommand))]
	public class DetonationCancelCommand : ICommand
	{
		public string Command { get; } = "DETONATION_CANCEL";

		public string[] Aliases { get; }

		public string Description { get; } = "Cancels the alpha warhead detonation sequence.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			bool isLocked = AlphaWarheadController.Singleton.IsLocked;
			AlphaWarheadController.Singleton.IsLocked = false;
			DeadmanSwitch.Reset();
			AlphaWarheadController.Singleton.CancelDetonation();
			AlphaWarheadController.Singleton.IsLocked = isLocked;
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " cancelled warhead detonation.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Warhead detonation cancelled.";
			return true;
		}
	}
}
