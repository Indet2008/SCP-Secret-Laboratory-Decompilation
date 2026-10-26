using System;

namespace CommandSystem.Commands.RemoteAdmin.Dms
{
	[CommandHandler(typeof(DmsCommand))]
	public class SetCommand : ICommand
	{
		public string Command => "set";

		public string[] Aliases => new string[1] { "s" };

		public string Description => "Sets the current value of the Deadman's Switch timer.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			if (DeadmanSwitch.IsSequenceActive)
			{
				response = "DMS is already in progress.";
				return false;
			}
			if (arguments.Count == 0 || !float.TryParse(arguments.At(0), out var result))
			{
				response = "You must input a valid number.";
				return false;
			}
			DeadmanSwitch.CountdownTimeLeft = result;
			response = $"DMS will now trigger in {DeadmanSwitch.CountdownTimeLeft:F2}s.";
			return true;
		}
	}
}
