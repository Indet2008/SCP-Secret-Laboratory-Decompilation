using System;
using System.Collections.Generic;
using System.Linq;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SetGravityCommand : ICommand, IUsageProvider
	{
		public string Command => "setgravity";

		public string[] Aliases => Array.Empty<string>();

		public string Description => "Sets player(s) gravity to specified value";

		public string[] Usage => new string[4] { "%player%", "X", "Y", "Z" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count < 4)
			{
				response = "To execute this command provide 4 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list.Count == 0)
			{
				response = "To execute this command provide 4 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(1), out var result))
			{
				response = "Unable to parse " + arguments.ElementAt(1) + " to a decimal number for X value";
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(2), out var result2))
			{
				response = "Unable to parse " + arguments.ElementAt(2) + " to a decimal number for Y value";
				return false;
			}
			if (!float.TryParse(arguments.ElementAt(3), out var result3))
			{
				response = "Unable to parse " + arguments.ElementAt(3) + " to a decimal number for Z value";
				return false;
			}
			Vector3 vector = new Vector3(result, result2, result3);
			foreach (ReferenceHub item in list)
			{
				FpcGravityController.ServerSetGravity(item, vector);
			}
			response = string.Format("Set gravity of {0} player{1} to {2}", list.Count, (list.Count != 1) ? "s" : "", vector);
			return true;
		}
	}
}
