using System;
using System.Collections.Generic;
using System.Text;
using NorthwoodLib.Pools;

namespace CommandSystem.Commands.RemoteAdmin.PermissionsManagement
{
	[CommandHandler(typeof(PermissionsManagementCommand))]
	public class UsersCommand : ICommand
	{
		public string Command { get; } = "users";

		public string[] Aliases { get; }

		public string Description { get; } = "List all the users that are assigned to any group.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			Dictionary<string, string> stringDictionary = ServerStatic.RolesConfig.GetStringDictionary("Members");
			Dictionary<string, string> dictionary = ServerStatic.SharedGroupsMembersConfig?.GetStringDictionary("SharedMembers");
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent("Players with assigned groups:");
			foreach (KeyValuePair<string, string> item in stringDictionary)
			{
				stringBuilder.Append("\n" + item.Key + " - " + item.Value);
			}
			if (dictionary != null)
			{
				foreach (KeyValuePair<string, string> item2 in dictionary)
				{
					stringBuilder.Append("\n" + item2.Key + " - " + item2.Value + " <color=#FFD700>[SHARED MEMBERSHIP]</color>");
				}
			}
			response = stringBuilder.ToString();
			StringBuilderPool.Shared.Return(stringBuilder);
			return true;
		}
	}
}
