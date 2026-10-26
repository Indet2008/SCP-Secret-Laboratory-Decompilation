using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CentralAuth;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using RemoteAdmin.Interfaces;
using Utils;
using VoiceChat;

namespace RemoteAdmin.Communication
{
	public class RaPlayer : IServerCommunication, IClientCommunication
	{
		public int DataId => 1;

		public void ReceiveData(CommandSender sender, string data)
		{
			string[] array = data.Split(' ');
			if (array.Length != 2 || !int.TryParse(array[0], out var result))
			{
				return;
			}
			bool flag = result == 1;
			PlayerCommandSender playerCommandSender = sender as PlayerCommandSender;
			bool hasSensitiveInfoPerms = playerCommandSender == null || playerCommandSender.ReferenceHub.authManager.RemoteAdminGlobalAccess || playerCommandSender.ReferenceHub.authManager.BypassBansFlagSet || CommandProcessor.CheckPermissions(sender, PlayerPermissions.PlayerSensitiveDataAccess);
			ArraySegment<string> arraySegment = new ArraySegment<string>(array.Skip(1).ToArray());
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arraySegment, 0, out var _);
			if (list.Count == 0)
			{
				StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
				stringBuilder.AppendFormat("${0} ", DataId);
				PlayerRequestedCustomRaInfoEventArgs e = new PlayerRequestedCustomRaInfoEventArgs(sender, arraySegment, !flag, stringBuilder);
				PlayerEvents.OnRequestedCustomRaInfo(e);
				if (e.TryGetClipboardText(0, out string text))
				{
					RaClipboard.Send(sender, RaClipboard.RaClipBoardType.PlayerId, text);
				}
				if (e.TryGetClipboardText(1, out text))
				{
					RaClipboard.Send(sender, RaClipboard.RaClipBoardType.Ip, text);
				}
				if (e.TryGetClipboardText(2, out text))
				{
					RaClipboard.Send(sender, RaClipboard.RaClipBoardType.UserId, text);
				}
				sender.RaReply(StringBuilderPool.Shared.ToStringReturn(stringBuilder), success: true, logToConsole: true, string.Empty);
				return;
			}
			bool hasUserIdPerms = (playerCommandSender != null && playerCommandSender.ReferenceHub.authManager.NorthwoodStaff) || PermissionsHandler.IsPermitted(sender.Permissions, 18007046uL);
			if (list.Count > 1)
			{
				StringBuilder stringBuilder2 = StringBuilderPool.Shared.Rent();
				PlayerRequestingRaPlayersInfoEventArgs e2 = new PlayerRequestingRaPlayersInfoEventArgs(sender, list, !flag, hasSensitiveInfoPerms, hasUserIdPerms, stringBuilder2);
				PlayerEvents.OnRequestingRaPlayersInfo(e2);
				if (!e2.IsAllowed)
				{
					StringBuilderPool.Shared.Return(stringBuilder2);
					return;
				}
				flag = !e2.IsSensitiveInfo;
				hasSensitiveInfoPerms = e2.HasSensitiveInfoPerms;
				hasUserIdPerms = e2.HasUserIdPerms;
				if (!flag && !hasSensitiveInfoPerms)
				{
					StringBuilderPool.Shared.Return(stringBuilder2);
					return;
				}
				stringBuilder2.AppendFormat("${0} ", DataId);
				stringBuilder2.Append("<color=white>Multiple players selected:");
				stringBuilder2.Append("\nPlayer ID: <color=green><link=CP_ID>\uf0c5</link></color>");
				stringBuilder2.AppendFormat("\nIP Address: {0}", (!flag) ? "<color=green><link=CP_IP>\uf0c5</link></color>" : "[REDACTED]");
				stringBuilder2.AppendFormat("\nUser ID: {0}", hasUserIdPerms ? "<color=green><link=CP_USERID>\uf0c5</link></color>" : "[REDACTED]");
				stringBuilder2.Append("</color>");
				StringBuilder stringBuilder3 = StringBuilderPool.Shared.Rent();
				StringBuilder stringBuilder4 = ((!flag) ? StringBuilderPool.Shared.Rent() : null);
				StringBuilder stringBuilder5 = (hasUserIdPerms ? StringBuilderPool.Shared.Rent() : null);
				foreach (ReferenceHub item in list)
				{
					stringBuilder3.Append(item.PlayerId);
					stringBuilder3.Append(", ");
					if (!flag)
					{
						ServerLogs.AddLog(ServerLogs.Modules.DataAccess, $"{sender.LogName} accessed IP address of player {item.PlayerId} ({item.nicknameSync.MyNick}).", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
						stringBuilder4.Append(item.networkIdentity.connectionToClient.address);
						stringBuilder4.Append(", ");
					}
					if (hasUserIdPerms)
					{
						stringBuilder5.Append(item.authManager.UserId);
						stringBuilder5.Append(", ");
					}
				}
				PlayerEvents.OnRequestedRaPlayersInfo(new PlayerRequestedRaPlayersInfoEventArgs(sender, list, !flag, hasUserIdPerms, stringBuilder2, stringBuilder3, stringBuilder4, stringBuilder5));
				RaClipboard.Send(sender, RaClipboard.RaClipBoardType.PlayerId, StringBuilderPool.Shared.ToStringReturn(stringBuilder3));
				RaClipboard.Send(sender, RaClipboard.RaClipBoardType.Ip, (stringBuilder4 == null) ? string.Empty : StringBuilderPool.Shared.ToStringReturn(stringBuilder4));
				RaClipboard.Send(sender, RaClipboard.RaClipBoardType.UserId, (stringBuilder5 == null) ? string.Empty : StringBuilderPool.Shared.ToStringReturn(stringBuilder5));
				sender.RaReply(StringBuilderPool.Shared.ToStringReturn(stringBuilder2), success: true, logToConsole: true, string.Empty);
				return;
			}
			ReferenceHub referenceHub = list[0];
			StringBuilder stringBuilder6 = StringBuilderPool.Shared.Rent();
			PlayerRequestingRaPlayerInfoEventArgs e3 = new PlayerRequestingRaPlayerInfoEventArgs(sender, referenceHub, !flag, hasSensitiveInfoPerms, hasUserIdPerms, stringBuilder6);
			PlayerEvents.OnRequestingRaPlayerInfo(e3);
			if (!e3.IsAllowed)
			{
				StringBuilderPool.Shared.Return(stringBuilder6);
				return;
			}
			flag = !e3.IsSensitiveInfo;
			hasSensitiveInfoPerms = e3.HasSensitiveInfoPerms;
			hasUserIdPerms = e3.HasUserIdPerms;
			if (!flag && !hasSensitiveInfoPerms)
			{
				StringBuilderPool.Shared.Return(stringBuilder6);
				return;
			}
			bool flag2 = PermissionsHandler.IsPermitted(sender.Permissions, PlayerPermissions.GameplayData);
			CharacterClassManager characterClassManager = referenceHub.characterClassManager;
			PlayerAuthenticationManager authManager = referenceHub.authManager;
			NicknameSync nicknameSync = referenceHub.nicknameSync;
			NetworkConnectionToClient connectionToClient = referenceHub.networkIdentity.connectionToClient;
			ServerRoles serverRoles = referenceHub.serverRoles;
			if (sender is PlayerCommandSender playerCommandSender2)
			{
				playerCommandSender2.ReferenceHub.queryProcessor.GameplayData = flag2;
			}
			stringBuilder6.AppendFormat("${0} ", DataId);
			stringBuilder6.AppendFormat("<color=white>Nickname: {0}", nicknameSync.CombinedName);
			stringBuilder6.AppendFormat("\nPlayer ID: {0} <color=green><link=CP_ID>\uf0c5</link></color>", referenceHub.PlayerId);
			StringBuilder stringBuilder7 = StringBuilderPool.Shared.Rent();
			StringBuilder stringBuilder8 = StringBuilderPool.Shared.Rent();
			StringBuilder stringBuilder9 = StringBuilderPool.Shared.Rent();
			stringBuilder7.Append($"{referenceHub.PlayerId}");
			if (connectionToClient == null)
			{
				stringBuilder6.Append("\nIP Address: null");
			}
			else if (!flag)
			{
				ServerLogs.AddLog(ServerLogs.Modules.DataAccess, $"{sender.LogName} accessed IP address of player {referenceHub.PlayerId} ({referenceHub.nicknameSync.MyNick}).", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				string address = connectionToClient.address;
				stringBuilder6.AppendFormat("\nIP Address: {0} ", address);
				stringBuilder8.Append(address);
				if (connectionToClient.IpOverride != null)
				{
					stringBuilder6.AppendFormat(" [routed via {0}]", connectionToClient.OriginalIpAddress);
				}
				stringBuilder6.Append(" <color=green><link=CP_IP>\uf0c5</link></color>");
			}
			else
			{
				stringBuilder6.Append("\nIP Address: [REDACTED]");
			}
			stringBuilder6.Append("\nUser ID: ");
			if (hasUserIdPerms)
			{
				if (string.IsNullOrEmpty(authManager.UserId))
				{
					stringBuilder6.Append("(none)");
				}
				else
				{
					stringBuilder6.AppendFormat("{0} <color=green><link=CP_USERID>\uf0c5</link></color>", authManager.UserId);
				}
				stringBuilder9.Append(authManager.UserId ?? string.Empty);
				if (authManager.SaltedUserId != null && authManager.SaltedUserId.Contains("$", StringComparison.Ordinal))
				{
					stringBuilder6.AppendFormat("\nSalted User ID: {0}", authManager.SaltedUserId);
				}
			}
			else
			{
				stringBuilder6.Append("<color=#D4AF37>INSUFFICIENT PERMISSIONS</color>");
			}
			stringBuilder6.Append("\nServer role: ");
			stringBuilder6.Append(serverRoles.GetColoredRoleString());
			bool flag3 = CommandProcessor.CheckPermissions(sender, PlayerPermissions.ViewHiddenBadges);
			bool flag4 = CommandProcessor.CheckPermissions(sender, PlayerPermissions.ViewHiddenGlobalBadges);
			if (playerCommandSender != null)
			{
				flag3 = true;
				flag4 = true;
			}
			bool flag5 = !string.IsNullOrEmpty(serverRoles.HiddenBadge);
			bool flag6 = !flag5 || (serverRoles.GlobalHidden & flag4) || (!serverRoles.GlobalHidden & flag3);
			if (flag6)
			{
				if (flag5)
				{
					stringBuilder6.AppendFormat("\n<color=#DC143C>Hidden role: </color>{0}", serverRoles.HiddenBadge);
					stringBuilder6.AppendFormat("\n<color=#DC143C>Hidden role type: </color>{0}", serverRoles.GlobalHidden ? "GLOBAL" : "LOCAL");
				}
				if (referenceHub.authManager.RemoteAdminGlobalAccess)
				{
					stringBuilder6.Append("\nStudio Status: <color=#BCC6CC>Studio GLOBAL Staff (management or global moderation)</color>");
				}
				else if (referenceHub.authManager.NorthwoodStaff)
				{
					stringBuilder6.Append("\nStudio Status: <color=#94B9CF>Studio Staff</color>");
				}
			}
			VcMuteFlags flags = VoiceChatMutes.GetFlags(list[0]);
			if (flags != VcMuteFlags.None)
			{
				stringBuilder6.Append("\nMUTE STATUS:");
				VcMuteFlags[] values = EnumUtils<VcMuteFlags>.Values;
				foreach (VcMuteFlags vcMuteFlags in values)
				{
					if (vcMuteFlags != VcMuteFlags.None && (flags & vcMuteFlags) == vcMuteFlags)
					{
						stringBuilder6.Append(" <color=#F70D1A>");
						stringBuilder6.Append(vcMuteFlags);
						stringBuilder6.Append("</color>");
					}
				}
			}
			stringBuilder6.Append("\nActive flag(s):");
			if (characterClassManager.GodMode)
			{
				stringBuilder6.Append(" <color=#659EC7>[GOD MODE]</color>");
			}
			if (referenceHub.playerStats.GetModule<AdminFlagsStat>().HasFlag(AdminFlags.Noclip))
			{
				stringBuilder6.Append(" <color=#DC143C>[NOCLIP ENABLED]</color>");
			}
			else if (FpcNoclip.IsPermitted(referenceHub))
			{
				stringBuilder6.Append(" <color=#E52B50>[NOCLIP UNLOCKED]</color>");
			}
			if (authManager.DoNotTrack)
			{
				stringBuilder6.Append(" <color=#BFFF00>[DO NOT TRACK]</color>");
			}
			if (serverRoles.BypassMode)
			{
				stringBuilder6.Append(" <color=#BFFF00>[BYPASS MODE]</color>");
			}
			if (flag6 && serverRoles.RemoteAdmin)
			{
				stringBuilder6.Append(" <color=#43C6DB>[RA AUTHENTICATED]</color>");
			}
			if (serverRoles.IsInOverwatch)
			{
				stringBuilder6.Append(" <color=#008080>[OVERWATCH MODE]</color>");
			}
			else if (flag2)
			{
				stringBuilder6.Append("\nClass: ").Append(PlayerRoleLoader.AllRoles.TryGetValue(referenceHub.GetRoleId(), out var value) ? ((object)value.RoleTypeId) : "None");
				stringBuilder6.Append(" <color=#fcff99>[HP: ").Append(CommandProcessor.GetRoundedStat<HealthStat>(referenceHub)).Append("]</color>");
				stringBuilder6.Append(" <color=green>[AHP: ").Append(CommandProcessor.GetRoundedStat<AhpStat>(referenceHub)).Append("]</color>");
				stringBuilder6.Append(" <color=#977dff>[HS: ").Append(CommandProcessor.GetRoundedStat<HumeShieldStat>(referenceHub)).Append("]</color>");
				stringBuilder6.Append("\nPosition: ").Append(referenceHub.transform.position.ToPreciseString());
			}
			else
			{
				stringBuilder6.Append("\n<color=#D4AF37>Some fields were hidden. GameplayData permission required.</color>");
			}
			stringBuilder6.Append("</color>");
			PlayerEvents.OnRequestedRaPlayerInfo(new PlayerRequestedRaPlayerInfoEventArgs(sender, referenceHub, !flag, hasUserIdPerms, stringBuilder6, stringBuilder7, stringBuilder8, stringBuilder9));
			RaClipboard.Send(sender, RaClipboard.RaClipBoardType.PlayerId, StringBuilderPool.Shared.ToStringReturn(stringBuilder7));
			RaClipboard.Send(sender, RaClipboard.RaClipBoardType.Ip, StringBuilderPool.Shared.ToStringReturn(stringBuilder8));
			RaClipboard.Send(sender, RaClipboard.RaClipBoardType.UserId, StringBuilderPool.Shared.ToStringReturn(stringBuilder9));
			sender.RaReply(StringBuilderPool.Shared.ToStringReturn(stringBuilder6), success: true, logToConsole: true, string.Empty);
			RaPlayerQR.Send(sender, isBig: false, (!hasUserIdPerms || string.IsNullOrEmpty(authManager.UserId)) ? string.Empty : authManager.UserId);
		}

		public void ReceiveData(string data, bool secure)
		{
			SubmenuSelector singleton = SubmenuSelector.Singleton;
			if (singleton != null && singleton.SelectedMenu != null)
			{
				singleton.SelectedMenu.SetResponse(isSuccess: true, data);
			}
			else
			{
				TextBasedRemoteAdmin.AddLog(data);
			}
		}

		public static void Request(bool isShort, string playerIds)
		{
			RemoteAdminClient.SendQuery(string.Format("$1 {0} {1}", isShort ? 1 : 0, playerIds), logQuery: false);
		}
	}
}
