using System;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(ConfigCommand))]
	public class PathCommand : ICommand
	{
		public string Command { get; } = "path";

		public string[] Aliases { get; }

		public string Description { get; } = "Returns the path to the config file";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			response = "Configuration file path: <i>" + FileManager.GetAppFolder(addSeparator: true, serverConfig: true) + "</i>";
			return true;
		}
	}
}
