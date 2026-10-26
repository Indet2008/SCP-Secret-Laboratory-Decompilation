using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using NorthwoodLib.Pools;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(ElevatorCommand))]
	public class ElevatorListCommand : ICommand
	{
		public string Command { get; } = "list";

		public string[] Aliases { get; } = new string[6] { "ls", "lst", "elevators", "lifts", "els", "elevs" };

		public string Description { get; } = "Lists all elevators.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			bool getLevels = arguments.Count > 0 && (arguments.At(0).Equals("detailed", StringComparison.OrdinalIgnoreCase) || arguments.At(0).Equals("d", StringComparison.OrdinalIgnoreCase) || arguments.At(0).Equals("det", StringComparison.OrdinalIgnoreCase));
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append("Detected the following elevators:");
			ElevatorGroup[] values = EnumUtils<ElevatorGroup>.Values;
			foreach (ElevatorGroup num in values)
			{
				stringBuilder.Append("\n- ");
				AppendElevatorData(num, getLevels, stringBuilder);
			}
			response = stringBuilder.ToString();
			StringBuilderPool.Shared.Return(stringBuilder);
			return true;
		}

		private static void AppendElevatorData(ElevatorGroup group, bool getLevels, StringBuilder sb)
		{
			if (!ElevatorChamber.TryGetChamber(group, out var chamber))
			{
				sb.AppendFormat("Elevator \"{0}\" does not exist.", group);
				return;
			}
			List<ElevatorDoor> doorsForGroup = ElevatorDoor.GetDoorsForGroup(group);
			if (doorsForGroup.Count == 0)
			{
				sb.AppendFormat("Elevator \"{0}\" has 0 levels.", group);
				return;
			}
			sb.AppendFormat("Elevator \"{0}\" has {1} levels. Currently ", group, doorsForGroup.Count);
			ElevatorDoor elevatorDoor = doorsForGroup.FirstOrDefault((ElevatorDoor x) => x.TargetState);
			if (elevatorDoor == null)
			{
				sb.Append("in transit");
			}
			else
			{
				sb.AppendFormat("at level {0}", doorsForGroup.IndexOf(elevatorDoor));
			}
			bool flag = false;
			if (chamber.DynamicAdminLock)
			{
				sb.Append(" and dynamic administrative lock is active");
			}
			else if (chamber.ActiveLocksAllDoors.HasFlagFast(DoorLockReason.AdminCommand))
			{
				sb.Append(" and administratively locked");
				flag = true;
			}
			else if (chamber.ActiveLocksAnyDoors.HasFlagFast(DoorLockReason.AdminCommand))
			{
				sb.Append(" and PARTIALLY administratively locked");
			}
			else if (chamber.ActiveLocksAllDoors != DoorLockReason.None)
			{
				sb.Append(" and locked");
				flag = true;
			}
			else if (chamber.ActiveLocksAnyDoors != DoorLockReason.None)
			{
				sb.Append(" and PARTIALLY locked");
			}
			sb.Append(".");
			if (!getLevels)
			{
				return;
			}
			for (int num = 0; num < doorsForGroup.Count; num++)
			{
				Vector3 position = doorsForGroup[num].transform.position;
				sb.AppendFormat("\n-   Level {0} at height {1}", num, Mathf.Round(position.y));
				if (RoomIdentifier.RoomsByCoords.TryGetValue(RoomUtils.PositionToCoords(position), out var value))
				{
					sb.AppendFormat(" (room: \"{0}\")", value.Name);
				}
				if (!((doorsForGroup[num].ActiveLocks == 0) | flag))
				{
					sb.Append(((DoorLockReason)doorsForGroup[num].ActiveLocks).HasFlagFast(DoorLockReason.AdminCommand) ? " (administratively locked)" : " (locked)");
				}
			}
			sb.Append('\n');
		}
	}
}
