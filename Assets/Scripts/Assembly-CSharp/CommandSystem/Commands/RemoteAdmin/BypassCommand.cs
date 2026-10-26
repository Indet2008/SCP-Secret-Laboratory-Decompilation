using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class BypassCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "bypass";

		public string[] Aliases { get; } = new string[1] { "bm" };

		public string Description { get; } = "Changes the status of bypass mode for the specified player(s).";

		public string[] Usage { get; } = new string[2] { "%player%", "enable/disable (Leave blank for toggle)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
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
			int num = 0;
			if (list != null)
			{
				foreach (ReferenceHub item in list)
				{
					ServerRoles serverRoles = item.serverRoles;
					switch (mode)
					{
					case Misc.CommandOperationMode.Enable:
						if (serverRoles.BypassMode)
						{
							continue;
						}
						serverRoles.BypassMode = true;
						if (num != 0)
						{
							stringBuilder.Append(", ");
						}
						stringBuilder.Append(item.LoggedNameFromRefHub());
						break;
					case Misc.CommandOperationMode.Disable:
						if (!serverRoles.BypassMode)
						{
							continue;
						}
						serverRoles.BypassMode = false;
						if (num != 0)
						{
							stringBuilder.Append(", ");
						}
						stringBuilder.Append(item.LoggedNameFromRefHub());
						break;
					case Misc.CommandOperationMode.Toggle:
						serverRoles.BypassMode = !serverRoles.BypassMode;
						if (serverRoles.BypassMode)
						{
							ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled bypass mode for player " + item.LoggedNameFromRefHub() + " using bypass mode toggle command.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
						}
						else
						{
							ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disabled bypass mode for player " + item.LoggedNameFromRefHub() + " using bypass mode toggle command.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
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
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} enabled bypass mode for player{1}{2}.", sender.LogName, (num == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					StringBuilderPool.Shared.Return(stringBuilder);
					break;
				case Misc.CommandOperationMode.Disable:
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} disabled bypass mode for player{1}{2}.", sender.LogName, (num == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					StringBuilderPool.Shared.Return(stringBuilder);
					break;
				}
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
