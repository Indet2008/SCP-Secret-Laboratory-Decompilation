using System;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class DetonateCommand : ICommand
	{
		public string Command { get; } = "detonate";

		public string[] Aliases { get; } = new string[2] { "det", "start" };

		public string Description { get; } = "Starts the alpha warhead detonation sequence.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " started warhead detonation.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			AlphaWarheadController.Singleton.StartDetonation();
			response = "Detonation sequence started.";
			return true;
		}
	}
}
