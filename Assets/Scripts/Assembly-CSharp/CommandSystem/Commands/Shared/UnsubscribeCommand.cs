using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class UnsubscribeCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "unsubscribe";

		public string[] Aliases { get; } = new string[1] { "unsub" };

		public string Description { get; } = "Unsubscribes you from a data feed.";

		public string[] Usage { get; } = new string[1] { "console/log/all" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is IOutput output))
			{
				response = "You can't unsubscribe from a feed.";
				return false;
			}
			if (arguments.Count != 1)
			{
				response = "Usage: unsubscribe <feed>\nAvailable feeds: console/log/all";
				return false;
			}
			IOutput value;
			switch (arguments.At(0).ToLowerInvariant())
			{
			case "console":
				if (ServerConsole.ConsoleOutputs.ContainsKey(output.OutputId))
				{
					ServerConsole.ConsoleOutputs.TryRemove(output.OutputId, out value);
					response = "Unsubscribed from console feed.";
					return true;
				}
				goto IL_0085;
			case "log":
				if (ServerLogs.LiveLogOutput.ContainsKey(output.OutputId))
				{
					ServerLogs.LiveLogOutput.TryRemove(output.OutputId, out value);
					response = "Unsubscribed from log feed.";
					return true;
				}
				goto IL_0085;
			case "all":
				ServerConsole.ConsoleOutputs.TryRemove(output.OutputId, out value);
				ServerLogs.LiveLogOutput.TryRemove(output.OutputId, out value);
				response = "Unsubscribed from all feeds.";
				return true;
			default:
				{
					response = "Invalid feed name.";
					return false;
				}
				IL_0085:
				response = "You are not subscribed to that feed.";
				return false;
			}
		}
	}
}
