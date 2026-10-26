using System;
using System.Collections.Generic;
using System.Linq;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DoorsListCommand : ICommand
	{
		public string Command { get; } = "doorslist";

		public string[] Aliases { get; } = new string[2] { "doors", "dl" };

		public string Description { get; } = "Lists all valid door names.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			string text = "List of named doors in the facility:\n";
			List<string> list = (from item in DoorNametagExtension.NamedDoors.Values.ToArray()
				where !string.IsNullOrEmpty(item.GetName)
				select item.GetName + " - " + (item.TargetDoor.TargetState ? "<color=green>OPENED</color>" : "<color=orange>CLOSED</color>") + ((item.TargetDoor.ActiveLocks > 0) ? " <color=red>[LOCKED]</color>" : "") + (((item.TargetDoor is BasicDoor basicDoor && (int)basicDoor.RequiredPermissions.RequiredPermissions > 0) || (item.TargetDoor is CheckpointDoor checkpointDoor && (int)checkpointDoor.RequiredPermissions.RequiredPermissions > 0)) ? " <color=blue>[CARD REQUIRED]</color>" : "")).ToList();
			list.Sort();
			text += list.Aggregate((string current, string adding) => current + "\n" + adding);
			response = text;
			return true;
		}
	}
}
