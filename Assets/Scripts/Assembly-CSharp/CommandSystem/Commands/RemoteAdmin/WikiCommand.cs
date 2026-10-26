using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class WikiCommand : ICommand
	{
		public string Command { get; } = "wiki";

		public string[] Aliases { get; }

		public string Description { get; } = "Opens RA help page on the game wiki.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Wiki page has been opened.";
			return true;
		}
	}
}
