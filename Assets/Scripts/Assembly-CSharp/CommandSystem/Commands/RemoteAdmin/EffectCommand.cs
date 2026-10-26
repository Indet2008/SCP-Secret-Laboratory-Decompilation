using System;
using System.Collections.Generic;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class EffectCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "effect";

		public string[] Aliases { get; } = new string[1] { "pfx" };

		public string Description { get; } = "Applies a status effect to player(s).";

		public string[] Usage { get; } = new string[4] { "EffectName", "Intensity", "Duration", "%player%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Effects, out response))
			{
				return false;
			}
			if (arguments.Count < 4)
			{
				response = "To execute this command provide at least 4 arguments!\nUsage: " + Command + " " + this.DisplayCommandUsage();
				return false;
			}
			string text = arguments.At(0);
			if (!byte.TryParse(arguments.At(1), out var result))
			{
				response = "Effect intensity must be a byte value between 0-255.\nUsage: " + Command + " " + this.DisplayCommandUsage() + "'";
				return false;
			}
			if (!float.TryParse(arguments.At(2), out var result2))
			{
				response = "Effect duration must be a valid float value.\nUsage: " + Command + " " + this.DisplayCommandUsage() + "'";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 3, out var _);
			if (list == null || list.Count == 0)
			{
				response = "Couldn't find any player(s) using the specified arguments.";
				return false;
			}
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null) && item.playerEffectsController.TryGetEffect(text, out var playerEffect))
				{
					playerEffect.ServerSetState(result, result2);
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} applied a status effect {text} for player {item.LoggedNameFromRefHub()}. Intensity: {result} - Duration: {result2}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					num++;
				}
			}
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
