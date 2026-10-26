using System;
using System.Collections.Generic;
using Mirror;
using NetworkManagerUtils.Dummies;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Dummies
{
	[CommandHandler(typeof(DummiesCommand))]
	public class DestroyDummyCommand : ICommand
	{
		public string Command { get; } = "destroy";

		public string[] Aliases { get; } = new string[3] { "d", "kill", "remove" };

		public string Description { get; } = "Spawns a dummy on the map.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "You must specify a dummy to destroy.";
				return false;
			}
			if (arguments.At(0).Equals("all", StringComparison.OrdinalIgnoreCase))
			{
				DummyUtils.DestroyAllDummies();
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " has destroyed all dummies.", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				response = "All dummies have been destroyed.";
				return true;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId or name array processing.";
				return false;
			}
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null) && item.IsDummy)
				{
					NetworkServer.Destroy(item.gameObject);
					num++;
				}
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} administratively destroyed {num} dummies.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = string.Format("Done! The request affected {0} dumm{1}", num, (num == 1) ? "y!" : "ies!");
			return true;
		}
	}
}
