using System;
using System.Collections.Generic;
using System.Linq;
using PlayerRoles.Spectating;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SetHiddenSpectatableCommand : ICommand, IUsageProvider
	{
		public string Command => "setspectatable";

		public string[] Aliases => new string[3] { "setspectvis", "hidespectator", "hidespec" };

		public string Description => "Forcefully hides a player from a spectator list";

		public string[] Usage => new string[2] { "%player%", "Hidden (True/False)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Vanish))
			{
				response = "You don't have enough permissions to run this command!";
				return false;
			}
			if (arguments.Count != 2)
			{
				response = "Please enter all required arguments!";
				return false;
			}
			if (!bool.TryParse(arguments.ElementAt(1), out var result))
			{
				response = "Please provide visibility option as true/false";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId/Name array processing.";
				return false;
			}
			if (newargs == null)
			{
				response = "An error occured while processing this command.\nUsage: " + this.DisplayCommandUsage();
				return false;
			}
			foreach (ReferenceHub item in list)
			{
				SpectatableVisibilityManager.SetHidden(item, result);
			}
			response = $"Set new hidden state of {list.Count} players to {result}";
			return true;
		}
	}
}
