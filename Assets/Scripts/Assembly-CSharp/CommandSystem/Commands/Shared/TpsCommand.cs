using System;
using UnityEngine;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class TpsCommand : ICommand
	{
		public string Command => "tps";

		public string[] Aliases => Array.Empty<string>();

		public string Description => "Returns information about server current tps / max tps";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			response = $"TPS: {Math.Round(1f / Time.smoothDeltaTime)}/{ServerStatic.ServerTickrate}";
			return true;
		}
	}
}
