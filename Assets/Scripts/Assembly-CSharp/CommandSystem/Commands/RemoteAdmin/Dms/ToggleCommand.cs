using System;

namespace CommandSystem.Commands.RemoteAdmin.Dms
{
	[CommandHandler(typeof(DmsCommand))]
	public class ToggleCommand : ICommand
	{
		public string Command => "toggle";

		public string[] Aliases => new string[1] { "t" };

		public string Description => "Toggles whether the Deadman's Switch is enabled and can tick down.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			DeadmanSwitch.ForceCountdownToggle = !DeadmanSwitch.ForceCountdownToggle;
			bool forceCountdownToggle = DeadmanSwitch.ForceCountdownToggle;
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " toggled " + (forceCountdownToggle ? "on" : "off") + " the DMS sequence countdown.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "DMS sequence countdown has been toggled " + (forceCountdownToggle ? "on" : "off") + ".";
			return true;
		}
	}
}
