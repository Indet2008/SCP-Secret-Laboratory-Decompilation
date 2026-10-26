using System;
using LightContainmentZoneDecontamination;

namespace CommandSystem.Commands.RemoteAdmin.Decontamination
{
	[CommandHandler(typeof(DecontaminationCommand))]
	public class EnableCommand : ICommand
	{
		public string Command { get; } = "enable";

		public string[] Aliases { get; } = new string[3] { "e", "1", "on" };

		public string Description { get; } = "Enables the LCZ decontamination.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (DecontaminationController.Singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.None)
			{
				response = "Decontamination is already enabled.";
				return true;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled the LCZ decontamination.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			DecontaminationController.Singleton.DecontaminationOverride = DecontaminationController.DecontaminationStatus.None;
			response = "Decontamination has been enabled.";
			return true;
		}
	}
}
