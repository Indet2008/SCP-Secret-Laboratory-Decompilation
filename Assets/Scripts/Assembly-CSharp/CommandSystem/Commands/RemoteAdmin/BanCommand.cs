using System;
using System.Collections.Generic;
using System.Linq;
using GameCore;
using UnityEngine;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class BanCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "ban";

		public string[] Aliases { get; }

		public string Description { get; } = "Bans a player.";

		public string[] Usage { get; } = new string[3] { "%player%", "Duration", "Reason" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (arguments.Count < 3)
			{
				response = "To execute this command provide at least 2 arguments!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var newargs);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId/Name array processing.";
				return false;
			}
			if (newargs == null)
			{
				response = "An error occured while processing this command.\nUsage: " + this.DisplayCommandUsage();
				return false;
			}
			string text = string.Empty;
			if (newargs.Length > 1)
			{
				text = newargs.Skip(1).Aggregate((string text3, string n) => text3 + " " + n);
			}
			long num;
			try
			{
				num = Misc.RelativeTimeToSeconds(newargs[0], 60);
			}
			catch
			{
				response = "Invalid time: " + newargs[0];
				return false;
			}
			if (num < 0)
			{
				num = 0L;
				newargs[0] = "0";
			}
			if (num == 0L && !sender.CheckPermission(new PlayerPermissions[3]
			{
				PlayerPermissions.KickingAndShortTermBanning,
				PlayerPermissions.BanningUpToDay,
				PlayerPermissions.LongTermBanning
			}, out response))
			{
				return false;
			}
			if (num > 0 && num <= 3600 && !sender.CheckPermission(PlayerPermissions.KickingAndShortTermBanning, out response))
			{
				return false;
			}
			if (num > 3600 && num <= 86400 && !sender.CheckPermission(PlayerPermissions.BanningUpToDay, out response))
			{
				return false;
			}
			if (num > 86400 && !sender.CheckPermission(PlayerPermissions.LongTermBanning, out response))
			{
				return false;
			}
			ushort num2 = 0;
			ushort num3 = 0;
			string text2 = string.Empty;
			foreach (ReferenceHub item in list)
			{
				try
				{
					if (item == null)
					{
						num3++;
						continue;
					}
					string combinedName = item.nicknameSync.CombinedName;
					if (!(sender is CommandSender { FullPermissions: false } commandSender))
					{
						goto IL_01ee;
					}
					byte b = item.serverRoles.Group?.RequiredKickPower ?? 0;
					if (b <= commandSender.KickPower)
					{
						goto IL_01ee;
					}
					num3++;
					text2 = $"You can't kick/ban {combinedName}. Required kick power: {b}, your kick power: {commandSender.KickPower}.";
					sender.Respond(text2, success: false);
					goto end_IL_015a;
					IL_01ee:
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " banned player " + item.LoggedNameFromRefHub() + ". Ban duration: " + newargs[0] + ". Reason: " + ((text == string.Empty) ? "(none)" : text) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					if (CustomNetworkManager.IsVerified && item.authManager.BypassBansFlagSet)
					{
						BanPlayer.KickUser(item, sender, text);
					}
					else
					{
						if (num == 0L && ConfigFile.ServerConfig.GetBool("broadcast_kicks"))
						{
							Broadcast.Singleton.RpcAddElement(ConfigFile.ServerConfig.GetString("broadcast_kick_text", "%nick% has been kicked from this server.").Replace("%nick%", combinedName), ConfigFile.ServerConfig.GetUShort("broadcast_kick_duration", 5), Broadcast.BroadcastFlags.Normal);
						}
						else if (num != 0L && ConfigFile.ServerConfig.GetBool("broadcast_bans", def: true))
						{
							Broadcast.Singleton.RpcAddElement(ConfigFile.ServerConfig.GetString("broadcast_ban_text", "%nick% has been banned from this server.").Replace("%nick%", combinedName), ConfigFile.ServerConfig.GetUShort("broadcast_ban_duration", 5), Broadcast.BroadcastFlags.Normal);
						}
						BanPlayer.BanUser(item, sender, text, num);
					}
					num2++;
					end_IL_015a:;
				}
				catch (Exception ex)
				{
					num3++;
					Debug.Log(ex);
					text2 = "Error occured during banning: " + ex.Message + ".\n" + ex.StackTrace;
				}
			}
			if (num3 == 0)
			{
				string arg = "Banned";
				if (int.TryParse(newargs[0], out var result))
				{
					arg = ((result > 0) ? "Banned" : "Kicked");
				}
				response = string.Format("Done! {0} {1} player{2}", arg, num2, (num2 == 1) ? "!" : "s!");
				return true;
			}
			response = $"Failed to execute the command! Failures: {num3}\nLast error log:\n{text2}";
			return false;
		}
	}
}
