using System;
using System.Collections.Generic;
using CommandSystem;
using UnityEngine;
using Utils;

namespace Christmas.Scp2536
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class TeleportTreeCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "tptree";

		public string[] Aliases { get; } = new string[1] { "teleporttree" };

		public string Description { get; } = "Carpincho.";

		public string[] Usage { get; } = new string[1] { "%player%" };

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
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null)
			{
				response = "Cannot find player! Try using the player ID!";
				return false;
			}
			Vector3 position = list[0].transform.position;
			Scp2536Controller.Singleton.RpcMoveTree(position, Quaternion.identity, 0);
			Scp2536Controller.Singleton.GiftController.ServerPrepareGifts();
			return true;
		}
	}
}
