using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using CentralAuth;
using Cmdbinding;
using GameCore;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MEC;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using Mirror.RemoteCalls;
using PlayerStatsSystem;
using Security;
using ServerOutput;
using UnityEngine;

public class CharacterClassManager : NetworkBehaviour
{
	private ReferenceHub _hub;

	[NonSerialized]
	private bool _godMode;

	private bool _wasAnytimeAlive;

	internal static bool EnableSyncServerCmdBinding;

	[SyncVar]
	public string Pastebin;

	[SyncVar(hook = "MaxPlayersHook")]
	public ushort MaxPlayers;

	internal static bool CuffedChangeTeam;

	[SyncVar]
	public bool RoundStarted;

	private RateLimit _commandRateLimit;

	public bool GodMode
	{
		get
		{
			return _godMode;
		}
		set
		{
			_godMode = value;
			_hub.playerStats.GetModule<AdminFlagsStat>().SetFlag(AdminFlags.GodMode, value);
		}
	}

	public string NetworkPastebin
	{
		get
		{
			return Pastebin;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref Pastebin, 1uL, null);
		}
	}

	public ushort NetworkMaxPlayers
	{
		get
		{
			return MaxPlayers;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref MaxPlayers, 2uL, MaxPlayersHook);
		}
	}

	public bool NetworkRoundStarted
	{
		get
		{
			return RoundStarted;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref RoundStarted, 4uL, null);
		}
	}

	public static event Action OnRoundStarted;

	public static event Action ServerOnRoundStartTriggered;

	public static event Action ServerWaitingForPlayers;

	public static event Action<ushort> OnMaxPlayersChanged;

	private void Start()
	{
		_hub = ReferenceHub.GetHub(this);
		if (!NetworkServer.active)
		{
			return;
		}
		_commandRateLimit = _hub.playerRateLimitHandler.RateLimits[1];
		if (base.isLocalPlayer)
		{
			ServerLogs.StartLogging();
			FriendlyFireConfig.PauseDetector = false;
			CustomLiteNetLib4MirrorTransport.DelayConnections = false;
			IdleMode.PauseIdleMode = false;
			ServerConsole.AddOutputEntry(default(RoundRestartedEntry));
			NetworkPastebin = ConfigFile.ServerConfig.GetString("serverinfo_pastebin_id");
			if (NetworkServer.active)
			{
				ServerWaitingForPlayers?.Invoke();
				ServerEvents.OnWaitingForPlayers();
				ServerConsole.AddLog("Waiting for players...");
			}
			StartCoroutine(Init());
		}
	}

	private void Update()
	{
		if (base.isLocalPlayer && NetworkServer.active && MaxPlayers != (ushort)CustomNetworkManager.slots)
		{
			NetworkMaxPlayers = (ushort)CustomNetworkManager.slots;
		}
	}

	private void MaxPlayersHook(ushort prev, ushort cur)
	{
		if (prev != cur)
		{
			OnMaxPlayersChanged?.Invoke(cur);
		}
	}

	public void SyncServerCmdBinding()
	{
		if (!base.isServer || !EnableSyncServerCmdBinding)
		{
			return;
		}
		foreach (Bind binding in CmdBinding.Bindings)
		{
			if (binding.Command.StartsWith('.') || binding.Command.StartsWith('/'))
			{
				TargetChangeCmdBinding(binding.Key, binding.Command);
			}
		}
	}

	[TargetRpc]
	public void TargetChangeCmdBinding(KeyCode code, string cmd)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		GeneratedNetworkCode._Write_UnityEngine_002EKeyCode(writer, code);
		writer.WriteString(cmd);
		SendTargetRPCInternal(null, "System.Void CharacterClassManager::TargetChangeCmdBinding(UnityEngine.KeyCode,System.String)", -1033122126, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	private IEnumerator Init()
	{
		if (NonFacilityCompatibility.currentSceneSettings.roundAutostart)
		{
			ForceRoundStart();
		}
		else
		{
			short originalTimeLeft = ConfigFile.ServerConfig.GetShort("lobby_waiting_time", 20);
			short timeLeft = originalTimeLeft;
			int topPlayers = 2;
			while (RoundStart.singleton.Timer != -1)
			{
				if (timeLeft == -2)
				{
					timeLeft = originalTimeLeft;
				}
				int playerCount = ReferenceHub.GetPlayerCount(ClientInstanceMode.ReadyClient, ClientInstanceMode.Host, ClientInstanceMode.Dummy);
				if (!RoundStart.LobbyLock && playerCount > 1)
				{
					if (playerCount > topPlayers)
					{
						topPlayers = playerCount;
						if (timeLeft < originalTimeLeft)
						{
							do
							{
								timeLeft++;
							}
							while (timeLeft % 5 == 0 && timeLeft < originalTimeLeft);
						}
					}
					else
					{
						timeLeft--;
					}
					if (playerCount >= ((CustomNetworkManager)NetworkManager.singleton).ReservedMaxPlayers)
					{
						timeLeft = -1;
					}
					if (timeLeft == -1)
					{
						ForceRoundStart();
					}
				}
				else
				{
					timeLeft = -2;
				}
				if (RoundStart.singleton.Timer != -1)
				{
					RoundStart.singleton.NetworkTimer = timeLeft;
				}
				yield return new WaitForSeconds(1f);
			}
		}
		NetworkRoundStarted = true;
		ServerEvents.OnRoundStarted();
		ServerOnRoundStartTriggered?.Invoke();
		RpcRoundStarted();
	}

	public static bool ForceRoundStart()
	{
		if (!NetworkServer.active)
		{
			return false;
		}
		RoundStartingEventArgs e = new RoundStartingEventArgs();
		ServerEvents.OnRoundStarting(e);
		if (!e.IsAllowed)
		{
			return false;
		}
		ServerLogs.AddLog(ServerLogs.Modules.GameLogic, "Round has been started.", ServerLogs.ServerLogType.GameEvent);
		ServerConsole.AddLog("New round has been started.");
		RoundStart.singleton.NetworkTimer = -1;
		RoundStart.RoundStartTimer.Restart();
		return true;
	}

	[TargetRpc]
	private void TargetSetDisconnectError(NetworkConnection conn, string message)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		writer.WriteString(message);
		SendTargetRPCInternal(conn, "System.Void CharacterClassManager::TargetSetDisconnectError(Mirror.NetworkConnection,System.String)", -2106075371, writer, 0);
		NetworkWriterPool.Return(writer);
	}

	[Command(channel = 4)]
	private void CmdConfirmDisconnect()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendCommandInternal("System.Void CharacterClassManager::CmdConfirmDisconnect()", 460932189, writer, 4);
		NetworkWriterPool.Return(writer);
	}

	public void DisconnectClient(NetworkConnection conn, string message)
	{
		TargetSetDisconnectError(conn, message);
		Timing.RunCoroutine(_DisconnectAfterTimeout(conn), Segment.FixedUpdate);
	}

	private static IEnumerator<float> _DisconnectAfterTimeout(NetworkConnection conn)
	{
		for (int i = 0; i < 150; i++)
		{
			yield return 0f;
		}
		conn?.Disconnect();
	}

	[ClientRpc]
	private void RpcRoundStarted()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void CharacterClassManager::RpcRoundStarted()", -2093950497, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	static CharacterClassManager()
	{
		CuffedChangeTeam = true;
		RemoteProcedureCalls.RegisterCommand(typeof(CharacterClassManager), "System.Void CharacterClassManager::CmdConfirmDisconnect()", InvokeUserCode_CmdConfirmDisconnect, requiresAuthority: true);
		RemoteProcedureCalls.RegisterRpc(typeof(CharacterClassManager), "System.Void CharacterClassManager::RpcRoundStarted()", InvokeUserCode_RpcRoundStarted);
		RemoteProcedureCalls.RegisterRpc(typeof(CharacterClassManager), "System.Void CharacterClassManager::TargetChangeCmdBinding(UnityEngine.KeyCode,System.String)", InvokeUserCode_TargetChangeCmdBinding__KeyCode__String);
		RemoteProcedureCalls.RegisterRpc(typeof(CharacterClassManager), "System.Void CharacterClassManager::TargetSetDisconnectError(Mirror.NetworkConnection,System.String)", InvokeUserCode_TargetSetDisconnectError__NetworkConnection__String);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_TargetChangeCmdBinding__KeyCode__String(KeyCode code, string cmd)
	{
	}

	protected static void InvokeUserCode_TargetChangeCmdBinding__KeyCode__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetChangeCmdBinding called on server.");
		}
		else
		{
			((CharacterClassManager)obj).UserCode_TargetChangeCmdBinding__KeyCode__String(GeneratedNetworkCode._Read_UnityEngine_002EKeyCode(reader), reader.ReadString());
		}
	}

	protected void UserCode_TargetSetDisconnectError__NetworkConnection__String(NetworkConnection conn, string message)
	{
		((CustomNetworkManager)LiteNetLib4MirrorNetworkManager.singleton).disconnectMessage = message;
		CmdConfirmDisconnect();
	}

	protected static void InvokeUserCode_TargetSetDisconnectError__NetworkConnection__String(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("TargetRPC TargetSetDisconnectError called on server.");
		}
		else
		{
			((CharacterClassManager)obj).UserCode_TargetSetDisconnectError__NetworkConnection__String(null, reader.ReadString());
		}
	}

	protected void UserCode_CmdConfirmDisconnect()
	{
		base.connectionToClient?.Disconnect();
	}

	protected static void InvokeUserCode_CmdConfirmDisconnect(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkServer.active)
		{
			Debug.LogError("Command CmdConfirmDisconnect called on client.");
		}
		else
		{
			((CharacterClassManager)obj).UserCode_CmdConfirmDisconnect();
		}
	}

	protected void UserCode_RpcRoundStarted()
	{
		OnRoundStarted?.Invoke();
	}

	protected static void InvokeUserCode_RpcRoundStarted(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcRoundStarted called on server.");
		}
		else
		{
			((CharacterClassManager)obj).UserCode_RpcRoundStarted();
		}
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteString(Pastebin);
			writer.WriteUShort(MaxPlayers);
			writer.WriteBool(RoundStarted);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteString(Pastebin);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteUShort(MaxPlayers);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteBool(RoundStarted);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref Pastebin, null, reader.ReadString());
			GeneratedSyncVarDeserialize(ref MaxPlayers, MaxPlayersHook, reader.ReadUShort());
			GeneratedSyncVarDeserialize(ref RoundStarted, null, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref Pastebin, null, reader.ReadString());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref MaxPlayers, MaxPlayersHook, reader.ReadUShort());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref RoundStarted, null, reader.ReadBool());
		}
	}
}
