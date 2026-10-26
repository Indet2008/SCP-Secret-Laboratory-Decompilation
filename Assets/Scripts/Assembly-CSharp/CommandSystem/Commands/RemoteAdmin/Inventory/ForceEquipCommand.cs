using System;
using System.Collections.Generic;
using InventorySystem.Items;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Inventory
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ForceEquipCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "forceequip";

		public string[] Aliases { get; } = new string[2] { "fequip", "forceeq" };

		public string Description { get; } = "Forces player to equip item of provided type (if any exists in the inventory).";

		public string[] Usage { get; } = new string[2] { "%player%", "%item%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.GivingItems, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			ItemType itemType = ItemType.None;
			if (newargs != null && newargs.Length != 0)
			{
				string text = newargs[0];
				if (text.Contains('.'))
				{
					text = text.Split('.')[0];
				}
				if (int.TryParse(text, out var result) && Enum.IsDefined(typeof(ItemType), result))
				{
					itemType = (ItemType)result;
				}
			}
			int num = 0;
			int num2 = 0;
			string empty = string.Empty;
			if (list != null)
			{
				Func<ReferenceHub, ItemType, bool> func = ((itemType == ItemType.None) ? new Func<ReferenceHub, ItemType, bool>(TryHolster) : new Func<ReferenceHub, ItemType, bool>(TryEquip));
				foreach (ReferenceHub item in list)
				{
					if (func(item, itemType))
					{
						num2++;
					}
				}
			}
			response = ((num == 0) ? string.Format("Done! The request affected {0} player{1}", num2, (num2 == 1) ? "!" : "s!") : $"Failed to execute the command! Failures: {num}\nLast error log:\n{empty}");
			return true;
		}

		private bool TryEquip(ReferenceHub hub, ItemType itemToEquip)
		{
			foreach (KeyValuePair<ushort, ItemBase> item in hub.inventory.UserInventory.Items)
			{
				if (item.Value.ItemTypeId == itemToEquip)
				{
					hub.inventory.ServerSelectItem(item.Key);
					return true;
				}
			}
			return false;
		}

		private bool TryHolster(ReferenceHub hub, ItemType parsedItem)
		{
			if (hub.inventory.CurItem.SerialNumber == 0)
			{
				return false;
			}
			hub.inventory.ServerSelectItem(0);
			return false;
		}
	}
}
