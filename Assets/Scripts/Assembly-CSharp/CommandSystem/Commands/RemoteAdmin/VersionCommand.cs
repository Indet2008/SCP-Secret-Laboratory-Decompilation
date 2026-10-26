using System;
using GameCore;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class VersionCommand : ICommand
	{
		public string Command { get; } = "version";

		public string[] Aliases { get; }

		public string Description { get; } = "Returns the version of the server.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = "Server Version: " + GameCore.Version.VersionString + " " + Application.buildGUID;
			return true;
		}
	}
}
