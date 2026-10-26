using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class SubscribeCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "subscribe";

		public string[] Aliases { get; } = new string[1] { "sub" };

		public string Description { get; } = "Subscribes you to a data feed.";

		public string[] Usage { get; } = new string[1] { "console/log/all" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is IOutput output))
			{
				response = "You can't subscribe to a feed.";
				return false;
			}
			if (arguments.Count != 1)
			{
				response = "Usage: subscribe <feed>\nAvailable feeds: console/log/all";
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.ServerLogLiveFeed, out response))
			{
				return false;
			}
			switch (arguments.At(0).ToLowerInvariant())
			{
			case "console":
				if (ServerConsole.ConsoleOutputs.ContainsKey(output.OutputId))
				{
					goto IL_0096;
				}
				if (!(sender is ServerConsoleSender))
				{
					if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
					{
						return false;
					}
					ServerConsole.ConsoleOutputs.TryAdd(output.OutputId, output);
					response = "Subscribed to console feed.";
					return true;
				}
				goto IL_00b1;
			case "log":
				if (!ServerLogs.LiveLogOutput.ContainsKey(output.OutputId))
				{
					ServerLogs.LiveLogOutput.TryAdd(output.OutputId, output);
					response = "Subscribed to log feed.";
					return true;
				}
				goto IL_0096;
			case "all":
				if (!(sender is ServerConsoleSender))
				{
					if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
					{
						return false;
					}
					ServerConsole.ConsoleOutputs.TryAdd(output.OutputId, output);
					ServerLogs.LiveLogOutput.TryAdd(output.OutputId, output);
					response = "Subscribed to all feeds.";
					return true;
				}
				goto IL_00b1;
			default:
				{
					response = "Invalid feed name.";
					return false;
				}
				IL_0096:
				response = "You are already subscribed to this feed.";
				return false;
				IL_00b1:
				response = "Console feed is not available for server or client console.";
				return false;
			}
		}
	}
}
