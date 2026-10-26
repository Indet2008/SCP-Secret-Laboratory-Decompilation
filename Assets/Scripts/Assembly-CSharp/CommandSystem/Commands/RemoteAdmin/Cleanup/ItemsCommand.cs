using System;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	[CommandHandler(typeof(CleanupCommand))]
	public class ItemsCommand : ICommand
	{
		public string Command { get; } = "items";

		public string[] Aliases { get; } = new string[3] { "item", "i", "1" };

		public string Description { get; } = "Cleans up items from the map.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			ItemPickupBase[] array = UnityEngine.Object.FindObjectsOfType<ItemPickupBase>();
			int num = array.Length;
			if (arguments.Count > 0 && int.TryParse(arguments.At(0), out var result) && result < array.Length)
			{
				num = result;
			}
			for (int i = 0; i < num; i++)
			{
				NetworkServer.Destroy(array[i].gameObject);
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} has force-cleaned up {num} items.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = $"{num} items have been deleted.";
			return true;
		}
	}
}
