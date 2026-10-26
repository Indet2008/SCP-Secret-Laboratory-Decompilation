using System;
using CentralAuth;
using Mirror;
using Utils.NonAllocLINQ;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class IdleCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "idle";

		public string[] Aliases { get; } = new string[1] { "i" };

		public string Description { get; } = "Controls server idle mode";

		public string[] Usage { get; } = new string[1] { "Enable/Disable/ForceEnable (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!ServerStatic.IsDedicated)
			{
				response = "This command can only be executed on a dedicated server.";
				return false;
			}
			if (!NetworkServer.active)
			{
				response = "This command can only be used on a server.";
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "Server is " + (IdleMode.IdleModeActive ? string.Empty : "**NOT** ") + "currently in idle mode.";
				return true;
			}
			response = "";
			switch (arguments.At(0).ToUpperInvariant())
			{
			case "E":
			case "-E":
			case "ENABLE":
				if (IdleMode.IdleModeActive)
				{
					response = "Server is already in the idle mode.";
					return false;
				}
				if (ReferenceHub.AllHubs.Any((ReferenceHub x) => x.Mode == ClientInstanceMode.ReadyClient))
				{
					response = "You can't enable the idle mode when players are connected to the server.";
					return false;
				}
				if (!(sender is ServerConsoleSender))
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " enabled the idle mode.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					response = "Idle mode enabled.";
				}
				IdleMode.SetIdleMode(state: true);
				return true;
			case "F":
			case "-F":
			case "FORCE":
				if (IdleMode.IdleModeActive)
				{
					response = "Server is already in the idle mode.";
					return false;
				}
				if (!(sender is ServerConsoleSender))
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " force enabled the idle mode.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					response = "Idle mode force enabled.";
				}
				IdleMode.SetIdleMode(state: true);
				return true;
			case "D":
			case "-D":
			case "DISABLE":
				if (!IdleMode.IdleModeActive)
				{
					response = "Server isn't in idle mode.";
					return false;
				}
				if (!(sender is ServerConsoleSender))
				{
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " disabled the idle mode.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					response = "Idle mode disabled";
				}
				IdleMode.SetIdleMode(state: false);
				return true;
			default:
				response = "Unknown subcommand.\nUsage: " + Command + " " + this.DisplayCommandUsage() + ".";
				return false;
			}
		}
	}
}
