using System;
using RemoteAdmin;

namespace CommandSystem.Commands.Dot.Overwatch
{
	[CommandHandler(typeof(ClientCommandHandler))]
	public class OverwatchCommand : ParentCommand
	{
		public override string Command { get; } = "overwatch";

		public override string[] Aliases { get; } = new string[2] { "ovr", "ow" };

		public override string Description { get; } = "Toggle overwatch mode.";

		public static OverwatchCommand Create()
		{
			OverwatchCommand overwatchCommand = new OverwatchCommand();
			overwatchCommand.LoadGeneratedCommands();
			return overwatchCommand;
		}

		protected override bool ExecuteParent(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count == 0)
			{
				return SetOverwatchStatus(sender, 2, out response);
			}
			response = "SYNTAX: overwatch [enable/disable]";
			return false;
		}

		public override void LoadGeneratedCommands()
		{
			RegisterCommand(new DisableCommand());
			RegisterCommand(new EnableCommand());
		}

		internal static bool SetOverwatchStatus(ICommandSender sender, int status, out string response)
		{
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "You must be in-game to use this command!";
				return false;
			}
			switch (status)
			{
			case 0:
				if (!playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch)
				{
					response = "Overwatch mode is already disabled.";
					return true;
				}
				playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch = false;
				response = "Overwatch mode has been disabled.";
				return true;
			case 1:
				if (playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch)
				{
					response = "Overwatch mode is already enabled.";
					return true;
				}
				if (!playerCommandSender.CheckPermission(PlayerPermissions.Overwatch, out response))
				{
					return false;
				}
				playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch = true;
				response = "Overwatch mode has been enabled.";
				return true;
			case 2:
				if (playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch)
				{
					playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch = false;
					response = "Overwatch mode has been disabled.";
					return true;
				}
				if (!playerCommandSender.CheckPermission(PlayerPermissions.Overwatch, out response))
				{
					return false;
				}
				playerCommandSender.ReferenceHub.serverRoles.IsInOverwatch = true;
				response = "Overwatch mode has been enabled.";
				return true;
			default:
				response = "Unknown error occured in overwatch command.";
				return false;
			}
		}
	}
}
