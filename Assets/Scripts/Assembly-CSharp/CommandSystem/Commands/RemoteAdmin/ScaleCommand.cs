using System;
using System.Collections.Generic;
using System.Linq;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ScaleCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "scalechange";

		public string[] Aliases { get; } = new string[1] { "changescale" };

		public string Description { get; } = "Changes scale of specified player(s). Affects hitboxes.";

		public string[] Usage { get; } = new string[4] { "%player%", "X", "Y", "Z" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count < 4)
			{
				response = "Please enter 4 arguments.";
				return true;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list.Count == 0)
			{
				response = "No player(s) found";
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(1), out var result))
			{
				response = "Unable to parse " + arguments.ElementAt(1) + " for X scale";
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(2), out var result2))
			{
				response = "Unable to parse " + arguments.ElementAt(2) + " for Y scale";
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(3), out var result3))
			{
				response = "Unable to parse " + arguments.ElementAt(3) + " for Z scale";
				return false;
			}
			Vector3 scale = new Vector3(result, result2, result3);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (item.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					fpcRole.FpcModule.Motor.ScaleController.Scale = scale;
					num++;
				}
			}
			response = string.Format("Sucessfully scaled {0}/{1} player{2}", num, list.Count, (list.Count > 1) ? "s" : string.Empty);
			return true;
		}
	}
}
