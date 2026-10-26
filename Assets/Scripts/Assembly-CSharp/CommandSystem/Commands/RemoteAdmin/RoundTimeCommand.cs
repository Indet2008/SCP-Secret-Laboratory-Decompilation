using System;
using System.Globalization;
using GameCore;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RoundTimeCommand : ICommand
	{
		public string Command { get; } = "roundtime";

		public string[] Aliases { get; } = new string[2] { "rtime", "rt" };

		public string Description { get; } = "Displays the current round duration.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (RoundStart.RoundLength.Ticks == 0L)
			{
				response = "The round has not started yet!";
				return false;
			}
			response = "Round time: " + RoundStart.RoundLength.ToString("hh\\:mm\\:ss\\.fff", CultureInfo.InvariantCulture);
			return true;
		}
	}
}
