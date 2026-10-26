using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using InventorySystem;
using InventorySystem.Configs;
using PlayerRoles;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class GiveLoadoutCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "giveloadout";

		public string[] Aliases { get; } = new string[3] { "sendloadout", "giveinventory", "grantloadout" };

		public string Description { get; } = "Grant target(s) the specified role's loadout.";

		public string[] Usage { get; } = new string[2] { "%player%", "%role%" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!ReferenceHub.TryGetHostHub(out var hub))
			{
				response = "You are not connected to a server.";
				return false;
			}
			if (arguments.Count < 2)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (!sender.CheckPermission(PlayerPermissions.GivingItems, out response))
			{
				return false;
			}
			CharacterClassManager characterClassManager = hub.characterClassManager;
			if (characterClassManager == null || !characterClassManager.isLocalPlayer || !characterClassManager.isServer || !characterClassManager.RoundStarted)
			{
				response = "Please start round before using this command.";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (!TryParseRole(newargs[0], out var prb))
			{
				response = "Invalid role ID / name.";
				return false;
			}
			if (!StartingInventories.DefinedInventories.ContainsKey(prb.RoleTypeId))
			{
				response = "Specified role does not have a defined inventory.";
				return false;
			}
			ProvideRoleFlag(newargs, out var spawnFlags);
			bool resetInventory = spawnFlags.HasFlag(RoleSpawnFlags.AssignInventory);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (!(item == null))
				{
					InventoryItemProvider.ServerGrantLoadout(item, prb, resetInventory);
					ServerLogs.AddLog(ServerLogs.Modules.ClassChange, $"{sender.LogName} gave {item.LoggedNameFromRefHub()} the loadout of {prb.RoleTypeId}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					num++;
				}
			}
			response = string.Format("Done! Given {0}'s loadout to {1} player{2}!", prb.RoleName, num, (num == 1) ? "" : "s");
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
				if (!string.Equals(Regex.Replace(value.RoleName, "\\s+", ""), s, StringComparison.InvariantCultureIgnoreCase))
				{
					prb = value;
					return true;
				}
			}
			prb = null;
			return false;
		}
	}
}
