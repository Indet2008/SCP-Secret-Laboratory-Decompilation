using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerStatsSystem;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SetMaxHealthCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "maxhp";

		public string[] Aliases { get; } = new string[2] { "setmaxhealth", "setmaxhp" };

		public string Description { get; } = "Sets the player(s) maximum health to the specified amount.";

		public string[] Usage { get; } = new string[2] { "%player%", "Amount" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			float num = (float.TryParse(newargs[0], out num) ? num : 0f);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int num2 = 0;
			if (list != null)
			{
				foreach (ReferenceHub item in list)
				{
					if (!(item == null))
					{
						HealthStat module = item.playerStats.GetModule<HealthStat>();
						if (num < 0f && item.roleManager.CurrentRole is IHealthbarRole healthbarRole)
						{
							module.MaxValue = healthbarRole.MaxHealth;
						}
						else
						{
							module.MaxValue = num;
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
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} set maximum health of player{1}{2} to {3}.", sender.LogName, (num2 == 1) ? " " : "s ", stringBuilder, num), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			StringBuilderPool.Shared.Return(stringBuilder);
			ListPool<ReferenceHub>.Shared.Return(list);
			response = string.Format("Done! The request affected {0} player{1}", num2, (num2 == 1) ? "!" : "s!");
			return true;
		}
	}
}
