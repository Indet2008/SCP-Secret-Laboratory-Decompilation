using System;

namespace CommandSystem.Commands.RemoteAdmin.Warhead
{
	[CommandHandler(typeof(WarheadCommand))]
	public class SetTimeCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "settime";

		public string[] Aliases { get; } = new string[2] { "time", "st" };

		public string Description { get; } = "Sets the remaining time to detonation.";

		public string[] Usage { get; } = new string[1] { "time (seconds)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.WarheadEvents, out response))
			{
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!float.TryParse(arguments.At(0), out var result))
			{
				response = "The specified time must be a valid number.";
				return false;
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " set remaining time to warhead detonation to " + result + ((Math.Abs(result - 1f) < 0.0001f) ? " second." : " seconds."), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			AlphaWarheadController.Singleton.ForceTime(result);
			response = "Time remaining to detonation set to " + result + ((Math.Abs(result - 1f) < 0.0001f) ? " second." : " seconds.");
			return true;
		}
	}
}
