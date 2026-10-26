using System;
using RoundRestarting;
using UnityEngine;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class UptimeRoundsCommand : ICommand
	{
		public string Command { get; } = "uptime";

		public string[] Aliases { get; } = new string[1] { "rounds" };

		public string Description { get; } = "Displays the uptime of the game.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = $"Server uptime: {Time.unscaledTime} seconds, {RoundRestart.UptimeRounds} rounds.";
			return true;
		}
	}
}
