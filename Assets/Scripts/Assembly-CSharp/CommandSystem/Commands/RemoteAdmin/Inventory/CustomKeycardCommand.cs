using System;
using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Keycards;
using NorthwoodLib.Pools;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Inventory
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CustomKeycardCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "customkeycard";

		public string[] Aliases { get; } = new string[1] { "ckeycard" };

		public string Description { get; } = "Give player(s) a custom keycard.";

		public string[] Usage { get; } = new string[2] { "%player%", "KeycardType" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.GivingItems, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "Please provide players to give the keycard to.";
				return false;
			}
			if (!TryParseKeycard(arguments, out var keycard))
			{
				response = "Please choose one of the following options as your second argument:";
				foreach (KeyValuePair<ItemType, ItemBase> availableItem in InventoryItemLoader.AvailableItems)
				{
					if (availableItem.Value is KeycardItem { Customizable: not false })
					{
						response = response + " " + availableItem.Key;
					}
				}
				response += ".";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			int num = 0;
			string text = "";
			DetailBase[] details = keycard.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is ICustomizableDetail { CommandArguments: var commandArguments })
				{
					foreach (string text2 in commandArguments)
					{
						text = text + "\n- " + text2;
						num++;
					}
				}
			}
			if (newargs.Length + 1 < num)
			{
				ListPool<ReferenceHub>.Shared.Return(list);
				response = $"{keycard.ItemTypeId} requires: {text}";
				return false;
			}
			int num2 = 0;
			details = keycard.Details;
			foreach (DetailBase detailBase in details)
			{
				if (detailBase is ICustomizableDetail customizableDetail2)
				{
					int num3 = customizableDetail2.CommandArguments.Length;
					try
					{
						ArraySegment<string> args = new ArraySegment<string>(newargs, num2 + 1, num3);
						customizableDetail2.ParseArguments(args);
					}
					catch (Exception ex)
					{
						ListPool<ReferenceHub>.Shared.Return(list);
						response = "Arguments failed to parse at: " + detailBase.GetType().Name + ".\n" + ex.Message;
						return false;
					}
					num2 += num3;
				}
			}
			int num4 = 0;
			int num5 = 0;
			string arg = string.Empty;
			foreach (ReferenceHub item in list)
			{
				try
				{
					AddItem(item, sender, keycard.ItemTypeId);
					num5++;
				}
				catch (Exception ex2)
				{
					num4++;
					arg = ex2.Message;
				}
			}
			response = ((num4 == 0) ? string.Format("Done! The request affected {0} player{1}", num5, (num5 == 1) ? "!" : "s!") : $"Failed to execute the command! Failures: {num4}\nLast error log:\n{arg}");
			ListPool<ReferenceHub>.Shared.Return(list);
			return true;
		}

		private static bool TryParseKeycard(ArraySegment<string> args, out KeycardItem keycard)
		{
			if (args.Count < 2)
			{
				keycard = null;
				return false;
			}
			if (!Enum.TryParse<ItemType>(args.At(1), ignoreCase: true, out var result))
			{
				keycard = null;
				return false;
			}
			if (result.TryGetTemplate<KeycardItem>(out keycard))
			{
				return keycard.Customizable;
			}
			return false;
		}

		private static void AddItem(ReferenceHub ply, ICommandSender sender, ItemType id)
		{
			ItemBase itemBase = ply.inventory.ServerAddItem(id, ItemAddReason.AdminCommand, 0);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} created {id} and gave it to {ply.LoggedNameFromRefHub()}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			if (itemBase == null)
			{
				throw new NullReferenceException($"Could not add {id}. Inventory is full or the item is not defined.");
			}
		}
	}
}
