using System;

namespace CommandSystem.Commands.RemoteAdmin.Dms
{
	[CommandHandler(typeof(DmsCommand))]
	public class GetCommand : ICommand
	{
		public string Command => "get";

		public string[] Aliases => new string[1] { "g" };

		public string Description => "Gets the current value of the Deadman's Switch timer.";

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
			response = $"{DeadmanSwitch.CountdownTimeLeft:F2}s till DMS triggers.";
			return true;
		}
	}
}
