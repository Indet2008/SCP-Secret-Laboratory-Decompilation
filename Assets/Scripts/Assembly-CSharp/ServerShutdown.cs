using System;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

public class ServerShutdown : MonoBehaviour
{
	public enum ServerShutdownState : byte
	{
		NotInitiated = 0,
		BroadcastingShutdown = 1,
		ShuttingDown = 2,
		Complete = 3
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct ServerShutdownMessage : NetworkMessage
	{
	}

	private static float _c;

	public static ServerShutdownState ShutdownState { get; set; }

	[RuntimeInitializeOnLoadMethod]
	private static void InitOnLoad()
	{
		CustomNetworkManager.OnClientReady += () =>
		{
			NetworkClient.ReplaceHandler<ServerShutdownMessage>(HandleServerShutdown);
		};
	}

	private void Update()
	{
		switch (ShutdownState)
		{
		default:
			return;
		case ServerShutdownState.NotInitiated:
		case ServerShutdownState.Complete:
			return;
		case ServerShutdownState.BroadcastingShutdown:
			if (_c > 400f)
			{
				ServerConsole.AddLog("Shutting down the server...", ConsoleColor.DarkCyan);
				ShutdownState = ServerShutdownState.ShuttingDown;
				_c = 0f;
				NetworkServer.Shutdown();
				return;
			}
			break;
		case ServerShutdownState.ShuttingDown:
			if (_c > 1000f)
			{
				ServerConsole.AddLog("Server shutdown completed.", ConsoleColor.DarkCyan);
				ShutdownState = ServerShutdownState.Complete;
				return;
			}
			break;
		}
		_c += Time.unscaledDeltaTime;
	}

	internal static void Shutdown(bool noBroadcast = false)
	{
		if (ShutdownState != ServerShutdownState.NotInitiated)
		{
			return;
		}
		if (!NetworkServer.active)
		{
			ShutdownState = ServerShutdownState.Complete;
			return;
		}
		ServerConsole.AddLog("Server shutdown initiated.", ConsoleColor.DarkCyan);
		ShutdownState = ServerShutdownState.BroadcastingShutdown;
		IdleMode.SetIdleMode(state: false);
		CustomLiteNetLib4MirrorTransport.DelayConnections = true;
		CustomNetworkManager.QueryServer?.StopServer();
		if (!noBroadcast && !noBroadcast)
		{
			ServerConsole.AddLog("Broadcasting server shutdown to all connected players...", ConsoleColor.DarkCyan);
			NetworkServer.SendToAll<ServerShutdownMessage>(default, 4, sendToReadyOnly: true);
		}
	}

	private static void HandleServerShutdown(ServerShutdownMessage ssm)
	{
	}
}
