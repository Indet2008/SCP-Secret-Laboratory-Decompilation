using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Net;
using CentralAuth;
using Interactables;
using LightContainmentZoneDecontamination;
using Query;
using Security;
using UnityEngine;

namespace GameCore
{
	public static class ConfigFile
	{
		public static Action OnConfigReloaded;

		public static YamlConfig ServerConfig;

		public static YamlConfig SharingConfig;

		public static YamlConfig HosterPolicy;

		private static bool _loaded;

		static ConfigFile()
		{
			ServerStatic.ProcessServerArgs();
			if (!Directory.Exists(FileManager.GetAppFolder()))
			{
				Directory.CreateDirectory(FileManager.GetAppFolder());
			}
			if (File.Exists(FileManager.GetAppFolder() + "config.txt") && !File.Exists(FileManager.GetAppFolder() + "LEGACY CONFIG BACKUP - NOT WORKING.txt"))
			{
				File.Move(FileManager.GetAppFolder() + "config.txt", FileManager.GetAppFolder() + "LEGACY CONFIG BACKUP - NOT WORKING.txt");
			}
			ReloadGameConfigs(firstTime: true);
		}

		public static void ReloadGameConfigs(bool firstTime = false)
		{
			if (firstTime && _loaded)
			{
				return;
			}
			_loaded = true;
			ServerConsole.AddLog("Loading gameplay config...");
			string configPath = GetConfigPath("config_gameplay");
			if (ServerConfig == null)
			{
				ServerConfig = new YamlConfig(configPath);
			}
			else
			{
				ServerConfig.LoadConfigFile(configPath);
			}
			ServerConsole.RefreshEmailSetStatus();
			ServerConsole.AddLog("Processing rate limits...");
			RateLimitCreator.Load();
			ServerConsole.AddLog("Loading sharing config...");
			string configPath2 = GetConfigPath("config_sharing");
			if (SharingConfig == null)
			{
				SharingConfig = new YamlConfig(configPath2);
			}
			else
			{
				SharingConfig.LoadConfigFile(configPath2);
			}
			ServerConsole.AddLog("Processing shares...");
			ConfigSharing.Reload();
			BanHandler.Init();
			WhiteList.Reload();
			ReservedSlot.Reload();
			QueryServer.ReloadConfig();
			ServerStatic.ServerTickrate = ServerConfig.GetShort("server_tickrate", 60);
			IdleMode.IdleModeEnabled = ServerConfig.GetBool("idle_mode_enabled", def: true);
			IdleMode.IdleModeTime = ServerConfig.GetUInt("idle_mode_time", 5000u);
			IdleMode.IdleModePreauthTime = ServerConfig.GetUInt("idle_mode_preauth_time", 30000u);
			IdleMode.IdleModeTickrate = ServerConfig.GetShort("idle_mode_tickrate", 1);
			ServerConsole.PortOverride = ServerConfig.GetUShort("server_list_port_override", 0);
			ServerConsole.FriendlyFire = ServerConfig.GetBool("friendly_fire");
			ServerConsole.WhiteListEnabled = ServerConfig.GetBool("enable_whitelist") || ServerConfig.GetBool("custom_whitelist");
			ServerConsole.AccessRestriction = ServerConfig.GetBool("server_access_restriction");
			ServerConsole.TransparentlyModdedServerConfig = ServerConfig.GetBool("transparently_modded_server");
			ServerConsole.RateLimitKick = ServerConfig.GetBool("ratelimit_kick", def: true);
			ServerConsole.EnforceSameIp = ServerConfig.GetBool("enforce_same_ip", def: true);
			ServerConsole.SkipEnforcementForLocalAddresses = ServerConfig.GetBool("no_enforcement_for_local_ip_addresses", def: true);
			CustomNetworkManager.EnableFastRestart = ServerConfig.GetBool("enable_fast_round_restart");
			CustomNetworkManager.FastRestartDelay = ServerConfig.GetFloat("fast_round_restart_delay", 3.2f);
			// Editor play hosts without the central server (its client auth path was stripped), so force offline mode there.
			PlayerAuthenticationManager.OnlineMode = !Application.isEditor && ServerConfig.GetBool("online_mode", def: true);
			PlayerAuthenticationManager.AuthenticationTimeout = ServerConfig.GetUInt("authentication_timeout", 45u);
			PlayerAuthenticationManager.AllowSameAccountJoining = ServerConfig.GetBool("same_account_joining");
			EncryptedChannelManager.CryptographyDebug = ServerConfig.GetBool("enable_crypto_debug");
			if (EncryptedChannelManager.CryptographyDebug)
			{
				ServerConsole.AddLog("WARNING - Cryptography Debug is enabled! THIS IS A SECURITY RISK if used on a public server (admins can seriously abuse this feature)! You can disable this by setting 'enable_crypto_debug' to false in your gameplay config file.", ConsoleColor.Yellow);
			}
			CharacterClassManager.CuffedChangeTeam = ServerConfig.GetBool("cuffed_escapee_change_team", def: true);
			CharacterClassManager.EnableSyncServerCmdBinding = ServerConfig.GetBool("enable_sync_command_binding");
			PocketDimensionTeleport.RefreshExit = ServerConfig.GetBool("pd_refresh_exit");
			AlphaWarheadController.AutoWarheadBroadcastEnabled = ServerConfig.GetBool("auto_warhead_broadcast_enabled", def: true);
			AlphaWarheadController.WarheadBroadcastMessage = ServerConfig.GetString("auto_warhead_broadcast_message", "The Alpha Warhead is being detonated");
			AlphaWarheadController.WarheadBroadcastMessageTime = ServerConfig.GetUShort("auto_warhead_broadcast_time", 10);
			AlphaWarheadController.WarheadExplodedBroadcastMessage = ServerConfig.GetString("auto_warhead_detonate_broadcast", "The Alpha Warhead has been detonated");
			AlphaWarheadController.WarheadExplodedBroadcastMessageTime = ServerConfig.GetUShort("auto_warhead_detonate_broadcast_time", 10);
			AlphaWarheadController.LockGatesOnCountdown = ServerConfig.GetBool("lock_gates_on_countdown", def: true);
			DecontaminationController.AutoDeconBroadcastEnabled = ServerConfig.GetBool("auto_decon_broadcast_enabled");
			DecontaminationController.DeconBroadcastDeconMessage = ServerConfig.GetString("auto_decon_broadcast_message", "Light Containment Zone is being decontaminated");
			DecontaminationController.DeconBroadcastDeconMessageTime = ServerConfig.GetUShort("auto_decon_broadcast_time", 10);
			CustomLiteNetLib4MirrorTransport.DisplayPreauthLogs = ServerConfig.GetBool("display_preauth_logs", def: true);
			CustomLiteNetLib4MirrorTransport.DelayTime = ServerConfig.GetByte("connections_delay_time", 5);
			CustomLiteNetLib4MirrorTransport.IpRateLimiting = ServerConfig.GetBool("enable_ip_ratelimit", def: true);
			CustomLiteNetLib4MirrorTransport.UserRateLimiting = ServerConfig.GetBool("enable_userid_ratelimit", def: true);
			CustomLiteNetLib4MirrorTransport.GeoblockIgnoreWhitelisted = ServerConfig.GetBool("geoblocking_ignore_whitelisted", def: true);
			CustomLiteNetLib4MirrorTransport.RejectionThreshold = ServerConfig.GetUInt("rejection_suppression_threshold", 60u);
			CustomLiteNetLib4MirrorTransport.IssuedThreshold = ServerConfig.GetUInt("challenge_issuance_suppression_threshold", 50u);
			CustomLiteNetLib4MirrorTransport.ReloadChallengeOptions();
			CustomLiteNetLib4MirrorTransport.GeoblockingList.Clear();
			string text = ServerConfig.GetString("geoblocking_mode", "none");
			if (!(text == "whitelist"))
			{
				if (text == "blacklist")
				{
					CustomLiteNetLib4MirrorTransport.Geoblocking = GeoblockingMode.Blacklist;
					foreach (string @string in ServerConfig.GetStringList("geoblocking_blacklist"))
					{
						CustomLiteNetLib4MirrorTransport.GeoblockingList.TryAdd(@string.ToUpperInvariant(), 0);
					}
				}
				else
				{
					CustomLiteNetLib4MirrorTransport.Geoblocking = GeoblockingMode.None;
				}
			}
			else
			{
				CustomLiteNetLib4MirrorTransport.Geoblocking = GeoblockingMode.Whitelist;
				foreach (string string2 in ServerConfig.GetStringList("geoblocking_whitelist"))
				{
					CustomLiteNetLib4MirrorTransport.GeoblockingList.TryAdd(string2.ToUpperInvariant(), 0);
				}
			}
			CustomLiteNetLib4MirrorTransport.IpPassthroughEnabled = PlayerAuthenticationManager.OnlineMode && ServerConfig.GetBool("enable_proxy_ip_passthrough");
			if (CustomLiteNetLib4MirrorTransport.IpPassthroughEnabled)
			{
				if (CustomLiteNetLib4MirrorTransport.TrustedProxies == null)
				{
					CustomLiteNetLib4MirrorTransport.TrustedProxies = new ConcurrentDictionary<IPAddress, byte>();
				}
				else
				{
					CustomLiteNetLib4MirrorTransport.TrustedProxies.Clear();
				}
				foreach (string string3 in ServerConfig.GetStringList("trusted_proxies_ip_addresses"))
				{
					if (IPAddress.TryParse(string3, out var address))
					{
						CustomLiteNetLib4MirrorTransport.TrustedProxies.TryAdd(address, 0);
					}
					else
					{
						ServerConsole.AddLog("Couldn't parse trusted proxy IP address: " + string3, ConsoleColor.Red);
					}
				}
				if (CustomLiteNetLib4MirrorTransport.TrustedProxies.Count == 0)
				{
					CustomLiteNetLib4MirrorTransport.IpPassthroughEnabled = false;
					CustomLiteNetLib4MirrorTransport.TrustedProxies = null;
					CustomLiteNetLib4MirrorTransport.RealIpAddresses = null;
				}
				else if (CustomLiteNetLib4MirrorTransport.RealIpAddresses == null)
				{
					CustomLiteNetLib4MirrorTransport.RealIpAddresses = new ConcurrentDictionary<int, string>(new Dictionary<int, string>());
				}
			}
			else
			{
				CustomLiteNetLib4MirrorTransport.TrustedProxies = null;
				CustomLiteNetLib4MirrorTransport.RealIpAddresses = null;
			}
			CustomLiteNetLib4MirrorTransport.UseReservedSlots = ServerConfig.GetBool("use_reserved_slots", def: true);
			CheaterReport.WebhookUrl = ServerConfig.GetString("report_discord_webhook_url", string.Empty);
			CheaterReport.WebhookUsername = ServerConfig.GetString("report_username", "Cheater Report");
			CheaterReport.WebhookAvatar = ServerConfig.GetString("report_avatar_url", string.Empty);
			CheaterReport.WebhookColor = ServerConfig.GetInt("report_color", 14423100);
			CheaterReport.ServerName = ServerConfig.GetString("report_server_name", "My SCP:SL Server");
			CheaterReport.ReportHeader = ServerConfig.GetString("report_header", "Player Report");
			CheaterReport.ReportContent = ServerConfig.GetString("report_content", "Player has just been reported.");
			CheaterReport.SendReportsByWebhooks = ServerConfig.GetBool("report_send_using_discord_webhook") && !string.IsNullOrWhiteSpace(CheaterReport.WebhookUrl) && !string.IsNullOrWhiteSpace(CheaterReport.WebhookUsername);
			InteractionCoordinator.CanDisarmedInteract = ServerConfig.GetBool("allow_disarmed_interaction");
			FriendlyFireConfig.RoundEnabled = ServerConfig.GetBool("ff_detector_round_enabled", def: true);
			FriendlyFireConfig.LifeEnabled = ServerConfig.GetBool("ff_detector_life_enabled", def: true);
			FriendlyFireConfig.WindowEnabled = ServerConfig.GetBool("ff_detector_window_enabled", def: true);
			FriendlyFireConfig.RespawnEnabled = ServerConfig.GetBool("ff_detector_spawn_enabled", def: true);
			FriendlyFireConfig.ExplosionAfterDisconnecting = ServerConfig.GetBool("ff_detector_explosion_after_disconnecting_enabled", def: true);
			FriendlyFireConfig.RoundAction = FriendlyFireConfig.ParseAction(ServerConfig.GetString("ff_detector_round_action", "ban"));
			FriendlyFireConfig.LifeAction = FriendlyFireConfig.ParseAction(ServerConfig.GetString("ff_detector_life_action", "ban"));
			FriendlyFireConfig.WindowAction = FriendlyFireConfig.ParseAction(ServerConfig.GetString("ff_detector_window_action", "ban"));
			FriendlyFireConfig.RespawnAction = FriendlyFireConfig.ParseAction(ServerConfig.GetString("ff_detector_spawn_action", "ban"));
			FriendlyFireConfig.ExplosionAfterDisconnectingAction = FriendlyFireConfig.ParseAction(ServerConfig.GetString("ff_detector_explosion_after_disconnecting_action", "ban"));
			if (FriendlyFireConfig.ExplosionAfterDisconnectingAction == FriendlyFireAction.Kick || FriendlyFireConfig.ExplosionAfterDisconnectingAction == FriendlyFireAction.Kill)
			{
				FriendlyFireConfig.ExplosionAfterDisconnectingAction = FriendlyFireAction.Noop;
				Console.AddLog("Actions \"Kick\" and \"Kill\" are invalid for \"ff_detector_explosion_after_disconnecting_action\". Replaced with \"noop\".", Color.red);
			}
			FriendlyFireConfig.RoundKillThreshold = ServerConfig.GetUInt("ff_detector_round_kills", 6u);
			FriendlyFireConfig.LifeKillThreshold = ServerConfig.GetUInt("ff_detector_life_kills", 4u);
			FriendlyFireConfig.WindowKillThreshold = ServerConfig.GetUInt("ff_detector_window_kills", 3u);
			FriendlyFireConfig.RespawnKillThreshold = ServerConfig.GetUInt("ff_detector_spawn_kills", 2u);
			FriendlyFireConfig.RoundDamageThreshold = ServerConfig.GetUInt("ff_detector_round_damage", 500u);
			FriendlyFireConfig.LifeDamageThreshold = ServerConfig.GetUInt("ff_detector_life_damage", 300u);
			FriendlyFireConfig.WindowDamageThreshold = ServerConfig.GetUInt("ff_detector_window_damage", 250u);
			FriendlyFireConfig.RespawnDamageThreshold = ServerConfig.GetUInt("ff_detector_spawn_damage", 180u);
			try
			{
				FriendlyFireConfig.RoundBanTime = Misc.RelativeTimeToSeconds(ServerConfig.GetString("ff_detector_round_ban_time", "24h"));
				FriendlyFireConfig.LifeBanTime = Misc.RelativeTimeToSeconds(ServerConfig.GetString("ff_detector_life_ban_time", "24h"));
				FriendlyFireConfig.WindowBanTime = Misc.RelativeTimeToSeconds(ServerConfig.GetString("ff_detector_window_ban_time", "16h"));
				FriendlyFireConfig.RespawnBanTime = Misc.RelativeTimeToSeconds(ServerConfig.GetString("ff_detector_spawn_ban_time", "48h"));
				FriendlyFireConfig.ExplosionAfterDisconnectingTime = Misc.RelativeTimeToSeconds(ServerConfig.GetString("ff_detector_explosion_after_disconnecting_ban_time", "48h"));
			}
			catch
			{
				FriendlyFireConfig.RoundBanTime = 86400L;
				FriendlyFireConfig.LifeBanTime = 86400L;
				FriendlyFireConfig.WindowBanTime = 57600L;
				FriendlyFireConfig.RespawnBanTime = 172800L;
				FriendlyFireConfig.ExplosionAfterDisconnectingTime = 172800L;
				Console.AddLog("Failed to parse Friendly Fire Detector ban times. Using default values...", Color.red);
			}
			FriendlyFireConfig.RoundBanReason = ServerConfig.GetString("ff_detector_round_bankick_reason", "You have been automatically banned for teamkilling.");
			FriendlyFireConfig.LifeBanReason = ServerConfig.GetString("ff_detector_life_bankick_reason", "You have been automatically banned for teamkilling.");
			FriendlyFireConfig.WindowBanReason = ServerConfig.GetString("ff_detector_window_bankick_reason", "You have been automatically banned for teamkilling.");
			FriendlyFireConfig.RespawnBanReason = ServerConfig.GetString("ff_detector_spawn_bankick_reason", "You have been automatically banned for teamkilling.");
			FriendlyFireConfig.ExplosionAfterDisconnectingBanReason = ServerConfig.GetString("ff_detector_explosion_after_disconnecting_bankick_reason", "You have been automatically banned for teamkilling.");
			FriendlyFireConfig.RoundKillReason = ServerConfig.GetString("ff_detector_round_kill_reason", "You have been automatically killed for teamkilling.");
			FriendlyFireConfig.LifeKillReason = ServerConfig.GetString("ff_detector_life_kill_reason", "You have been automatically killed for teamkilling.");
			FriendlyFireConfig.WindowKillReason = ServerConfig.GetString("ff_detector_window_kill_reason", "You have been automatically killed for teamkilling.");
			FriendlyFireConfig.RespawnKillReason = ServerConfig.GetString("ff_detector_spawn_kill_reason", "You have been automatically killed for teamkilling.");
			FriendlyFireConfig.RoundAdminMessage = (ServerConfig.GetBool("ff_detector_round_adminchat_enable") ? ServerConfig.GetString("ff_detector_round_adminchat_message", "%nick has been banned for teamkilling (round detector).") : null);
			FriendlyFireConfig.LifeAdminMessage = (ServerConfig.GetBool("ff_detector_life_adminchat_enable") ? ServerConfig.GetString("ff_detector_life_adminchat_message", "%nick has been banned for teamkilling (life detector).") : null);
			FriendlyFireConfig.WindowAdminMessage = (ServerConfig.GetBool("ff_detector_window_adminchat_enable") ? ServerConfig.GetString("ff_detector_window_adminchat_message", "%nick has been banned for teamkilling (window detector).") : null);
			FriendlyFireConfig.RespawnAdminMessage = (ServerConfig.GetBool("ff_detector_spawn_adminchat_enable") ? ServerConfig.GetString("ff_detector_spawn_adminchat_message", "%nick has been banned for teamkilling (spawn detector).") : null);
			FriendlyFireConfig.ExplosionAfterDisconnectingAdminMessage = (ServerConfig.GetBool("ff_detector_explosion_after_disconnecting_adminchat_enable") ? ServerConfig.GetString("ff_detector_explosion_after_disconnecting_adminchat_message", "%nick has been banned for teamkilling (explosion after disconnecting detector).") : null);
			FriendlyFireConfig.RoundBroadcastMessage = (ServerConfig.GetBool("ff_detector_round_broadcast_enable") ? ServerConfig.GetString("ff_detector_round_broadcast_message", "%nick has been automatically banned for teamkilling.") : null);
			FriendlyFireConfig.LifeBroadcastMessage = (ServerConfig.GetBool("ff_detector_life_broadcast_enable") ? ServerConfig.GetString("ff_detector_life_broadcast_message", "%nick has been automatically banned for teamkilling.") : null);
			FriendlyFireConfig.WindowBroadcastMessage = (ServerConfig.GetBool("ff_detector_window_broadcast_enable") ? ServerConfig.GetString("ff_detector_window_broadcast_message", "%nick has been automatically banned for teamkilling.") : null);
			FriendlyFireConfig.RespawnBroadcastMessage = (ServerConfig.GetBool("ff_detector_spawn_broadcast_enable") ? ServerConfig.GetString("ff_detector_spawn_broadcast_message", "%nick has been automatically banned for teamkilling.") : null);
			FriendlyFireConfig.ExplosionAfterDisconnectingBroadcastMessage = (ServerConfig.GetBool("ff_detector_explosion_after_disconnecting_broadcast_enable") ? ServerConfig.GetString("ff_detector_explosion_after_disconnecting_broadcast_message", "%nick has been automatically banned for teamkilling.") : null);
			FriendlyFireConfig.RoundWebhook = ServerConfig.GetBool("ff_detector_round_webhook_report", def: true);
			FriendlyFireConfig.LifeWebhook = ServerConfig.GetBool("ff_detector_life_webhook_report", def: true);
			FriendlyFireConfig.WindowWebhook = ServerConfig.GetBool("ff_detector_window_webhook_report", def: true);
			FriendlyFireConfig.RespawnWebhook = ServerConfig.GetBool("ff_detector_spawn_webhook_report", def: true);
			FriendlyFireConfig.ExplosionAfterDisconnectingWebhook = ServerConfig.GetBool("ff_detector_explosion_after_disconnecting_webhook_report", def: true);
			FriendlyFireConfig.BroadcastTime = ServerConfig.GetUShort("ff_detector_global_broadcast_seconds", 5);
			FriendlyFireConfig.AdminChatTime = ServerConfig.GetUShort("ff_detector_global_adminchat_seconds", 6);
			FriendlyFireConfig.Window = ServerConfig.GetUInt("ff_detector_window_seconds", 180u);
			FriendlyFireConfig.RespawnWindow = ServerConfig.GetUInt("ff_detector_spawn_window_seconds", 120u);
			FriendlyFireConfig.IgnoreClassDTeamkills = ServerConfig.GetBool("ff_detector_classD_can_damage_classD");
			FriendlyFireConfig.WebhookUrl = ServerConfig.GetString("ff_detector_webhook_url", "none");
			if (FriendlyFireConfig.WebhookUrl == "none")
			{
				FriendlyFireConfig.WebhookUrl = CheaterReport.WebhookUrl;
			}
			CustomNetworkManager.ReloadTimeWindows();
			ServerConsole.ReloadServerName();
			ServerConfigSynchronizer.RefreshAllConfigs();
			OnConfigReloaded?.Invoke();
		}

		public static string GetConfigPath(string name)
		{
			string appFolder = FileManager.GetAppFolder(addSeparator: true, serverConfig: true);
			if (!Directory.Exists(appFolder))
			{
				Directory.CreateDirectory(appFolder);
			}
			if (File.Exists(appFolder + name + ".txt"))
			{
				return appFolder + name + ".txt";
			}
			try
			{
				File.Copy("ConfigTemplates/" + name + ".template.txt", appFolder + name + ".txt");
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Error during copying config file: " + ex.Message);
				return null;
			}
			return appFolder + name + ".txt";
		}
	}
}
