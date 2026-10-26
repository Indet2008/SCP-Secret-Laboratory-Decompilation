using System;
using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Usables.Scp330;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class AddCandyCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "addcandy";

		public string[] Aliases { get; } = new string[2] { "candy", "trickortreat" };

		public string Description { get; } = "Adds specific candies to player(s) bags. If a player does not have a bag, it will create a new one with a random candy.";

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
					response = "Could not process provided arguments.";
					return false;
				}
				string text = (newargs[0].ToUpper()[0] + newargs[0].ToLower()).Remove(1, 1);
				if (!Enum.TryParse<CandyKindID>(text, out var result))
				{
					response = newargs[0] + " could not be parsed as candy type";
					return false;
				}
				if (!Enum.IsDefined(typeof(CandyKindID), result) || result == CandyKindID.None)
				{
					response = text + " isn't a valid candy type!";
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
							ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} gave {result} candy to {item.LoggedNameFromRefHub()}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
							item.GrantCandy(result, ItemAddReason.AdminCommand);
							num2++;
						}
						catch (Exception ex)
						{
							num++;
							arg = ex.Message;
						}
					}
				}
				response = ((num == 0) ? string.Format("Done! The request affected {0} player{1}", num2, (num2 == 1) ? "!" : "s!") : $"Failed to execute the command! Failures: {num}\nLast error log:\n{arg}");
				return true;
			}
			response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
			return false;
		}
	}
}
