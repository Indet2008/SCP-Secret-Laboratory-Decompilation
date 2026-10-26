using System;
using System.Collections.Generic;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class FriendlyFireDetectorCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "friendlyfiredetector";

		public string[] Aliases { get; } = new string[4] { "tk", "tkd", "teamkilldetector", "ffd" };

		public string Description { get; } = "Friendly fire detection and logging";

		public string[] Usage { get; } = new string[1] { "Player ID or Name/status/pause/unpause>" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			switch (arguments.At(0))
			{
			case "status":
				response = "FFD#Friendly fire detector is currently " + (FriendlyFireConfig.PauseDetector ? string.Empty : "**NOT** ") + "paused.";
				return true;
			case "pause":
				if (FriendlyFireConfig.PauseDetector)
				{
					response = "Friendly fire detector is already paused.";
					return false;
				}
				FriendlyFireConfig.PauseDetector = true;
				response = "Friendly fire detector has been paused.";
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " paused Friendly Fire Detector.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				return true;
			case "unpause":
				if (!FriendlyFireConfig.PauseDetector)
				{
					response = "Friendly fire detector is not paused.";
					return false;
				}
				FriendlyFireConfig.PauseDetector = false;
				response = "Friendly fire detector has been unpaused.";
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " unpaused paused Friendly Fire Detector.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				return true;
			default:
			{
				List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
				if (list != null && list.Count != 1)
				{
					response = "FFD command requires exact one selected player, not an array of players!";
					return false;
				}
				if (list == null)
				{
					response = "The specified player was not found! \nUsage: FFD <Player ID or Name/status/pause/unpause>";
					return false;
				}
				FriendlyFireHandler friendlyFireHandler = list[0].FriendlyFireHandler;
				response = $"--- Friendly Fire Detector Stats ---\nKills - Damage dealt\n\nRound: {friendlyFireHandler.Round.Kills} - {friendlyFireHandler.Round.Damage}\nLife: {friendlyFireHandler.Life.Kills} - {friendlyFireHandler.Life.Damage}\nWindow: {friendlyFireHandler.Window.Kills} - {friendlyFireHandler.Window.Damage} [Window: {FriendlyFireConfig.Window}s]\nRespawn: {friendlyFireHandler.Respawn.Kills} - {friendlyFireHandler.Respawn.Damage} [Window: {FriendlyFireConfig.RespawnWindow}s]";
				return true;
			}
			}
		}
	}
}
