using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles.PlayableScps.Scp079;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SetLevelCommand : Scp079CommandBase
	{
		public override string Command { get; } = "setlevel";

		public override string[] Aliases { get; } = new string[3] { "settier", "level", "lvl" };

		public override string Description { get; } = "Sets the level of the player playing as SCP-079.";

		public override string[] Usage { get; } = new string[2] { "%player%", "New Level" };

		public override bool OnExecute(ArraySegment<string> arguments, ICommandSender sender, int input, out string response)
		{
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int input2 = 0;
			int num = 0;
			bool flag = input-- <= 1;
			input--;
			foreach (ReferenceHub item in list)
			{
				if (item.roleManager.CurrentRole is Scp079Role scp079Role && scp079Role.SubroutineModule.TryGetSubroutine<Scp079TierManager>(out var subroutine))
				{
					if (!flag)
					{
						input2 = subroutine.AbsoluteThresholds[Mathf.Clamp(input, 0, subroutine.AbsoluteThresholds.Length - 1)];
					}
					ApplyChanges(subroutine, input2);
					num++;
					stringBuilder.Append(", " + item.LoggedNameFromRefHub());
				}
			}
			if (num > 0)
			{
				string text = StringBuilderPool.Shared.ToStringReturn(stringBuilder).Substring(2);
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} used \"{1} ({2})\" command on player{3}{4}.", sender.LogName, Command, input, (num == 1) ? " " : "s ", text), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			else
			{
				StringBuilderPool.Shared.Return(stringBuilder);
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}

		public override void ApplyChanges(Scp079TierManager manager, int exp)
		{
			manager.TotalExp = exp;
		}
	}
}
