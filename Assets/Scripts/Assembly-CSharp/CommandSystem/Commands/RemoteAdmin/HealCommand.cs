using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using PlayerStatsSystem;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class HealCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "heal";

		public string[] Aliases { get; }

		public string Description { get; } = "Heals player(s) a specified amount.";

		public string[] Usage { get; } = new string[2] { "%player%", "Amount (0 = full)" };

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
			int num = ((newargs != null && newargs.Length != 0 && int.TryParse(newargs[0], out num)) ? num : 0);
			float percentageCap = ((newargs != null && newargs.Length > 1 && float.TryParse(newargs[1], out percentageCap)) ? percentageCap : 1f);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int num2 = 0;
			if (list != null)
			{
				foreach (ReferenceHub item in list)
				{
					if (item != null)
					{
						HealthStat module = item.playerStats.GetModule<HealthStat>();
						if (num > 0)
						{
							module.AddAmount(Mathf.Abs(num), percentageCap);
						}
						else
						{
							module.CurValue = module.MaxValue;
						}
						if (num2 != 0)
						{
							stringBuilder.Append(", ");
						}
						stringBuilder.Append(item.LoggedNameFromRefHub());
						num2++;
					}
				}
			}
			if (num2 > 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} healed player{1}{2}.", sender.LogName, (num2 == 1) ? " " : "s ", stringBuilder), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			StringBuilderPool.Shared.Return(stringBuilder);
			response = string.Format("Done! The request affected {0} player{1}", num2, (num2 == 1) ? "!" : "s!");
			return true;
		}
	}
}
