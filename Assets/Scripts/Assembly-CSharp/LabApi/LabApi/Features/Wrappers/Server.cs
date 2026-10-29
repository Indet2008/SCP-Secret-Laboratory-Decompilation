namespace LabApi.Features.Wrappers
{
	public static class Server
	{
		public interface ILimit<in TKey, TValue>
		{
			TValue this[TKey index] { get; set; }
		}

		private class CategoryLimitsSynchronizer : global::LabApi.Features.Wrappers.Server.ILimit<ItemCategory, sbyte>
		{
			public sbyte this[ItemCategory category]
			{
				get
				{
					return global::InventorySystem.Configs.InventoryLimits.StandardCategoryLimits[category];
				}
				set
				{
					if (!global::InventorySystem.Configs.InventoryLimits.StandardCategoryLimits.ContainsKey(category))
					{
						throw new global::System.IndexOutOfRangeException($"Index {category} was not a valid ItemCategory type");
					}
					global::InventorySystem.Configs.InventoryLimits.StandardCategoryLimits[category] = value;
					ServerConfigSynchronizer.Singleton.RefreshCategoryLimits();
				}
			}
		}

		private class AmmoLimitsSynchronizer : global::LabApi.Features.Wrappers.Server.ILimit<ItemType, ushort>
		{
			public ushort this[ItemType ammo]
			{
				get
				{
					return global::InventorySystem.Configs.InventoryLimits.StandardAmmoLimits[ammo];
				}
				set
				{
					if (!global::InventorySystem.Configs.InventoryLimits.StandardAmmoLimits.ContainsKey(ammo))
					{
						throw new global::System.IndexOutOfRangeException($"Index {ammo} was not a valid Ammo type");
					}
					global::InventorySystem.Configs.InventoryLimits.StandardAmmoLimits[ammo] = value;
					ServerConfigSynchronizer.Singleton.RefreshAmmoLimits();
				}
			}
		}

		public static global::LabApi.Features.Wrappers.Player? Host { get; internal set; }

		public static string IpAddress => ServerConsole.Ip;

		public static ushort Port => ServerStatic.ServerPort;

		public static int PlayerCount => global::LabApi.Features.Wrappers.Player.Count;

		public static int MaxPlayers
		{
			get
			{
				return CustomNetworkManager.slots;
			}
			set
			{
				CustomNetworkManager.slots = value;
			}
		}

		public static int ReservedSlots
		{
			get
			{
				return CustomNetworkManager.reservedSlots;
			}
			set
			{
				CustomNetworkManager.reservedSlots = value;
			}
		}

		public static global::LabApi.Features.Permissions.Providers.DefaultPermissionsProvider? DefaultPermissionProvider => (global::LabApi.Features.Permissions.Providers.DefaultPermissionsProvider)global::LabApi.Features.Permissions.PermissionsManager.GetProvider<global::LabApi.Features.Permissions.Providers.DefaultPermissionsProvider>();

		public static double Tps => global::System.Math.Round(1f / global::UnityEngine.Time.smoothDeltaTime);

		public static short MaxTps
		{
			get
			{
				return ServerStatic.ServerTickrate;
			}
			set
			{
				ServerStatic.ServerTickrate = value;
			}
		}

		public static float SpawnProtectDuration
		{
			get
			{
				return global::CustomPlayerEffects.SpawnProtected.SpawnDuration;
			}
			set
			{
				global::CustomPlayerEffects.SpawnProtected.SpawnDuration = value;
			}
		}

		public static bool IdleModeActive => IdleMode.IdleModeActive;

		public static bool PauseIdleMode
		{
			get
			{
				return IdleMode.PauseIdleMode;
			}
			set
			{
				IdleMode.PauseIdleMode = value;
			}
		}

		public static bool IdleModeAvailable
		{
			get
			{
				return IdleMode.IdleModeEnabled;
			}
			set
			{
				IdleMode.IdleModeEnabled = value;
			}
		}

		public static bool FriendlyFire
		{
			get
			{
				return ServerConsole.FriendlyFire;
			}
			set
			{
				if (FriendlyFire != value)
				{
					ServerConsole.FriendlyFire = value;
					ServerConfigSynchronizer.Singleton.RefreshMainBools();
					ServerConfigSynchronizer.OnRefreshed?.Invoke();
				}
			}
		}

		public static bool AchievementsEnabled
		{
			get
			{
				return !global::Achievements.AchievementManager.AchievementsDisabled;
			}
			set
			{
				if (global::Achievements.AchievementManager.AchievementsDisabled == value)
				{
					global::Achievements.AchievementManager.AchievementsDisabled = !value;
					ServerConfigSynchronizer.Singleton.RefreshMainBools();
					ServerConfigSynchronizer.OnRefreshed?.Invoke();
				}
			}
		}

		public static string ServerListName
		{
			get
			{
				return ServerConsole.ServerName;
			}
			set
			{
				ServerConsole.ServerName = value;
			}
		}

		public static string PlayerListName
		{
			get
			{
				return PlayerList.Title.Value;
			}
			set
			{
				PlayerList.Title.Value = value;
			}
		}

		public static float PlayerListNameRefreshRate
		{
			get
			{
				return PlayerList.RefreshRate.Value;
			}
			set
			{
				PlayerList.RefreshRate.Value = value;
			}
		}

		public static bool IsTransparentlyModded { get; internal set; }

		public static global::LabApi.Features.Wrappers.Server.ILimit<ItemCategory, sbyte> CategoryLimits { get; } = new global::LabApi.Features.Wrappers.Server.CategoryLimitsSynchronizer();

		public static global::LabApi.Features.Wrappers.Server.ILimit<ItemType, ushort> AmmoLimits { get; } = new global::LabApi.Features.Wrappers.Server.AmmoLimitsSynchronizer();

		public static global::CommandSystem.RemoteAdminCommandHandler RemoteAdminCommandHandler => global::RemoteAdmin.CommandProcessor.RemoteAdminCommandHandler;

		public static global::CommandSystem.ClientCommandHandler ClientCommandHandler => global::RemoteAdmin.QueryProcessor.DotCommandHandler;

		public static global::CommandSystem.GameConsoleCommandHandler GameConsoleCommandHandler => global::GameCore.Console.ConsoleCommandHandler;

		public static ServerShutdown.ServerShutdownState ShutdownState => ServerShutdown.ShutdownState;

		public static bool BanPlayer(global::LabApi.Features.Wrappers.Player player, string reason, long duration)
		{
			return global::BanPlayer.BanUser(player.ReferenceHub, reason, duration);
		}

		public static bool BanPlayer(global::LabApi.Features.Wrappers.Player player, global::LabApi.Features.Wrappers.Player issuer, string reason, long duration)
		{
			return global::BanPlayer.BanUser(player.ReferenceHub, issuer.ReferenceHub, reason, duration);
		}

		public static bool KickPlayer(global::LabApi.Features.Wrappers.Player player, string reason)
		{
			return global::BanPlayer.KickUser(player.ReferenceHub, reason);
		}

		public static bool KickPlayer(global::LabApi.Features.Wrappers.Player player, global::LabApi.Features.Wrappers.Player issuer, string reason)
		{
			return global::BanPlayer.KickUser(player.ReferenceHub, issuer.ReferenceHub, reason);
		}

		public static bool BanUserId(string userId, string reason, long duration, string bannedPlayerNickname = "UnknownName")
		{
			return BanUserId(userId, Host, reason, duration, bannedPlayerNickname);
		}

		public static bool BanUserId(string userId, global::LabApi.Features.Wrappers.Player? issuer, string reason, long duration, string bannedPlayerNickname = "UnknownName")
		{
			if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(reason) || issuer == null)
			{
				return false;
			}
			return BanHandler.IssueBan(new BanDetails
			{
				Id = userId,
				IssuanceTime = TimeBehaviour.CurrentTimestamp(),
				Expires = TimeBehaviour.GetBanExpirationTime((uint)duration),
				Issuer = issuer.LogName,
				OriginalName = bannedPlayerNickname,
				Reason = reason
			}, BanHandler.BanType.UserId);
		}

		public static bool BanIpAddress(string ipAddress, string reason, long duration, string bannedPlayerNickname = "UnknownName")
		{
			return BanIpAddress(ipAddress, Host, reason, duration, bannedPlayerNickname);
		}

		public static bool BanIpAddress(string ipAddress, global::LabApi.Features.Wrappers.Player? issuer, string reason, long duration, string bannedPlayerNickname = "UnknownName")
		{
			if (string.IsNullOrEmpty(ipAddress) || string.IsNullOrEmpty(reason) || issuer == null)
			{
				return false;
			}
			return BanHandler.IssueBan(new BanDetails
			{
				Id = ipAddress,
				IssuanceTime = TimeBehaviour.CurrentTimestamp(),
				Expires = TimeBehaviour.GetBanExpirationTime((uint)duration),
				Issuer = issuer.LogName,
				OriginalName = bannedPlayerNickname,
				Reason = reason
			}, BanHandler.BanType.IP);
		}

		public static bool UnbanUserId(string userId)
		{
			if (string.IsNullOrEmpty(userId) || !IsPlayerBanned(userId))
			{
				return false;
			}
			BanHandler.RemoveBan(userId, BanHandler.BanType.UserId);
			return true;
		}

		public static bool UnbanIpAddress(string ipAddress)
		{
			if (string.IsNullOrEmpty(ipAddress) || !IsPlayerBanned(ipAddress))
			{
				return false;
			}
			BanHandler.RemoveBan(ipAddress, BanHandler.BanType.IP);
			return true;
		}

		public static bool IsPlayerBanned(string value)
		{
			if (string.IsNullOrEmpty(value))
			{
				return false;
			}
			return (value.Contains("@") ? BanHandler.GetBan(value, BanHandler.BanType.UserId) : BanHandler.GetBan(value, BanHandler.BanType.IP)) != null;
		}

		public static global::System.Collections.Generic.List<BanDetails> GetAllBannedPlayers()
		{
			global::System.Collections.Generic.List<BanDetails> list = global::NorthwoodLib.Pools.ListPool<BanDetails>.Shared.Rent();
			list.AddRange(BanHandler.GetBans(BanHandler.BanType.UserId));
			list.AddRange(BanHandler.GetBans(BanHandler.BanType.IP));
			return list;
		}

		public static global::System.Collections.Generic.List<BanDetails> GetAllBannedPlayers(BanHandler.BanType banType)
		{
			return BanHandler.GetBans(banType);
		}

		public static void Restart()
		{
			global::LabApi.Features.Wrappers.Round.Restart(fastRestart: false, overrideRestartAction: true, ServerStatic.NextRoundAction.Restart);
		}

		public static void Restart(ushort redirectPort)
		{
			global::Mirror.NetworkServer.SendToAll(new global::RoundRestarting.RoundRestartMessage(global::RoundRestarting.RoundRestartType.RedirectRestart, 0.1f, redirectPort, reconnect: true, extendedReconnectionPeriod: false));
			global::LabApi.Features.Wrappers.Round.Restart(fastRestart: false, overrideRestartAction: true, ServerStatic.NextRoundAction.Restart);
		}

		public static void Shutdown()
		{
			global::Shutdown.Quit();
		}

		public static void Shutdown(ushort redirectPort)
		{
			global::Mirror.NetworkServer.SendToAll(new global::RoundRestarting.RoundRestartMessage(global::RoundRestarting.RoundRestartType.RedirectRestart, 0.1f, redirectPort, reconnect: true, extendedReconnectionPeriod: false));
			Shutdown();
		}

		public static string RunCommand(string command, CommandSender? sender = null)
		{
			return ServerConsole.EnterCommand(command, sender);
		}

		public static void SendBroadcast(string message, ushort duration, Broadcast.BroadcastFlags type = Broadcast.BroadcastFlags.Normal, bool shouldClearPrevious = false)
		{
			if (shouldClearPrevious)
			{
				ClearBroadcasts();
			}
			Broadcast.Singleton.RpcAddElement(message, duration, type);
		}

		public static void SendBroadcast(global::LabApi.Features.Wrappers.Player player, string message, ushort duration, Broadcast.BroadcastFlags type = Broadcast.BroadcastFlags.Normal, bool shouldClearPrevious = false)
		{
			if (shouldClearPrevious)
			{
				ClearBroadcasts(player);
			}
			Broadcast.Singleton.TargetAddElement(player.Connection, message, duration, type);
		}

		public static void SendAdminChatMessage(string message, bool isSilent = false)
		{
			SendAdminChatMessage(global::System.Linq.Enumerable.Where(global::LabApi.Features.Wrappers.Player.ReadyList, (global::LabApi.Features.Wrappers.Player n) => n.UserGroup != null && PermissionsHandler.IsPermitted(n.UserGroup.Permissions, PlayerPermissions.AdminChat)), message, isSilent);
		}

		public static void SendAdminChatMessage(global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> targetPlayers, string message, bool isSilent = false)
		{
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			stringBuilder.Append(Host.NetworkId);
			stringBuilder.Append('!');
			if (isSilent)
			{
				stringBuilder.Append("@@");
			}
			stringBuilder.Append(message);
			string content = global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			foreach (global::LabApi.Features.Wrappers.Player targetPlayer in targetPlayers)
			{
				if (targetPlayer.IsPlayer && targetPlayer.IsReady)
				{
					targetPlayer.ReferenceHub.encryptedChannelManager.TrySendMessageToClient(content, EncryptedChannelManager.EncryptedChannel.AdminChat);
				}
			}
		}

		public static void ClearBroadcasts()
		{
			Broadcast.Singleton.RpcClearElements();
		}

		public static void ClearBroadcasts(global::LabApi.Features.Wrappers.Player player)
		{
			Broadcast.Singleton.TargetClearElements(player.Connection);
		}
	}
}
