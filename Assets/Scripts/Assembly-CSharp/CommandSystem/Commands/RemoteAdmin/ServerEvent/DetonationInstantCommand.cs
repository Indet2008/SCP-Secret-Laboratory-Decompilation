using System;

namespace CommandSystem.Commands.RemoteAdmin.ServerEvent
{
	[CommandHandler(typeof(ServerEventCommand))]
	public class DetonationInstantCommand : ICommand
	{
		public string Command { get; } = "DETONATION_INSTANT";

		public string[] Aliases { get; }

		public string Description { get; } = "Instantly detonates the alpha warhead.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			AlphaWarheadController.Singleton.ForceTime(0f);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " instantly detonated the warhead.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Warhead will detonate instantly.";
			return true;
		}
	}
}
