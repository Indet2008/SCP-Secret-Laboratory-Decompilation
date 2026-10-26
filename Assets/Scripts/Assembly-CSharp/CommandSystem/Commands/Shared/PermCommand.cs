using System;
using System.Text;
using Mirror;
using NorthwoodLib.Pools;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class PermCommand : ICommand
	{
		public string Command { get; } = "perm";

		public string[] Aliases { get; }

		public string Description { get; } = "Lists your permissions.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!(sender is CommandSender commandSender))
			{
				response = "You can't use this command (you don't have any permissions set)";
				return false;
			}
			if (!NetworkServer.active)
			{
				response = "This command can only be used on a server.";
				return false;
			}
			string arg = ((!(sender is PlayerCommandSender playerCommandSender)) ? "N/A" : ((playerCommandSender.ReferenceHub.serverRoles.Group == null) ? "0" : playerCommandSender.ReferenceHub.serverRoles.Group.RequiredKickPower.ToString()));
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			try
			{
				ulong permissions = commandSender.Permissions;
				stringBuilder.AppendFormat("Your kick power: {0}\nKick power required to kick you: {1}\nYour permissions:", commandSender.KickPower, arg);
				foreach (string allPermission in ServerStatic.PermissionsHandler.GetAllPermissions())
				{
					string text = (ServerStatic.PermissionsHandler.IsRaPermitted(ServerStatic.PermissionsHandler.GetPermissionValue(allPermission)) ? "*" : "");
					stringBuilder.AppendFormat("\n{0}{1} ({2}): {3}", allPermission, text, ServerStatic.PermissionsHandler.GetPermissionValue(allPermission), ServerStatic.PermissionsHandler.IsPermitted(permissions, allPermission) ? "YES" : "NO");
				}
				response = stringBuilder.ToString();
				return true;
			}
			finally
			{
				StringBuilderPool.Shared.Return(stringBuilder);
			}
		}
	}
}
