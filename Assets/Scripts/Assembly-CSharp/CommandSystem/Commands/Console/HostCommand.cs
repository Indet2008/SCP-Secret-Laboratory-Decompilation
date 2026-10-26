using System;
using Mirror;
using UnityEngine;

namespace CommandSystem.Commands.Console
{
	// Not part of the original game: a shortcut for the main menu's "Create server" button.
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class HostCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "host";

		public string[] Aliases { get; } = new string[1] { "createserver" };

		public string Description { get; } = "Opens the \"Create server\" window, or starts a local server right away with \"now\".";

		public string[] Usage { get; } = new string[1] { "now (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (ServerStatic.IsDedicated)
			{
				response = "This command can only be used on a game client.";
				return false;
			}
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
				response = "Starting a local server...";
				return true;
			}
			manager.ShowCreateServerPopup();
			if (GameCore.Console.Singleton != null && GameCore.Console.Singleton.IsEnabled)
			{
				// Close the console so the window isn't hidden behind it.
				ToggleableMenus.ToggleableMenuController.HideCurrent();
			}
			response = "Opened the \"Create server\" window.";
			return true;
		}
	}
}
