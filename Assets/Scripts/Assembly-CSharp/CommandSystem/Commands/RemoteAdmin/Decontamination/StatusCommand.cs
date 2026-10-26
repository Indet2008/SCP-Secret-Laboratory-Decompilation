using System;
using LightContainmentZoneDecontamination;

namespace CommandSystem.Commands.RemoteAdmin.Decontamination
{
	[CommandHandler(typeof(DecontaminationCommand))]
	public class StatusCommand : ICommand
	{
		public string Command { get; } = "status";

		public string[] Aliases { get; } = new string[3] { "s", "c", "check" };

		public string Description { get; } = "Returns status of the LCZ decontamination.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			response = "Decontamination is " + ((DecontaminationController.Singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Disabled) ? "DISABLED" : "ENABLED") + ".";
			return true;
		}
	}
}
