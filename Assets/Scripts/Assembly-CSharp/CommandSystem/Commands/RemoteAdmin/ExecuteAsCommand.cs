using System;
using System.Collections.Generic;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ExecuteAsCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "executeas";

		public string[] Aliases { get; } = new string[1] { "runas" };

		public string Description { get; } = "Runs a command as another player.";

		public string[] Usage { get; } = new string[2] { "%player%", "Command" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ExecuteAs, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "You must specify the players and the command to run!\nUsage: " + Command + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId or name array processing.";
				return false;
			}
			string text = string.Join(' ', newargs);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null) && item.queryProcessor.TryGetSender(out var sender2))
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " executed the command " + text + " as " + sender2.LogName, ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
					ulong permissions = item.serverRoles.Permissions;
					ulong num2 = ((sender is PlayerCommandSender playerCommandSender) ? playerCommandSender.Permissions : ServerStatic.PermissionsHandler.FullPerm);
					item.serverRoles.Permissions &= num2;
					try
					{
						CommandProcessor.ProcessQuery(text, sender2);
					}
					catch (Exception ex)
					{
						response = "An error occurred while executing the command: " + ex.Message;
						return false;
					}
					item.serverRoles.Permissions = permissions;
					num++;
				}
			}
			response = string.Format("Done! The request affected {0} player{1}!", num, (num == 1) ? "" : "s");
			return true;
		}
	}
}
