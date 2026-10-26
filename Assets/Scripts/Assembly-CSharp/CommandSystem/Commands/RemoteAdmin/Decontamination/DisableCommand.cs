using System;
using LightContainmentZoneDecontamination;

namespace CommandSystem.Commands.RemoteAdmin.Decontamination
{
	[CommandHandler(typeof(DecontaminationCommand))]
	public class DisableCommand : ICommand
	{
		public string Command { get; } = "disable";

		public string[] Aliases { get; } = new string[3] { "d", "0", "off" };

		public string Description { get; } = "Disables the LCZ decontamination.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (DecontaminationController.Singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Disabled)
			{
				response = "Decontamination is already disabled.";
				return true;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disabled the LCZ decontamination.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			DecontaminationController.Singleton.DecontaminationOverride = DecontaminationController.DecontaminationStatus.Disabled;
			response = "Decontamination has been disabled.";
			return true;
		}
	}
}
