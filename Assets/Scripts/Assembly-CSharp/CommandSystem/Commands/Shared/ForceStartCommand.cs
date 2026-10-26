using System;
using GameCore;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class ForceStartCommand : ICommand
	{
		public string Command { get; } = "forcestart";

		public string[] Aliases { get; } = new string[4] { "fs", "rs", "start", "roundstart" };

		public string Description { get; } = "Forces the round to start.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (RoundStart.RoundStarted)
			{
				response = "This command can only be ran while in the lobby.";
				return false;
			}
			bool flag = CharacterClassManager.ForceRoundStart();
			if (flag)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " forced round start.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			response = (flag ? "Done! Forced round start." : "Failed to force start.");
			return flag;
		}
	}
}
