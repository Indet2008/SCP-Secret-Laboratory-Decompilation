using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class OverwatchCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "overwatch";

		public string[] Aliases { get; } = new string[1] { "ovr" };

		public string Description { get; } = "Changes the status of overwatch mode for the specified player(s).";

		public string[] Usage { get; } = new string[2] { "%player%", "enable/disable (Leave blank for toggle)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Overwatch, out response))
			{
				return false;
			}
			string[] newargs = new string[0];
			List<ReferenceHub> list;
			if (sender is PlayerCommandSender playerCommandSender && (arguments.Count == 0 || (arguments.Count == 1 && !arguments.At(0).Contains(".") && !arguments.At(0).Contains("@"))))
			{
				list = new List<ReferenceHub>();
				list.Add(playerCommandSender.ReferenceHub);
				if (arguments.Count > 1)
				{
					newargs[0] = arguments.At(1);
				}
				else
				{
					newargs = null;
				}
			}
			else
			{
				list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out newargs);
			}
			if (!Misc.TryCommandModeFromArgs(ref newargs, out var mode))
			{
				response = "Invalid option " + newargs[0] + " - leave null for toggle or use 1/0, true/false, enable/disable or on/off.";
				return false;
			}
			StringBuilder stringBuilder = ((mode == Misc.CommandOperationMode.Toggle) ? null : StringBuilderPool.Shared.Rent());
			PlayerCommandSender playerCommandSender2 = (PlayerCommandSender)sender;
			bool flag = playerCommandSender2.ReferenceHub.authManager.NorthwoodStaff || playerCommandSender2.CheckPermission(PlayerPermissions.PermissionsManagement);
			int num = 0;
			if (list != null)
			{
				foreach (ReferenceHub item in list)
				{
					ServerRoles serverRoles = item.serverRoles;
					if (item.authManager.BypassBansFlagSet && !flag)
					{
						continue;
					}
					switch (mode)
					{
					case Misc.CommandOperationMode.Enable:
						if (serverRoles.IsInOverwatch)
						{
							continue;
						}
						SetOverwatchStatus(serverRoles, 1);
						if (num != 0)
						{
							stringBuilder.Append(", ");
						}
						stringBuilder.Append(item.LoggedNameFromRefHub());
						break;
					case Misc.CommandOperationMode.Disable:
						if (!serverRoles.IsInOverwatch)
						{
							continue;
						}
						SetOverwatchStatus(serverRoles, 0);
						if (num != 0)
						{
							stringBuilder.Append(", ");
						}
						stringBuilder.Append(item.LoggedNameFromRefHub());
						break;
					case Misc.CommandOperationMode.Toggle:
						SetOverwatchStatus(serverRoles, 2);
						if (serverRoles.IsInOverwatch)
						{
							ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled overwatch mode for player " + item.LoggedNameFromRefHub() + " using overwatch mode toggle command.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
						}
						else
						{
							ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disabled overwatch mode for player " + item.LoggedNameFromRefHub() + " using overwatch mode toggle command.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
						}
						break;
					}
					num++;
				}
			}
			if (num > 0)
			{
				switch (mode)
				{
				case Misc.CommandOperationMode.Enable:
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} enabled overwatch mode for player{1}{2}.", sender.LogName, (num == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					StringBuilderPool.Shared.Return(stringBuilder);
					break;
				case Misc.CommandOperationMode.Disable:
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} disabled overwatch mode for player{1}{2}.", sender.LogName, (num == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					StringBuilderPool.Shared.Return(stringBuilder);
					break;
				}
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}

		private static void SetOverwatchStatus(ServerRoles sr, byte status)
		{
			sr.IsInOverwatch = status switch
			{
				0 => false, 
				1 => true, 
				2 => !sr.IsInOverwatch, 
				_ => sr.IsInOverwatch, 
			};
		}
	}
}
