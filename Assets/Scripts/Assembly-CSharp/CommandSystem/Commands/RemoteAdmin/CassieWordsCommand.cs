using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Cassie;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CassieWordsCommand : ICommand
	{
		public string Command { get; } = "cassiewords";

		public string[] Aliases { get; }

		public string Description { get; } = "Lists CASSIE words.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!CassieTtsAnnouncer.TryGetDatabase(out var db))
			{
				response = "Unable to fetch line database.";
				return false;
			}
			IEnumerable<string> enumerable = db.AllLines.Select((CassieLine line) => line.ApiName);
			if (arguments.Count > 0)
			{
				Regex regex = new Regex(arguments.FirstElement(), RegexOptions.IgnoreCase);
				enumerable = enumerable.Where((string line) => regex.IsMatch(line));
			}
			response = "CASSIE words: " + string.Join(" ", enumerable);
			return true;
		}
	}
}
