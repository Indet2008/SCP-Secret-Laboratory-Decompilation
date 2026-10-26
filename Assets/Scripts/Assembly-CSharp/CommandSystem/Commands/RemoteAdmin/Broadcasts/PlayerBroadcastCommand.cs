using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Broadcasts
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class PlayerBroadcastCommand : BroadcastCommandBase
	{
		public override string Command { get; } = "playerbroadcast";

		public override string[] Aliases { get; } = new string[1] { "pbc" };

		public override string Description { get; } = "Sends an administrative broadcast to specific player(s).";

		public override string[] Usage { get; } = new string[4] { "%player%", "Duration", "BroadcastFlag (Optional)", "Message" };

		public override bool OnExecute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (newargs == null || newargs.Length < MinimumArguments)
			{
				response = "To execute this command provide at least 3 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			string text = newargs[0];
			if (!IsValidDuration(text, out var time))
			{
				response = "Invalid argument for duration: " + text + " Usage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			bool flag = HasInputFlag(newargs[1], out var broadcastFlag, newargs.Length);
			string text2 = RAUtils.FormatArguments(newargs.Segment(1), flag ? 1 : 0);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			Broadcast singleton = Broadcast.Singleton;
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (num++ != 0)
				{
					stringBuilder.Append(", ");
				}
				stringBuilder.Append(item.LoggedNameFromRefHub());
				singleton.TargetAddElement(item.connectionToClient, text2, time, broadcastFlag);
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} broadcast text \"{text2}\" to {num} players. Duration: {time} seconds. Affected players: {stringBuilder}. Broadcast Flag: {broadcastFlag}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			StringBuilderPool.Shared.Return(stringBuilder);
			response = $"Broadcast sent to {num} players.";
			return true;
		}
	}
}
