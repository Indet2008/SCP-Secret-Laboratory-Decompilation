using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using PlayerRoles.PlayableScps.Scp079;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	public abstract class Scp079CommandBase : ICommand, IUsageProvider
	{
		public abstract string Command { get; }

		public abstract string[] Aliases { get; }

		public abstract string Description { get; }

		public abstract string[] Usage { get; }

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
			if (!uint.TryParse(arguments.At(arguments.Count - 1), out var result))
			{
				response = "Value argument must be a valid number.\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			return OnExecute(arguments, sender, (int)result, out response);
		}

		public virtual bool OnExecute(ArraySegment<string> arguments, ICommandSender sender, int input, out string response)
		{
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (item.roleManager.CurrentRole is Scp079Role scp079Role && scp079Role.SubroutineModule.TryGetSubroutine<Scp079TierManager>(out var subroutine))
				{
					ApplyChanges(subroutine, input);
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

		public abstract void ApplyChanges(Scp079TierManager manager, int input);
	}
}
