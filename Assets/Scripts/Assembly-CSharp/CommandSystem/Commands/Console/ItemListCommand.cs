using System;
using System.Collections.Generic;
using System.Text;
using InventorySystem;
using InventorySystem.Items;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class ItemListCommand : ICommand
	{
		public string Command { get; } = "itemlist";

		public string[] Aliases { get; }

		public string Description { get; } = "Displays a list of items.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("<size=25>Item List:</size>");
			foreach (KeyValuePair<ItemType, ItemBase> availableItem in InventoryItemLoader.AvailableItems)
			{
				stringBuilder.AppendLine($"ITEM#{(int)availableItem.Key:000} : {availableItem.Key}");
			}
			response = stringBuilder.ToString();
			return true;
		}
	}
}
