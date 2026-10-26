using System;
using PlayerRoles.Voice;

namespace CommandSystem.Commands.RemoteAdmin.MutingAndIntercom
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class IntercomTextCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "intercomtext";

		public string[] Aliases { get; } = new string[1] { "icomtxt" };

		public string Description { get; } = "Changes the intercom text.";

		public string[] Usage { get; } = new string[1] { "text" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Broadcasting, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				if (!IntercomDisplay.TrySetDisplay(null))
				{
					response = "Intercom text reset failed. Display not found.";
					return false;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " cleared the intercom text.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				response = "Reset intercom text.";
				return true;
			}
			string text = string.Join(" ", arguments).Trim();
			if (!IntercomDisplay.TrySetDisplay(text))
			{
				response = "Intercom text override failed. Display not found.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " set the intercom text to \"" + text + "\".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Set intercom text to: " + text;
			return true;
		}
	}
}
