using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CentralAuth;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.Spectating;
using RemoteAdmin.Interfaces;
using VoiceChat;

namespace RemoteAdmin.Communication
{
	public class RaPlayerList : IServerCommunication, IClientCommunication
	{
		public enum PlayerSorting
		{
			Ids = 0,
			Alphabetical = 1,
			Class = 2,
			Team = 3
		}

		private const string OverwatchBadge = "<link=RA_OverwatchEnabled><color=white>[</color><color=#03f8fc>\uf06e</color><color=white>]</color></link> ";

		private const string MutedBadge = "<link=RA_Muted><color=white>[</color>\ud83d\udd07<color=white>]</color></link> ";

		private const string HiddenSpectatableBadge = "<link=RA_HiddenSpectatable><color=white>[</color>\ud83d\udc53<color=white>]</color></link> ";

		public int DataId => 0;

		public void ReceiveData(CommandSender sender, string data)
		{
			string[] array = data.Split(' ');
			if (array.Length != 3 || !int.TryParse(array[0], out var result) || !int.TryParse(array[1], out var result2) || !Enum.IsDefined(typeof(PlayerSorting), result2))
			{
				return;
			}
			bool flag = result == 1;
			bool isDescending = array[2].Equals("1", StringComparison.Ordinal);
			PlayerSorting sorting = (PlayerSorting)result2;
			bool viewHiddenLocalBadges = CommandProcessor.CheckPermissions(sender, PlayerPermissions.ViewHiddenBadges);
			bool viewHiddenGlobalBadges = CommandProcessor.CheckPermissions(sender, PlayerPermissions.ViewHiddenGlobalBadges);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent("\n");
			StringBuilder stringBuilder2 = StringBuilderPool.Shared.Rent();
			PlayerRequestingRaPlayerListEventArgs e = new PlayerRequestingRaPlayerListEventArgs(sender, stringBuilder, isDescending, sorting, viewHiddenLocalBadges, viewHiddenGlobalBadges);
			PlayerEvents.OnRequestingRaPlayerList(e);
			if (!e.IsAllowed)
			{
				StringBuilderPool.Shared.Return(stringBuilder);
				StringBuilderPool.Shared.Return(stringBuilder2);
				return;
			}
			isDescending = e.IsDescending;
			sorting = e.Sorting;
			viewHiddenLocalBadges = e.ViewHiddenLocalBadges;
			viewHiddenGlobalBadges = e.ViewHiddenGlobalBadges;
			foreach (ReferenceHub item in isDescending ? SortPlayersDescending(sorting) : SortPlayers(sorting))
			{
				ClientInstanceMode mode = item.Mode;
				if (mode == ClientInstanceMode.DedicatedServer || mode == ClientInstanceMode.Unverified)
				{
					continue;
				}
				bool isInOverwatch = item.serverRoles.IsInOverwatch;
				bool isMuted = VoiceChatMutes.IsMuted(item);
				bool flag2 = SpectatableVisibilityManager.IsHidden(item);
				string prefix = GetPrefix(item, viewHiddenLocalBadges, viewHiddenGlobalBadges);
				string body = string.Format("<color={{RA_ClassColor}}>({0}) {1}</color>", item.PlayerId, item.nicknameSync.CombinedName.Replace("\n", string.Empty).Replace("RA_", string.Empty));
				PlayerRaPlayerListAddingPlayerEventArgs e2 = new PlayerRaPlayerListAddingPlayerEventArgs(sender, item, stringBuilder2, prefix, isInOverwatch, isMuted, body);
				PlayerEvents.OnRaPlayerListAddingPlayer(e2);
				if (e2.IsAllowed)
				{
					prefix = e2.Prefix;
					isInOverwatch = e2.InOverwatch;
					isMuted = e2.IsMuted;
					body = e2.Body;
					stringBuilder2.Append(prefix);
					if (isInOverwatch)
					{
						stringBuilder2.Append("<link=RA_OverwatchEnabled><color=white>[</color><color=#03f8fc>\uf06e</color><color=white>]</color></link> ");
					}
					if (isMuted)
					{
						stringBuilder2.Append("<link=RA_Muted><color=white>[</color>\ud83d\udd07<color=white>]</color></link> ");
					}
					if (flag2)
					{
						stringBuilder2.Append("<link=RA_HiddenSpectatable><color=white>[</color>\ud83d\udc53<color=white>]</color></link> ");
					}
					stringBuilder2.AppendLine(body);
					PlayerEvents.OnRaPlayerListAddedPlayer(new PlayerRaPlayerListAddedPlayerEventArgs(sender, item, stringBuilder2));
					stringBuilder.Append(stringBuilder2);
					stringBuilder2.Clear();
				}
			}
			StringBuilderPool.Shared.Return(stringBuilder2);
			PlayerEvents.OnRequestedRaPlayerList(new PlayerRequestedRaPlayerListEventArgs(sender, stringBuilder));
			sender.RaReply($"${DataId} {StringBuilderPool.Shared.ToStringReturn(stringBuilder)}", success: true, !flag, string.Empty);
		}

