using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ClearEffectsCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "cleareffects";

		public string[] Aliases { get; } = new string[2] { "cfx", "clearfx" };

		public string Description { get; } = "Clears all status effects from the specified player(s).";

		public string[] Usage { get; } = new string[1] { "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Effects, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "To execute this command provide at least 1 arguments!\nUsage: " + Command + " " + string.Join(" ", Usage);
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null))
				{
					StatusEffectBase[] allEffects = item.playerEffectsController.AllEffects;
					for (int i = 0; i < allEffects.Length; i++)
					{
						allEffects[i].Intensity = 0;
					}
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " clear all effects for player " + item.LoggedNameFromRefHub() + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					num++;
				}
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
