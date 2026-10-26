using System;
using System.Collections.Generic;
using RemoteAdmin;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Dummies
{
	[CommandHandler(typeof(DummiesCommand))]
	public class FollowDummyCommand : ICommand
	{
		public string Command { get; } = "follow";

		public string[] Aliases { get; } = new string[2] { "f", "trail" };

		public string Description { get; } = "Makes a dummy un/follow you.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "This command can only be executed by a physical player.";
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "You must specify a dummy to follow.";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId or name array processing.";
				return false;
			}
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null) && item.IsDummy)
				{
					if (item.TryGetComponent<PlayerFollower>(out var component))
					{
						UnityEngine.Object.Destroy(component);
					}
					else
					{
						item.gameObject.AddComponent<PlayerFollower>().Init(playerCommandSender.ReferenceHub);
					}
					num++;
				}
			}
			response = string.Format("Done! The request affected {0} dumm{1}", num, (num == 1) ? "y!" : "ies!");
			return true;
		}
	}
}
