using System;
using PlayerRoles.PlayableScps.Scp3114;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class Scp3114HistoryCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "scp3114history";

		public string[] Aliases { get; } = new string[3] { "3114history", "history3114", "historyscp3114" };

		public string Description { get; } = "Prints identity history of SCP-3114.";

		public string[] Usage { get; } = new string[1] { "Instance ID (if multiple recorded)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = Scp3114History.PrintHistory(null);
			}
			else
			{
				if (!int.TryParse(arguments.At(0), out var result))
				{
					result = -1;
				}
				response = Scp3114History.PrintHistory(result);
			}
			return true;
		}
	}
}
