using System;
using System.Collections.Generic;
using CommandSystem;
using Utils;

namespace Christmas.Scp2536
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class GiftCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "gift";

		public string[] Aliases { get; } = new string[1] { "addgift" };

		public string Description { get; } = "Grant a gift to a player.";

		public string[] Usage { get; } = new string[2] { "%player%", "Gift name (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.GivingItems, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (list == null)
			{
				response = "Cannot find player! Try using the player ID!";
				return false;
			}
			Scp2536GiftBase giftBase = null;
			bool flag = newargs.Length != 0 && TryFetchGift(newargs[0].ToUpper(), out giftBase);
			int num = 0;
			bool flag2 = false;
			foreach (ReferenceHub item in list)
			{
				num++;
				if (flag)
				{
					flag2 = giftBase.CanBeGranted(item);
					giftBase.ServerGrant(item);
				}
				else
				{
					Scp2536Controller.Singleton.GiftController.ServerGrantRandomGift(item);
				}
			}
			response = "Gift granted!";
			if (flag2 && num > 1)
			{
				response += " Forcefully, as the target didn't meet the expected conditions.";
			}
			return true;
		}

		private bool TryFetchGift(string input, out Scp2536GiftBase giftBase)
		{
			foreach (Scp2536GiftBase gift in Scp2536GiftController.Gifts)
			{
				if (gift.GetType().Name.ToUpper().Contains(input))
				{
					giftBase = gift;
					return true;
				}
			}
			giftBase = null;
			return false;
		}
	}
}
