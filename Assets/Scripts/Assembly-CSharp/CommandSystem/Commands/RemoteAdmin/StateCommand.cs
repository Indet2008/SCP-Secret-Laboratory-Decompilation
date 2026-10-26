using System;
using PlayerRoles.PlayableScps.Scp096;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class StateCommand : ICommand
	{
		public string Command { get; } = "096state";

		public string[] Aliases { get; } = new string[2] { "state096", "state" };

		public string Description { get; } = "Prints which state you are in server-side as 096.";

		public string[] Usage { get; } = new string[1] { "a" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(new PlayerPermissions[2]
			{
				PlayerPermissions.ForceclassSelf,
				PlayerPermissions.ForceclassWithoutRestrictions
			}, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "Only players can run this command.";
				return false;
			}
			if (!(playerCommandSender.ReferenceHub.roleManager.CurrentRole is Scp096Role scp096Role))
			{
				response = "You must be SCP-096 to use this command.";
				return false;
			}
			response = $"Your current state server-side is: RageState: {scp096Role.StateController.RageState} | AbilityState: {scp096Role.StateController.AbilityState}";
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + "'s " + response, ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}
	}
}
