using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles.Voice;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class IntercomSpeakCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "icom";

		public string[] Aliases { get; } = new string[1] { "speak" };

		public string Description { get; } = "Toggles global voice over the intercom.";

		public string[] Usage { get; } = new string[2] { "%player%", "enable/disable" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Broadcasting, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				if (!(sender is PlayerCommandSender playerCommandSender))
				{
					response = "You must be in-game to use this command!";
					return false;
				}
				bool flag = !Intercom.HasOverride(playerCommandSender.ReferenceHub);
				if (!Intercom.TrySetOverride(playerCommandSender.ReferenceHub, flag))
				{
					response = "Failed to set override flags. User or intercom is null.";
					return false;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " toggled global intercom transmission.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				response = "Done! Global voice over the intercom toggled " + (flag ? "on" : "off") + ".";
				return true;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			response = "Invalid argument, state was not defined.";
			if (newargs.Length == 0)
			{
				return false;
			}
			string text = newargs[0].ToUpper();
			bool flag2 = false;
			bool flag3 = false;
			switch (text)
			{
			case "ENABLED":
			case "ENABLE":
			case "TRUE":
			case "1":
				flag3 = true;
				break;
			case "DISABLED":
			case "DISABLE":
			case "FALSE":
			case "0":
				flag3 = false;
				break;
			default:
				flag2 = true;
				break;
			}
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (flag2)
				{
					flag3 = !Intercom.HasOverride(item);
				}
				if (Intercom.TrySetOverride(item, flag3))
				{
					if (num != 0)
					{
						stringBuilder.Append(", ");
					}
					stringBuilder.Append(item.LoggedNameFromRefHub());
					num++;
				}
			}
			if (num > 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} {1} global intercom transmission for player{2}{3}.", sender.LogName, flag3 ? "enabled" : "disabled", (num == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			}
			StringBuilderPool.Shared.Return(stringBuilder);
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