		private IEnumerable<ReferenceHub> SortPlayers(PlayerSorting sortingType)
		{
			return sortingType switch
			{
				PlayerSorting.Team => ReferenceHub.AllHubs.OrderBy((ReferenceHub h) => h.roleManager.CurrentRole.Team), 
				PlayerSorting.Alphabetical => ReferenceHub.AllHubs.OrderBy((ReferenceHub h) => h.nicknameSync.DisplayName ?? h.nicknameSync.MyNick), 
				PlayerSorting.Class => from h in ReferenceHub.AllHubs
					orderby h.GetTeam(), h.GetRoleId()
					select h, 
				_ => ReferenceHub.AllHubs.OrderBy((ReferenceHub h) => h.PlayerId), 
			};
		}

		private IEnumerable<ReferenceHub> SortPlayersDescending(PlayerSorting sortingType)
		{
			return sortingType switch
			{
				PlayerSorting.Team => ReferenceHub.AllHubs.OrderByDescending((ReferenceHub h) => h.roleManager.CurrentRole.Team), 
				PlayerSorting.Alphabetical => ReferenceHub.AllHubs.OrderByDescending((ReferenceHub h) => h.nicknameSync.DisplayName ?? h.nicknameSync.MyNick), 
				PlayerSorting.Class => from h in ReferenceHub.AllHubs
					orderby h.GetTeam() descending, h.GetRoleId() descending
					select h, 
				_ => ReferenceHub.AllHubs.OrderByDescending((ReferenceHub h) => h.PlayerId), 
			};
		}

		private static string GetPrefix(ReferenceHub hub, bool viewHiddenBadges = false, bool viewHiddenGlobalBadges = false)
		{
			if (hub.IsDummy)
			{
				return "[<color=#fcba03>\ud83d\udcbb</color>] ";
			}
			ServerRoles serverRoles = hub.serverRoles;
			if (!string.IsNullOrEmpty(serverRoles.HiddenBadge) && (!serverRoles.GlobalHidden || !viewHiddenBadges) && (serverRoles.GlobalHidden || !viewHiddenGlobalBadges))
			{
				return string.Empty;
			}
			if (hub.authManager.RemoteAdminGlobalAccess)
			{
				return "<link=RA_RaEverywhere><color=white>[<color=#EFC01A>\uf3ed</color><color=white>]</color></link> ";
			}
			if (hub.authManager.NorthwoodStaff)
			{
				return "<link=RA_StudioStaff><color=white>[<color=#005EBC>\uf0ad</color><color=white>]</color></link> ";
			}
			if (serverRoles.RemoteAdmin)
			{
				return "<link=RA_Admin><color=white>[\uf406]</color></link> ";
			}
			return string.Empty;
		}

		public void ReceiveData(string data, bool secure)
		{
			if (PlayerRequest.Singleton != null)
			{
				PlayerRequest.Singleton.ResponsePlayerList(data);
			}
		}

		public static void Request(bool isSilent, PlayerSorting sortingType = PlayerSorting.Ids, bool isDescending = false)
		{
			RemoteAdminClient.SendQuery(string.Format("$0 {0} {1} {2}", isSilent ? 1 : 0, (int)sortingType, isDescending ? 1 : 0), logQuery: false);
		}
	}
}
