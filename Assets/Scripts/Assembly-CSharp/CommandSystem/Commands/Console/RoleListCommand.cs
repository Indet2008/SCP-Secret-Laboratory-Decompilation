using System;
using System.Collections.Generic;
using System.Text;
using PlayerRoles;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class RoleListCommand : ICommand
	{
		public string Command { get; } = "rolelist";

		public string[] Aliases { get; }

		public string Description { get; } = "Display a list of roles.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("<size=25>List of role:</size>");
			foreach (KeyValuePair<RoleTypeId, PlayerRoleBase> allRole in PlayerRoleLoader.AllRoles)
			{
				PlayerRoleBase value = allRole.Value;
				if (!(value is IHiddenRole { IsHidden: not false }))
				{
					stringBuilder.AppendLine($"Role #{(int)allRole.Key:000} : {allRole.Key} - \"{value.RoleName}\"");
				}
			}
			response = stringBuilder.ToString();
			return true;
		}
	}
}
