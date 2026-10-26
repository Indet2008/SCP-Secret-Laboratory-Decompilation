using System;
using CustomPlayerEffects;
using Mirror;
using RemoteAdmin;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class PocketDimensionCommand : ICommand
	{
		public string Command { get; } = "pocketdimension";

		public string[] Aliases { get; } = new string[3] { "pocketdim", "shadowrealm", "pd" };

		public string Description { get; } = "Banishes yourself to the pocket dimension.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!NetworkServer.active || !ReferenceHub.TryGetHostHub(out var hub))
			{
				response = "You are not connected to a local server.";
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			CharacterClassManager characterClassManager = hub.characterClassManager;
			if (characterClassManager == null || !characterClassManager.isLocalPlayer || !characterClassManager.isServer || !characterClassManager.RoundStarted)
			{
				response = "Please start round before using this command.";
				return false;
			}
			if (!(sender is PlayerCommandSender { ReferenceHub: var referenceHub }))
			{
				response = "Only players can run this command.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " teleported to the Pocket Dimension.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			referenceHub.playerEffectsController.EnableEffect<PocketCorroding>();
			response = "You banished yourself to the Pocket Dimension!";
			return true;
		}
	}
}
