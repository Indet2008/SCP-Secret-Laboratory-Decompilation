using System;
using Mirror.LiteNetLib4Mirror;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class PingCommand : ICommand
	{
		public string Command { get; } = "ping";

		public string[] Aliases { get; }

		public string Description { get; } = "Pong!";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			switch (arguments.Count)
			{
			case 0:
			{
				if (!(sender is PlayerCommandSender playerCommandSender))
				{
					response = "This command is only available for players!";
					return false;
				}
				int connectionId2 = playerCommandSender.ReferenceHub.networkIdentity.connectionToClient.connectionId;
				if (connectionId2 == 0)
				{
					response = "This command is not available for the host!";
					return false;
				}
				response = $"Your ping: {LiteNetLib4MirrorServer.Peers[connectionId2].Ping * 2}ms";
				return true;
			}
			case 1:
			{
				if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
				{
					return false;
				}
				if (!int.TryParse(arguments.At(0), out var result))
				{
					response = "Invalid player id!";
					return false;
				}
				if (!ReferenceHub.TryGetHub(result, out var hub))
				{
					response = "Invalid player id!";
					return false;
				}
				int connectionId = hub.networkIdentity.connectionToClient.connectionId;
				if (connectionId == 0)
				{
					response = "This command is not available for the host!";
					return false;
				}
				response = $"Ping: {LiteNetLib4MirrorServer.Peers[connectionId].Ping * 2}ms";
				return true;
			}
			default:
				response = "Too many arguments! (expected 0 or 1)";
				return false;
			}
		}
	}
}
