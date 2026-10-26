using System;
using AudioPooling;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(ClientCommandHandler))]
	public class AudioPoolDebug : ICommand, IUsageProvider
	{
		public string Command { get; } = "audiopooldebug";

		public string[] Aliases { get; } = new string[1] { "audiopoolingdebug" };

		public string Description { get; } = "Prints debug information about Audio Pooling system.";

		public string[] Usage { get; } = new string[1] { "Force refresh (bool, Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			bool result = default;
			bool forceUpdate = (arguments.Count > 0 && bool.TryParse(arguments.At(0), out result)) & result;
			response = AudioSourcePoolManager.ProcessConsoleCommand(forceUpdate);
			return true;
		}
	}
}
