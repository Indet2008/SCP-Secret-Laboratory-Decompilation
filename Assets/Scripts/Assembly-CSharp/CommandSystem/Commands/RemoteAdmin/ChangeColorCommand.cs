using System;
using MapGeneration;
using PlayerRoles;
using RemoteAdmin;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ChangeColorCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "changecolor";

		public string[] Aliases { get; } = new string[2] { "changec", "ccolor" };

		public string Description { get; } = "Changes the color of the lights in the room you are currently in.";

		public string[] Usage { get; } = new string[3] { "r", "g", "b" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.IsAlive())
			{
				response = "You need to be alive to run this command!";
				return false;
			}
			if (!playerCommandSender.ReferenceHub.TryGetCurrentRoom(out var room))
			{
				response = "You are not in a a room!";
				return false;
			}
			RoomLightController closestLightController = room.GetClosestLightController(playerCommandSender.ReferenceHub);
			if (closestLightController == null)
			{
				response = "You are not in a room that supports changing lights color!";
				return false;
			}
			if (arguments.Count == 0)
			{
				closestLightController.NetworkOverrideColor = Color.clear;
				response = "Done! Reset warhead lights to default color.";
				return true;
			}
			if (arguments.Count < 3)
			{
				response = "Type 3 numbers, eg: 255 255 255";
				return false;
			}
			if (!float.TryParse(arguments.At(0), out var result) || !float.TryParse(arguments.At(1), out var result2) || !float.TryParse(arguments.At(2), out var result3))
			{
				response = "Invalid input. Type 3 numbers, eg: 255 255 255";
				return false;
			}
			closestLightController.NetworkOverrideColor = new Color(result / 255f, result2 / 255f, result3 / 255f);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} changed color of lights in a room to {result} {result2} {result3} .", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Done!";
			return true;
		}
	}
}
