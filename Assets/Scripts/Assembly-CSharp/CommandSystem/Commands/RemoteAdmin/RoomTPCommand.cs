using System;
using System.Collections.Generic;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using RemoteAdmin;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RoomTPCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "roomtp";

		public string[] Aliases { get; } = new string[2] { "rtp", "ridtp" };

		public string Description { get; } = "Teleports you to a room.";

		public string[] Usage { get; } = new string[1] { "RoomID" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is PlayerCommandSender))
			{
				response = "Only players can run this command.";
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!Enum.TryParse<RoomName>(arguments.At(0), ignoreCase: true, out var result) || result == RoomName.Unnamed)
			{
				response = "Room not defined.";
				return false;
			}
			List<Vector3> list = ListPool<Vector3>.Shared.Rent();
			foreach (RoomIdentifier rid in RoomIdentifier.AllRoomIdentifiers)
			{
				if (rid.Name == result)
				{
					Vector3 position = rid.transform.position;
					if (!DoorVariant.AllDoors.TryGetFirst((DoorVariant x) => x.Rooms.Contains(rid) && x is BreakableDoor breakableDoor && !breakableDoor.IgnoreRemoteAdmin, out var first))
					{
						list.Add(position + Vector3.up);
						continue;
					}
					Vector3 position2 = first.transform.position;
					Vector3 vector = (position - position2).NormalizeIgnoreY();
					list.Add(position2 + vector + Vector3.up);
				}
			}
			if (list.Count == 0)
			{
				ListPool<Vector3>.Shared.Return(list);
				response = "Room couldn't be found.";
				return false;
			}
			Vector3 position3 = list[UnityEngine.Random.Range(0, list.Count)];
			ListPool<Vector3>.Shared.Return(list);
			if (!(sender is PlayerCommandSender playerCommandSender) || !playerCommandSender.ReferenceHub.TryOverridePosition(position3))
			{
				response = "Your current character role does not support this operation.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " teleported themself to room " + arguments.At(0) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "You have been teleported.";
			return true;
		}
	}
}
