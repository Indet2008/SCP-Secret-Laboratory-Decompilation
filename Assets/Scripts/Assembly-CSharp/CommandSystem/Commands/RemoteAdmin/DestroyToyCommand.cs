using System;
using AdminToys;
using Mirror;
using Utils.Networking;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DestroyToyCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "destroytoy";

		public string[] Aliases { get; }

		public string Description { get; } = "Despawns a toy placed by an admin.";

		public string[] Usage { get; } = new string[1] { "NetID of toy to remove." };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1 || !uint.TryParse(arguments.Array[1], out var result))
			{
				response = "Failed to parse NetID of the toy to destroy.";
				return false;
			}
			if (!NetworkUtils.SpawnedNetIds.TryGetValue(result, out var value) || !value.TryGetComponent<AdminToyBase>(out var component))
			{
				response = $"{result} is not a valid toy NetID.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} removed admin toy: {component.CommandName} ({component.netId}).", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = $"Toy {result} successfully removed.";
			NetworkServer.Destroy(component.gameObject);
			return true;
		}
	}
}
