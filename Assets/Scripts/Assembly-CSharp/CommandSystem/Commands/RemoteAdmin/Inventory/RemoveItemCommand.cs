using System;
using System.Collections.Generic;
using System.Linq;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Firearms.Ammo;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Inventory
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RemoveItemCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "removeitem";

		public string[] Aliases { get; }

		public string Description { get; } = "Remove the specified item from the player(s) inventory.";

		public string[] Usage { get; } = new string[2] { "%player%", "%item%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.GivingItems, out response))
			{
				return false;
			}
			if (arguments.Count >= 2)
			{
				List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
				if (newargs == null || newargs.Length == 0)
				{
					response = "You must specify item(s) to give.";
					return false;
				}
				ItemType[] array = ParseItems(newargs[0]).ToArray();
				if (array.Length == 0)
				{
					response = "You didn't input any items.";
					return false;
				}
				int num = 0;
				int num2 = 0;
				string arg = string.Empty;
				if (list != null)
				{
					foreach (ReferenceHub item in list)
					{
						try
						{
							ItemType[] array2 = array;
							foreach (ItemType id in array2)
							{
								RemoveItem(item, sender, id);
							}
						}
						catch (Exception ex)
						{
							num++;
							arg = ex.Message;
							continue;
						}
						num2++;
					}
				}
				response = ((num == 0) ? string.Format("Done! The request affected {0} player{1}", num2, (num2 == 1) ? "!" : "s!") : $"Failed to execute the command! Failures: {num}\nLast error log:\n{arg}");
				return true;
			}
			response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
			return false;
		}

		private IEnumerable<ItemType> ParseItems(string argument)
		{
			string[] array = argument.Split('.');
			string[] array2 = array;
			for (int i = 0; i < array2.Length; i++)
			{
				if (int.TryParse(array2[i], out var result) && Enum.IsDefined(typeof(ItemType), result))
				{
					yield return (ItemType)result;
				}
			}
		}

		private void RemoveItem(ReferenceHub ply, ICommandSender sender, ItemType id)
		{
			ItemBase itemBase = InventoryItemLoader.AvailableItems[id];
			bool flag = itemBase.Category != ItemCategory.Ammo;
			KeyValuePair<ushort, ItemBase> keyValuePair = ply.inventory.UserInventory.Items.FirstOrDefault((KeyValuePair<ushort, ItemBase> i) => i.Value.ItemTypeId == id);
			if (!((keyValuePair.Value == null) & flag))
			{
				if (flag)
				{
					ply.inventory.ServerRemoveItem(keyValuePair.Key, null);
				}
				else
				{
					AmmoPickup ammoPickup = itemBase.PickupDropModel as AmmoPickup;
					int curAmmo = ply.inventory.GetCurAmmo(itemBase.ItemTypeId);
					ply.inventory.ServerSetAmmo(itemBase.ItemTypeId, curAmmo - ammoPickup.SavedAmmo);
					itemBase.OnRemoved(itemBase.PickupDropModel);
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} removed item {id} from {ply.LoggedNameFromRefHub()}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
		}
	}
}
