using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RoundLockCommand : ICommand
	{
		public string Command { get; } = "roundlock";

		public string[] Aliases { get; } = new string[2] { "rl", "rlock" };

		public string Description { get; } = "Locks or unlocks the current round (prevents it from ending).";

		public string[] Usage { get; } = new string[1] { "enable/disable (Leave blank for toggle)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			bool flag = !RoundSummary.RoundLock;
			if (arguments.Count >= 1)
			{
				string[] newargs = new string[1] { arguments.Array[1] };
				if (Misc.TryCommandModeFromArgs(ref newargs, out var mode))
				{
					flag = mode switch
					{
						Misc.CommandOperationMode.Enable => true, 
						Misc.CommandOperationMode.Disable => false, 
						_ => flag, 
					};
				}
			}
			RoundSummary.RoundLock = flag;
			if (flag)
			{
				RoundSummary.singleton.CancelRoundEnding();
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + (RoundSummary.RoundLock ? " enabled " : " disabled ") + "round lock.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Round lock " + (RoundSummary.RoundLock ? "enabled!" : "disabled!");
			return true;
		}
	}
}
