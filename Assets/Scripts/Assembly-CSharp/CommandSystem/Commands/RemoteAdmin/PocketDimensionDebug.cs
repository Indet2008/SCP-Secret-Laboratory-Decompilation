using System;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class PocketDimensionDebug : ICommand
	{
		public string Command { get; } = "pddebug";

		public string[] Aliases { get; } = new string[1] { "106debug" };

		public string Description { get; } = "If true SCP-106s Pocket Dimension has 100% chance for you to escape.";

		public string[] Usage { get; } = new string[1] { "enable/disable (Leave blank for toggle)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.RoundEvents, out response))
			{
				return false;
			}
			if (arguments.Count >= 1)
			{
				string[] newargs = new string[1] { arguments.Array[1] };
				if (Misc.TryCommandModeFromArgs(ref newargs, out var mode))
				{
					switch (mode)
					{
					case Misc.CommandOperationMode.Enable:
						PocketDimensionTeleport.DebugBool = true;
						break;
					case Misc.CommandOperationMode.Disable:
						PocketDimensionTeleport.DebugBool = false;
						break;
					case Misc.CommandOperationMode.Toggle:
						PocketDimensionTeleport.DebugBool = !PocketDimensionTeleport.DebugBool;
						break;
					}
					response = "Pocket Dimension debug set to " + (PocketDimensionTeleport.DebugBool ? "enabled!" : "disabled!");
					return true;
				}
			}
			PocketDimensionTeleport.DebugBool = !PocketDimensionTeleport.DebugBool;
			response = "Pocket Dimension debug is now " + (PocketDimensionTeleport.DebugBool ? "enabled!" : "disabled!");
			return true;
		}
	}
}
