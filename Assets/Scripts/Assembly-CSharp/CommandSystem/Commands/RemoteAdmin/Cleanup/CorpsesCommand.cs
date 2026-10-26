using System;
using System.Linq;
using Mirror;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	[CommandHandler(typeof(CleanupCommand))]
	public class CorpsesCommand : ICommand
	{
		public string Command { get; } = "corpses";

		public string[] Aliases { get; } = new string[6] { "corpse", "ragdolls", "ragdoll", "r", "c", "0" };

		public string Description { get; } = "Cleans up ragdolls from the map.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			BasicRagdoll[] array = (from r in UnityEngine.Object.FindObjectsOfType<BasicRagdoll>()
				orderby r.Info.CreationTime descending
				select r).ToArray();
			int num = array.Length;
			if (arguments.Count > 0 && int.TryParse(arguments.At(0), out var result) && result < array.Length)
			{
				num = result;
			}
			for (int num2 = 0; num2 < num; num2++)
			{
				NetworkServer.Destroy(array[num2].gameObject);
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} has force-cleaned up {num} ragdolls.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = $"{num} ragdolls have been deleted.";
			return true;
		}
	}
}
