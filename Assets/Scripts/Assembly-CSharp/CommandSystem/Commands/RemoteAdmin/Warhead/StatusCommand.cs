using System;
using Mirror;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class StatusCommand : ICommand
	{
		public string Command { get; } = "status";

		public string[] Aliases { get; } = new string[1] { "s" };

		public string Description { get; } = "Returns the status of the alpha warhead.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			if (AlphaWarheadController.Detonated)
			{
				response = "Warhead has been detonated.";
			}
			else if (AlphaWarheadController.InProgress)
			{
				response = "Detonation is in progress.";
			}
			else if (!AlphaWarheadOutsitePanel.nukeside.enabled)
			{
				response = "Warhead is disabled.";
			}
			else if (AlphaWarheadController.Singleton.CooldownEndTime > NetworkTime.time)
			{
				response = "Warhead is restarting.";
			}
			else
			{
				response = "Warhead is ready to detonation.";
			}
			return true;
		}
	}
}
