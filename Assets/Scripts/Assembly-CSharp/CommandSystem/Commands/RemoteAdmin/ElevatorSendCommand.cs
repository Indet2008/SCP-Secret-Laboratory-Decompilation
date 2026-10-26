using System;
using System.Collections.Generic;
using System.Text;
using Interactables.Interobjects;
using NorthwoodLib.Pools;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(ElevatorCommand))]
	public class ElevatorSendCommand : ICommand
	{
		public string Command { get; } = "send";

		public string[] Aliases { get; } = new string[2] { "s", "snd" };

		public string Description { get; } = "Sends an elevator.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 1 || arguments.Count > 2)
			{
				response = "Syntax error: elevator send <Elevator ID / \"all\"> [level]";
				return false;
			}
			string text = arguments.At(0);
			bool flag = text.Equals("all", StringComparison.OrdinalIgnoreCase) || text.Equals("*", StringComparison.OrdinalIgnoreCase);
			int result = -1;
			if (arguments.Count > 1 && (!int.TryParse(arguments.At(1), out result) || result < 0))
			{
				response = "Level must be a nonnegative integer.";
				return false;
			}
			if (!flag)
			{
				if (!ElevatorCommand.TryParseGroup(text, out var group))
				{
					response = "Elevator \"" + text + "\" not found.";
					return false;
				}
				return SendElevator(group, result, out response, sender);
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			bool result2 = true;
			try
			{
				ElevatorGroup[] values = EnumUtils<ElevatorGroup>.Values;
				for (int i = 0; i < values.Length; i++)
				{
					if (!SendElevator(values[i], -1, out var response2, sender))
					{
						result2 = false;
					}
					stringBuilder.AppendFormat("{0}\n", response2);
				}
				response = stringBuilder.ToString();
				return result2;
			}
			finally
			{
				StringBuilderPool.Shared.Return(stringBuilder);
			}
		}

		private static bool SendElevator(ElevatorGroup group, int level, out string response, ICommandSender sender)
		{
			List<ElevatorDoor> doorsForGroup = ElevatorDoor.GetDoorsForGroup(group);
			if (doorsForGroup.Count == 0)
			{
				response = $"No doors for \"{group}\" could not be found in the Facility.";
				return false;
			}
			if (!ElevatorChamber.TryGetChamber(group, out var chamber))
			{
				response = $"Chamber for elevator \"{group}\" is not spawned.";
				return false;
			}
			if (level == -1)
			{
				level = chamber.NextLevel;
			}
			else if (level >= doorsForGroup.Count)
			{
				response = $"Elevator \"{group}\" does not have a level {level}.";
				return false;
			}
			chamber.ServerSetDestination(level, allowQueueing: true);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{sender.LogName} sent elevator {group} to level {level}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = $"Elevator \"{group}\" has been sent to level {level}.";
			return true;
		}
	}
}
