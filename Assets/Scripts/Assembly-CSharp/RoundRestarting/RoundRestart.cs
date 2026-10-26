using System;
using CentralAuth;
using GameCore;
using GameObjectPools;
using InventorySystem;
using LabApi.Events.Handlers;
using Mirror;
using NetworkManagerUtils.Dummies;
using ServerOutput;
using UnityEngine;

namespace RoundRestarting
{
	public static class RoundRestart
	{
		private const string RoundrestartTimeKey = "LastRoundrestartTime";

		private static DateTime _lastRestartTime;

		public static bool IsRoundRestarting { get; private set; }

		public static int UptimeRounds { get; private set; }

		private static int LastRestartTime => PlayerPrefsSl.Get("LastRoundrestartTime", 5000);

		public static event Action OnRestartTriggered;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnServerStarted += OnServerStarted;
			Inventory.OnLocalClientStarted += OnClientStarted;
		}

		private static void OnMessageReceived(RoundRestartMessage msg)
		{
		}

		private static void OnClientStarted()
		{
			IsRoundRestarting = false;
			NetworkClient.ReplaceHandler<RoundRestartMessage>(OnMessageReceived);
		}

		private static void OnServerStarted()
		{
			TimeSpan timeSpan = DateTime.Now - _lastRestartTime;
			if (!(timeSpan.TotalSeconds > 20.0))
			{
				PlayerPrefsSl.Set("LastRoundrestartTime", (LastRestartTime + (int)timeSpan.TotalMilliseconds) / 2);
			}
		}

		public static void InitiateRoundRestart()
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Round restart can only be triggerred by the server!");
			}
			ServerEvents.OnRoundRestarted();
			PoolManager.Singleton.ReturnAllPoolObjects();
			if (IsRoundRestarting)
			{
				return;
			}
			IsRoundRestarting = true;
			CustomLiteNetLib4MirrorTransport.DelayConnections = true;
			CustomLiteNetLib4MirrorTransport.UserIdFastReload.Clear();
			IdleMode.PauseIdleMode = true;
			if (ServerStatic.StopNextRound == ServerStatic.NextRoundAction.DoNothing)
			{
				if (CustomNetworkManager.EnableFastRestart)
				{
					foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
					{
						ClientInstanceMode mode = allHub.Mode;
						if (mode != ClientInstanceMode.DedicatedServer && mode != ClientInstanceMode.Dummy)
						{
							try
							{
								CustomLiteNetLib4MirrorTransport.UserIdFastReload.TryAdd(allHub.authManager.UserId, 0);
							}
							catch (Exception ex)
							{
								ServerConsole.AddLog("Exception occured during processing online player list for Fast Restart: " + ex.Message, ConsoleColor.Yellow);
							}
						}
					}
					NetworkServer.SendToAll(new RoundRestartMessage(RoundRestartType.FastRestart, 0f, 0, reconnect: true, extendedReconnectionPeriod: true));
					ChangeLevel(noShutdownMessage: false);
					return;
				}
				float offset = (float)LastRestartTime / 1000f;
				NetworkServer.SendToAll(new RoundRestartMessage(RoundRestartType.FullRestart, offset, 0, reconnect: true, extendedReconnectionPeriod: true));
			}
			ChangeLevel(noShutdownMessage: false);
		}

		internal static void ChangeLevel(bool noShutdownMessage)
		{
			if (!NetworkServer.active)
			{
				NetworkManager.singleton.StopClient();
				return;
			}
			IdleMode.PauseIdleMode = true;
			bool flag = false;
			OnRestartTriggered?.Invoke();
			try
			{
				int num = ConfigFile.ServerConfig.GetInt("restart_after_rounds");
				flag = num > 0 && UptimeRounds >= num;
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog("Failed to check the restart_after_rounds config value: " + ex.Message, ConsoleColor.Red);
			}
			switch (ServerStatic.StopNextRound)
			{
			case ServerStatic.NextRoundAction.DoNothing:
				if (!flag)
				{
					break;
				}
				goto case ServerStatic.NextRoundAction.Restart;
			case ServerStatic.NextRoundAction.Restart:
			{
				ServerShutdown.ShutdownState = ServerShutdown.ServerShutdownState.Complete;
				ServerConsole.AddOutputEntry(default(ExitActionRestartEntry));
				if (!noShutdownMessage)
				{
					ServerConsole.AddLog(flag ? "Restarting the server (rounds limit set in the server config exceeded)..." : "Restarting the server (RestartNextRound command was used)...");
				}
				float offset = ConfigFile.ServerConfig.GetInt("full_restart_rejoin_time", 25);
				NetworkServer.SendToAll(new RoundRestartMessage(RoundRestartType.FullRestart, offset, 0, reconnect: true, extendedReconnectionPeriod: true), 4, sendToReadyOnly: true);
				Shutdown.Quit(quit: true, suppressShutdownBroadcast: true);
				return;
			}
			case ServerStatic.NextRoundAction.Shutdown:
				ServerConsole.AddOutputEntry(default(ExitActionShutdownEntry));
				if (!noShutdownMessage)
				{
					ServerConsole.AddLog("Shutting down the server (StopNextRound command was used)...");
				}
				if (ServerStatic.ShutdownRedirectPort != 0)
				{
					if (!noShutdownMessage)
					{
						ServerConsole.AddLog($"Redirecting players to port {ServerStatic.ShutdownRedirectPort}...");
					}
					NetworkServer.SendToAll(new RoundRestartMessage(RoundRestartType.RedirectRestart, 0.1f, ServerStatic.ShutdownRedirectPort, reconnect: true, extendedReconnectionPeriod: false), 4, sendToReadyOnly: true);
					Shutdown.Quit(quit: true, suppressShutdownBroadcast: true);
				}
				else
				{
					Shutdown.Quit();
				}
				return;
			}
			DummyUtils.DestroyAllDummies();
			GC.Collect();
			_lastRestartTime = DateTime.Now;
			UptimeRounds++;
			NetworkManager.singleton.ServerChangeScene(NetworkManager.singleton.onlineScene);
		}
	}
}
