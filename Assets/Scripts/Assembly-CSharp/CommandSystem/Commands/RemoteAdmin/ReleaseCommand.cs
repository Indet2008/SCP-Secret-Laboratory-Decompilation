using System;
using System.Collections.Generic;
using System.Text;
using InventorySystem.Disarming;
using NorthwoodLib.Pools;
using Utils;
using Utils.Networking;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ReleaseCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "release";

		public string[] Aliases { get; } = new string[1] { "free" };

		public string Description { get; } = "Releases the specified disarmed player(s).";

		public string[] Usage { get; } = new string[1] { "%player%" };

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
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId array processing.";
				return false;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null))
				{
					num++;
					item.inventory.SetDisarmedStatus(null);
					new DisarmedPlayersListMessage(DisarmedPlayers.Entries).SendToAuthenticated();
					if (num != 0)
					{
						stringBuilder.Append(", ");
					}
					stringBuilder.Append(item.LoggedNameFromRefHub());
				}
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} administratively released {stringBuilder}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			StringBuilderPool.Shared.Return(stringBuilder);
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
