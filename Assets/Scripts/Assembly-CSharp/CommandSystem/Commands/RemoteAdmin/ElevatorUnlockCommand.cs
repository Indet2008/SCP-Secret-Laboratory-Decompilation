using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(ElevatorCommand))]
	public class ElevatorUnlockCommand : ICommand
	{
		public string Command { get; } = "unlock";

		public string[] Aliases { get; } = new string[3] { "u", "ul", "ulck" };

		public string Description { get; } = "Unlocks an elevator.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			switch (arguments.Count)
			{
			case 1:
				return ElevatorLockCommand.TrySetLock(arguments.At(0), locked: false, out response, sender, -1);
			case 2:
			{
				if (int.TryParse(arguments.At(1), out var result) && result >= 0)
				{
					return ElevatorLockCommand.TrySetLock(arguments.At(0), locked: false, out response, sender, result);
				}
				break;
			}
			}
			response = "Syntax error: elevator unlock <Elevator ID / \"all\"> <level (optional)>";
			return false;
		}
	}
}
