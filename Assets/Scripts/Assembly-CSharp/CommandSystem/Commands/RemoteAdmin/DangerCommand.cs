using System;
using System.Collections.Generic;
using System.Text;
using CustomPlayerEffects;
using CustomPlayerEffects.Danger;
using NorthwoodLib.Pools;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DangerCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "danger";

		public string[] Aliases { get; }

		public string Description { get; } = "Outputs the currently active dangers of the specified player.";

		public string[] Usage { get; } = new string[1] { "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Effects, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null || list.Count != 1)
			{
				response = "This commands requires you to specify exactly one specific player!";
				return false;
			}
			ReferenceHub referenceHub = list[0];
			Scp1853 effect = referenceHub.playerEffectsController.GetEffect<Scp1853>();
			if (!effect.IsEnabled)
			{
				response = "The specified player does not have SCP-1853 active.";
				return false;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(referenceHub.nicknameSync.DisplayName);
			stringBuilder.Append(" has <color=#65dbeb>").Append(effect.CurrentDanger).Append("</color> danger stacks. <color=#80eb65>x")
				.Append(effect.StatMultiplier)
				.Append("</color> stat boost.");
			DangerStackBase[] dangers = effect.Dangers;
			foreach (DangerStackBase dangerStackBase in dangers)
			{
				if (dangerStackBase.IsActive)
				{
					int value = (int)((double)dangerStackBase.Duration - dangerStackBase.TimeTracker.Elapsed.TotalSeconds);
					stringBuilder.Append("\n- <color=#f59e42>").Append(dangerStackBase.GetType().Name).Append(":</color> ")
						.Append(dangerStackBase.DangerValue)
						.Append(" danger stacks")
						.Append(" <color=#65aeeb>(")
						.Append(value)
						.Append("s left)</color>");
				}
			}
			response = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " requested the SCP-1853 danger information of " + referenceHub.LoggedNameFromRefHub() + ".", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
			return true;
		}
	}
}
