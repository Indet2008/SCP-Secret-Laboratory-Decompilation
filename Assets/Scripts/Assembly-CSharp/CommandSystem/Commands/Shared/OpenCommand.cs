using System;
using System.IO;
using Mirror;
using UnityEngine;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(ConfigCommand))]
	public class OpenCommand : ICommand
	{
		public string Command { get; } = "open";

		public string[] Aliases { get; } = new string[2] { "o", "op" };

		public string Description { get; } = "Opens the games config";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is ServerConsoleSender))
			{
				response = "This command can only be executed from the server or client console.";
				return false;
			}
			if (!NetworkServer.active)
			{
				response = "This command can only be used on a server.";
				return false;
			}
			if (File.Exists(FileManager.GetAppFolder(addSeparator: true, serverConfig: true) + "config_gameplay.txt"))
			{
				Application.OpenURL(FileManager.GetAppFolder(addSeparator: true, serverConfig: true) + "config_gameplay.txt");
				response = "Config file opened.";
				return true;
			}
			response = "Config file not found!";
			return false;
		}
	}
}
