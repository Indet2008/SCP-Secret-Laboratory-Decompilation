using System;
using LightContainmentZoneDecontamination;

namespace CommandSystem.Commands.RemoteAdmin.Decontamination
{
	[CommandHandler(typeof(DecontaminationCommand))]
	public class ForceCommand : ICommand
	{
		public string Command { get; } = "force";

		public string[] Aliases { get; } = new string[1] { "f" };

		public string Description { get; } = "Forces the LCZ decontamination to begin.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (DecontaminationController.Singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Disabled)
			{
				response = "Decontamination is currently disabled.";
				return true;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " forced the LCZ decontamination to begin.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			DecontaminationController.Singleton.DecontaminationOverride = DecontaminationController.DecontaminationStatus.Forced;
			response = "Decontamination has begun.";
			return true;
		}
	}
}
