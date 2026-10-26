using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ChangeCustomPlayerInfoCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "custominfo";

		public string[] Aliases { get; } = new string[2] { "customi", "cinfo" };

		public string Description { get; } = "Allows to quickly change the custom info string of a player";

		public string[] Usage { get; } = new string[2] { "%player%", "text (optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (list == null)
			{
				response = "Cannot find player! Try using the player ID!";
				return false;
			}
			string text = ((newargs == null) ? null : string.Join(" ", newargs));
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			foreach (ReferenceHub item in list)
			{
				if (text == null)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} cleared custom info of player {item.PlayerId} ({item.nicknameSync.MyNick}).", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					stringBuilder.AppendFormat("Reset {0}'s custom info.\n", item.LoggedNameFromRefHub());
					item.nicknameSync.CustomPlayerInfo = null;
					continue;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} set custom info of player {item.PlayerId} ({item.nicknameSync.MyNick}) to \"{text}\".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				stringBuilder.AppendFormat("Set {0}'s custom info to: {1}\n", item.LoggedNameFromRefHub(), text);
				item.nicknameSync.CustomPlayerInfo = text;
			}
			response = stringBuilder.ToString().Trim();
			StringBuilderPool.Shared.Return(stringBuilder);
			return true;
		}
	}
}
