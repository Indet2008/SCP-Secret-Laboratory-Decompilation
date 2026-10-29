using System;
using Mirror;

namespace CommandSystem.Commands.Console
{
	// The original StartServerCommand ("host", aliases "startserver"/"starthost"): calls
	// CustomNetworkManager.StartNondedicated and answers "Started a non-dedicated server.".
	// "now" (not in the original) skips the "Create server" window.
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class HostCommand : ICommand
	{
		public string Command { get; } = "host";

		public string[] Aliases { get; } = new string[2] { "startserver", "starthost" };

		public string Description { get; } = "Starts a non-dedicated server.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (NetworkServer.active || NetworkClient.active)
			{
				response = "Disconnect from the current server first.";
				return false;
			}
			CustomNetworkManager manager = UnityEngine.Object.FindObjectOfType<CustomNetworkManager>();
			if (manager == null)
			{
				response = "CustomNetworkManager not found. Start from the PreLoader or Loader scene.";
				return false;
			}
			if (arguments.Count > 0 && arguments.At(0).Equals("now", StringComparison.OrdinalIgnoreCase))
			{
				manager.CreateMatch();
			}
			else
			{
				manager.ShowCreateServerPopup();
			}
			response = "Started a non-dedicated server.";
			return true;
		}
	}
}
