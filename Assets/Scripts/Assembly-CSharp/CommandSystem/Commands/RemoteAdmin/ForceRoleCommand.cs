using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using PlayerRoles;
using RemoteAdmin;
using Utils;
using Utils.NonAllocLINQ;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ForceRoleCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "forcerole";

		public string[] Aliases { get; } = new string[3] { "fc", "fr", "forceclass" };

		public string Description { get; } = "Forces a player to a specified role.";

		public string[] Usage { get; } = new string[2] { "%player%", "%role%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!ReferenceHub.TryGetHostHub(out var _))
			{
				response = "You are not connected to a server.";
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			bool self = list.Count == 1 && sender is PlayerCommandSender playerCommandSender && playerCommandSender.ReferenceHub == list[0];
			if (!TryParseRole(newargs[0], out var prb))
			{
				response = "Invalid role ID / name.";
				return false;
			}
			if (!HasPerms(prb.RoleTypeId, self, sender, out response))
			{
				return false;
			}
			ProvideRoleFlag(newargs, out var spawnFlags);
			bool flag = list.Any((ReferenceHub p) => p.GetRoleId() != RoleTypeId.Overwatch);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null) && (!flag || item.GetRoleId() != RoleTypeId.Overwatch))
				{
					item.roleManager.ServerSetRole(prb.RoleTypeId, RoleChangeReason.RemoteAdmin, spawnFlags);
					ServerLogs.AddLog(ServerLogs.Modules.ClassChange, $"{sender.LogName} changed role of player {item.LoggedNameFromRefHub()} to {prb.RoleTypeId}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					num++;
				}
			}
			response = string.Format("Done! Changed role of {0} player{1} to {2}!", num, (num == 1) ? "" : "s", prb.RoleTypeId);
			return true;
		}

		private void ProvideRoleFlag(string[] arguments, out RoleSpawnFlags spawnFlags)
		{
			if (arguments.Length > 1 && byte.TryParse(arguments[1], out var result))
			{
				spawnFlags = (RoleSpawnFlags)result;
			}
			else
			{
				spawnFlags = RoleSpawnFlags.All;
			}
		}

		private bool TryParseRole(string s, out PlayerRoleBase prb)
		{
			if (Enum.TryParse<RoleTypeId>(s, ignoreCase: true, out var result))
			{
				return result.TryGetRoleTemplate<PlayerRoleBase>(out prb);
			}
			foreach (PlayerRoleBase value in PlayerRoleLoader.AllRoles.Values)
			{
				if (string.Equals(Regex.Replace(value.RoleName, "\\s+", ""), s, StringComparison.InvariantCultureIgnoreCase))
				{
					prb = value;
					return true;
				}
			}
			prb = null;
			return false;
		}

		private bool HasPerms(RoleTypeId targetRole, bool self, ICommandSender sender, out string response)
		{
			switch (targetRole)
			{
			case RoleTypeId.Spectator:
				if (self)
				{
					return sender.CheckPermission(new PlayerPermissions[4]
					{
						PlayerPermissions.ForceclassWithoutRestrictions,
						PlayerPermissions.ForceclassToSpectator,
						PlayerPermissions.ForceclassSelf,
						PlayerPermissions.Overwatch
					}, out response);
				}
				return sender.CheckPermission(new PlayerPermissions[2]
				{
					PlayerPermissions.ForceclassWithoutRestrictions,
					PlayerPermissions.ForceclassToSpectator
				}, out response);
			case RoleTypeId.Overwatch:
				if (self)
				{
					return sender.CheckPermission(PlayerPermissions.Overwatch, out response);
				}
				if (sender.CheckPermission(PlayerPermissions.Overwatch, out response))
				{
					return sender.CheckPermission(new PlayerPermissions[2]
					{
						PlayerPermissions.ForceclassWithoutRestrictions,
						PlayerPermissions.ForceclassToSpectator
					}, out response);
				}
				return false;
			default:
				if (self)
				{
					return sender.CheckPermission(new PlayerPermissions[2]
					{
						PlayerPermissions.ForceclassWithoutRestrictions,
						PlayerPermissions.ForceclassSelf
					}, out response);
				}
				return sender.CheckPermission(PlayerPermissions.ForceclassWithoutRestrictions, out response);
			}
		}
	}
}
