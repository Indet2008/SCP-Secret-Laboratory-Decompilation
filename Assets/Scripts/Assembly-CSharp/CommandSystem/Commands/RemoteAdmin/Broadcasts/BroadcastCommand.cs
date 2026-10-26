using System;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Broadcasts
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class BroadcastCommand : BroadcastCommandBase
	{
		public override string Command { get; } = "broadcast";

		public override string[] Aliases { get; } = new string[2] { "bc", "alert" };

		public override string Description { get; } = "Sends an administrative broadcast to all players.";

		public override string[] Usage { get; } = new string[3] { "Duration", "BroadcastFlag (Optional)", "Message" };

		public override bool OnExecute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			string text = arguments.At(0);
			if (!IsValidDuration(text, out var time))
			{
				response = "Invalid argument for duration: " + text + " Usage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			bool flag = HasInputFlag(arguments.At(1), out var broadcastFlag, arguments.Count);
			string text2 = RAUtils.FormatArguments(arguments, (!flag) ? 1 : 2);
			Broadcast.Singleton.RpcAddElement(text2, time, broadcastFlag);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} broadcast text \"{text2}\". Duration: {text} seconds. Broadcast Flag: {broadcastFlag}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Global broadcast sent.";
			return true;
		}
	}
}
