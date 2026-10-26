using System;
using System.Collections.Generic;
using System.Text;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using NorthwoodLib.Pools;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(ElevatorCommand))]
	public class ElevatorLockCommand : ICommand
	{
		private const int AllLevels = -1;

		private const int DynamicLock = -2;

		public string Command { get; } = "lock";

		public string[] Aliases { get; } = new string[2] { "l", "lck" };

		public string Description { get; } = "Locks an elevator.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			switch (arguments.Count)
			{
			case 1:
				return TrySetLock(arguments.At(0), locked: true, out response, sender, -1);
			case 2:
			{
				if (arguments.At(1).Equals("d", StringComparison.OrdinalIgnoreCase) || arguments.At(1).Equals("dynamic", StringComparison.OrdinalIgnoreCase))
				{
					return TrySetLock(arguments.At(0), locked: true, out response, sender, -2);
				}
				if (int.TryParse(arguments.At(1), out var result) && result >= 0)
				{
					return TrySetLock(arguments.At(0), locked: true, out response, sender, result);
				}
				break;
			}
			}
			response = "Syntax error: elevator lock <Elevator ID / \"all\"> <level / \"dynamic\" (optional)>";
			return false;
		}

		internal static bool TrySetLock(string elevatorId, bool locked, out string response, ICommandSender sender, int level)
		{
			if (!elevatorId.Equals("all", StringComparison.OrdinalIgnoreCase) && !elevatorId.Equals("*", StringComparison.Ordinal))
			{
				if (!ElevatorCommand.TryParseGroup(elevatorId, out var group))
				{
					response = "Elevator \"" + elevatorId + "\" not found.";
					return false;
				}
				if (!SetLock(locked, sender, group, level))
				{
					response = $"Could not update lock status for elevator \"{group}\".";
					return false;
				}
				response = string.Format("Elevator \"{0}\" has been {1}.", group, locked ? "locked" : "unlocked");
				return true;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			bool result = true;
			try
			{
				ElevatorGroup[] values = EnumUtils<ElevatorGroup>.Values;
				foreach (ElevatorGroup elevatorGroup in values)
				{
					if (SetLock(locked, sender, elevatorGroup, level))
					{
						stringBuilder.AppendFormat("Elevator \"{0}\" has been {1}.\n", elevatorGroup, locked ? "locked" : "unlocked");
						continue;
					}
					result = false;
					stringBuilder.AppendFormat("Could not update lock status for elevator \"{0}\".\n", elevatorGroup);
				}
				response = stringBuilder.ToString();
				return result;
			}
			finally
			{
				StringBuilderPool.Shared.Return(stringBuilder);
			}
		}

		private static bool SetLock(bool forceLock, ICommandSender sender, ElevatorGroup elevatorGroup, int level)
		{
			if (level < -2)
			{
				return false;
			}
			if (!ElevatorChamber.TryGetChamber(elevatorGroup, out var chamber))
			{
				return false;
			}
			List<ElevatorDoor> doorsForGroup = ElevatorDoor.GetDoorsForGroup(elevatorGroup);
			switch (level)
			{
			case -1:
				return SetLockAll(doorsForGroup, forceLock, sender, elevatorGroup, chamber);
			case -2:
				if (chamber.DynamicAdminLock)
				{
					return false;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} enabled dynamic lock for elevator {elevatorGroup}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				chamber.DynamicAdminLock = true;
				return true;
			default:
			{
				if (doorsForGroup.Count <= level)
				{
					return false;
				}
				ElevatorDoor elevatorDoor = doorsForGroup[level];
				if (((DoorLockReason)elevatorDoor.ActiveLocks).HasFlagFast(DoorLockReason.AdminCommand) == forceLock)
				{
					return true;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} {1} level {2} of elevator {3}.", sender.LogName, forceLock ? "locked" : "unlocked", level, elevatorGroup), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				if (chamber.DynamicAdminLock)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} disabled dynamic lock for elevator {elevatorGroup}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					chamber.DynamicAdminLock = false;
				}
				if (forceLock)
				{
					elevatorDoor.NetworkActiveLocks = (ushort)(elevatorDoor.ActiveLocks | 8);
				}
				else
				{
					elevatorDoor.NetworkActiveLocks = (ushort)(elevatorDoor.ActiveLocks & 0xFFF7);
				}
				return true;
			}
			}
		}

		private static bool SetLockAll(List<ElevatorDoor> list, bool isLocking, ICommandSender sender, ElevatorGroup elevatorGroup, ElevatorChamber targetChamber)
		{
			if (targetChamber.DynamicAdminLock)
			{
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} disabled dynamic lock for elevator {elevatorGroup}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				targetChamber.DynamicAdminLock = false;
				if (!isLocking)
				{
					return true;
				}
			}
			if (isLocking && targetChamber.ActiveLocksAllDoors.HasFlagFast(DoorLockReason.AdminCommand))
			{
				return true;
			}
			if (!isLocking && !targetChamber.ActiveLocksAnyDoors.HasFlagFast(DoorLockReason.AdminCommand))
			{
				return true;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} {1} elevator {2}.", sender.LogName, isLocking ? "locked" : "unlocked", elevatorGroup), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			foreach (ElevatorDoor item in list)
			{
				if (isLocking)
				{
					item.NetworkActiveLocks = (ushort)(item.ActiveLocks | 8);
				}
				else
				{
					item.NetworkActiveLocks = (ushort)(item.ActiveLocks & 0xFFF7);
				}
			}
			return true;
		}
	}
}
