using System;
using GameCore;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(ConfigCommand))]
	public class ValueCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "value";

		public string[] Aliases { get; } = new string[1] { "val" };

		public string Description { get; } = "Returns the value of specified config key";

		public string[] Usage { get; } = new string[1] { "Key" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "Please specify the config key!";
				return false;
			}
			if (arguments.At(0).Equals("query_administrator_password", StringComparison.OrdinalIgnoreCase) || arguments.At(0).Equals("administrator_query_password", StringComparison.OrdinalIgnoreCase))
			{
				response = "You can't read value of this config key for security reasons.";
				return false;
			}
			if (ConfigFile.ServerConfig.TryGetString(arguments.At(0), out var value))
			{
				response = "The value of <i>'" + arguments.At(0) + "'</i> is: " + value;
				return true;
			}
			response = "Key <i>'" + arguments.At(0) + "'</i> is not present in the config!";
			return false;
		}
	}
}
