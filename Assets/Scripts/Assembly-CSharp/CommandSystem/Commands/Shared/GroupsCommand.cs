using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CommandSystem.Commands.RemoteAdmin;
using GameCore;
using NorthwoodLib.Pools;
using RemoteAdmin;

namespace CommandSystem.Commands.Shared
{
	[CommandHandler(typeof(ClientCommandHandler))]
	[CommandHandler(typeof(PermissionsManagementCommand))]
	public class GroupsCommand : ICommand
	{
		public string Command { get; } = "groups";

		public string[] Aliases { get; }

		public string Description { get; } = "Lists all defined server groups.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (sender is PlayerCommandSender playerCommandSender && !playerCommandSender.ReferenceHub.authManager.BypassBansFlagSet && !playerCommandSender.ReferenceHub.isLocalPlayer && !sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				response = "You don't have permissions to execute this command.";
				return false;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent("Groups defined on this server:");
			try
			{
				Dictionary<string, UserGroup> allGroups = ServerStatic.PermissionsHandler.GetAllGroups();
				ServerRoles.NamedColor[] namedColors = ReferenceHub.LocalHub.serverRoles.NamedColors;
				foreach (KeyValuePair<string, UserGroup> item in allGroups)
				{
					string key = item.Key;
					UserGroup group = item.Value;
					try
					{
						string text = namedColors.FirstOrDefault((ServerRoles.NamedColor x) => x.Name == group.BadgeColor)?.ColorHex;
						stringBuilder.AppendFormat("\n{0} ({1}) - <color=#{2}>{3}</color> in color {4}", key, group.Permissions, text, group.BadgeText, group.BadgeColor);
					}
					catch
					{
						stringBuilder.AppendFormat("\n{0} ({1}) - {2} in color {3}", key, group.Permissions, group.BadgeText, group.BadgeColor);
					}
					foreach (KeyValuePair<PlayerPermissions, string> permissionCode in PermissionsHandler.PermissionCodes)
					{
						if (PermissionsHandler.IsPermitted(item.Value.Permissions, permissionCode.Key))
						{
							stringBuilder.AppendFormat("<color={0}> {1}</color>", permissionCode.Key.GetPermissionType().GetPermissionTypeColor(), permissionCode.Value);
						}
					}
				}
				response = stringBuilder.ToString();
			}
			finally
			{
				StringBuilderPool.Shared.Return(stringBuilder);
			}
			return true;
		}
	}
}
