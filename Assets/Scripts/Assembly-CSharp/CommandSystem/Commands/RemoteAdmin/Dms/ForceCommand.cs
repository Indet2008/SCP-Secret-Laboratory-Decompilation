using System;

namespace CommandSystem.Commands.RemoteAdmin.Dms
{
	[CommandHandler(typeof(DmsCommand))]
	public class ForceCommand : ICommand
	{
		public string Command => "force";

		public string[] Aliases => new string[1] { "f" };

		public string Description => "Forces the Deadman's Switch to begin.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			if (DeadmanSwitch.IsSequenceActive)
			{
				response = "DMS is already in progress.";
				return false;
			}
			DeadmanSwitch.InitiateProtocol();
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " forced the DMS sequence.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "DMS sequence has been forced.";
			return true;
		}
	}
}
