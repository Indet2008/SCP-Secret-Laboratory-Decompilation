using System;
using System.Collections.Generic;
using System.Text;
using CommandSystem.Commands.RemoteAdmin.Doors;
using Interactables.Interobjects;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(ElevatorCommand))]
	public class ElevatorTeleportCommand : ICommand
	{
		private static float PositionOffset = 0.8f;

		public string Command { get; } = "teleport";

		public string[] Aliases { get; } = new string[4] { "t", "tp", "goto", "tele" };

		public string Description { get; } = "Teleports to an elevator.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "Syntax error: elevator teleport <Elevator ID> <Target Players> [\"inside\"/level ID/\"outside\"]";
				return false;
			}
			if (!ElevatorCommand.TryParseGroup(arguments.At(0), out var group))
			{
				response = "Elevator \"" + arguments.At(0) + "\" not found.";
				return false;
			}
			if (!ElevatorChamber.TryGetChamber(group, out var chamber))
			{
				response = $"Elevator \"{group}\" could not be found in the Facility.";
				return false;
			}
			List<ElevatorDoor> doorsForGroup = ElevatorDoor.GetDoorsForGroup(group);
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 1, out var newargs);
			if (list == null || list.Count == 0)
			{
				response = "No players have been selected.";
				return false;
			}
			Vector3 position = chamber.transform.position + Vector3.up * PositionOffset;
			string text = "inside";
			if (newargs != null && newargs.Length > 0)
			{
				switch (newargs[0].ToLowerInvariant())
				{
				case "o":
				case "out":
				case "outside":
					position = DoorTPCommand.EnsurePositionSafety(chamber.DestinationDoor.transform);
					text = "outside";
					break;
				default:
				{
					if (!int.TryParse(newargs[0], out var result))
					{
						response = "Invalid level ID: " + newargs[0];
						return false;
					}
					if (result < 0 || result >= doorsForGroup.Count)
					{
						response = "Selected elevator doesn't have level " + newargs[0] + ".";
						return false;
					}
					position = DoorTPCommand.EnsurePositionSafety(doorsForGroup[result].transform);
					text = $"level {result}";
					break;
				}
				case "i":
				case "in":
				case "ins":
				case "inside":
					break;
				}
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (item.TryOverridePosition(position))
				{
					if (num != 0)
					{
						stringBuilder.Append(", ");
					}
					stringBuilder.Append(item.LoggedNameFromRefHub());
					num++;
				}
			}
			if (num > 0)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} teleported player{1}{2} to elevator {3} ({4}).", sender.LogName, (num == 1) ? " " : "s ", stringBuilder, group.ToString(), text), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			StringBuilderPool.Shared.Return(stringBuilder);
			response = string.Format("Done! The request affected {0} player{1}", num, (num == 1) ? "!" : "s!");
			return true;
		}
	}
}
