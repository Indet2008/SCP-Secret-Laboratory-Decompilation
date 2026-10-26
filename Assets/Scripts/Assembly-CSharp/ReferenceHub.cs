using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using CentralAuth;
using Hints;
using Interactables;
using InventorySystem;
using InventorySystem.Searching;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using RemoteAdmin;
using Security;
using UnityEngine;
using Utils.Networking;

public sealed class ReferenceHub : NetworkBehaviour, IEquatable<ReferenceHub>
{
	private class GameObjectComparer : EqualityComparer<GameObject>
	{
		public override bool Equals(GameObject x, GameObject y)
		{
			return x == y;
		}

		public override int GetHashCode(GameObject obj)
		{
			if (!(obj == null))
			{
				return obj.GetHashCode();
			}
			return 0;
		}
	}

	private static readonly Dictionary<GameObject, ReferenceHub> HubsByGameObjects = new Dictionary<GameObject, ReferenceHub>(20, new GameObjectComparer());

	private static readonly Dictionary<int, ReferenceHub> HubByPlayerIds = new Dictionary<int, ReferenceHub>(20);

	private static bool _localHubSet;

	private static bool _hostHubSet;

	private static ReferenceHub _localHub;

	private static ReferenceHub _hostHub;

	[SyncVar]
	private RecyclablePlayerId _playerId;

	public Transform PlayerCameraReference;

	public NetworkIdentity networkIdentity;

	public CharacterClassManager characterClassManager;

	public PlayerRoleManager roleManager;

	public PlayerStats playerStats;

	public Inventory inventory;

	public SearchCoordinator searchCoordinator;

	public ServerRoles serverRoles;

	public QueryProcessor queryProcessor;

	public NicknameSync nicknameSync;

	public InteractionCoordinator interCoordinator;

	public PlayerEffectsController playerEffectsController;

	public HintDisplay hints;

	public AspectRatioSync aspectRatioSync;

	public PlayerRateLimitHandler playerRateLimitHandler;

	public GameConsoleTransmission gameConsoleTransmission;

	public PlayerAuthenticationManager authManager;

	public EncryptedChannelManager encryptedChannelManager;

	public CurrentRoomPlayerCache CurrentRoomPlayerCache;

	internal FriendlyFireHandler FriendlyFireHandler;

	public static HashSet<ReferenceHub> AllHubs { get; private set; } = new HashSet<ReferenceHub>();

	[Obsolete("HostHub is obsolete, use TryGetHostHub instead.")]
	public static ReferenceHub HostHub
	{
		get
		{
			if (!TryGetHostHub(out var hub))
			{
				return null;
			}
			return hub;
		}
	}

	[Obsolete("LocalHub is obsolete, use TryGetLocalHub instead.")]
	public static ReferenceHub LocalHub
	{
		get
		{
			if (!TryGetLocalHub(out var hub))
			{
				return null;
			}
			return hub;
		}
	}

	public int PlayerId => _playerId.Value;

	public ClientInstanceMode Mode => authManager.InstanceMode;

	public bool IsHost
	{
		get
		{
			ClientInstanceMode mode = Mode;
			return mode == ClientInstanceMode.Host || mode == ClientInstanceMode.DedicatedServer;
		}
	}

	public bool IsDummy => Mode == ClientInstanceMode.Dummy;

	public bool IsPOV
	{
		get
		{
			if (!base.isLocalPlayer)
			{
				return this.IsLocallySpectated();
			}
			return true;
		}
	}

	public RecyclablePlayerId Network_playerId
	{
		get
		{
			return _playerId;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _playerId, 1uL, null);
		}
	}

	public static event Action<ReferenceHub> OnPlayerAdded;

	public static event Action<ReferenceHub> OnPlayerRemoved;

	public static event Action<ReferenceHub> OnBeforePlayerDestroyed;

	public static int GetPlayerCount(ClientInstanceMode allowedState)
	{
		int num = 0;
		foreach (ReferenceHub allHub in AllHubs)
		{
			if (allowedState == allHub.Mode)
			{
				num++;
			}
		}
		return num;
	}

	public static int GetPlayerCount(ClientInstanceMode allowedState, ClientInstanceMode allowedState2)
	{
		int num = 0;
		foreach (ReferenceHub allHub in AllHubs)
		{
			if (allowedState == allHub.Mode || allowedState2 == allHub.Mode)
			{
				num++;
			}
		}
		return num;
	}

	public static int GetPlayerCount(ClientInstanceMode allowedState, ClientInstanceMode allowedState2, ClientInstanceMode allowedState3)
	{
		int num = 0;
		foreach (ReferenceHub allHub in AllHubs)
		{
			if (allowedState == allHub.Mode || allowedState2 == allHub.Mode || allowedState3 == allHub.Mode)
			{
				num++;
			}
		}
		return num;
	}

	private void Awake()
	{
		AllHubs.Add(this);
		HubsByGameObjects[base.gameObject] = this;
		if (NetworkServer.active)
		{
			Network_playerId = new RecyclablePlayerId(useMinQueue: true);
			FriendlyFireHandler = new FriendlyFireHandler(this);
		}
	}

	private void Start()
	{
		OnPlayerAdded?.Invoke(this);
	}

	private void OnDestroy()
	{
		if (!base.isLocalPlayer)
		{
			PlayerEvents.OnLeft(new PlayerLeftEventArgs(this));
		}
		AllHubs.Remove(this);
		HubsByGameObjects.Remove(base.gameObject);
		HubByPlayerIds.Remove(PlayerId);
		_playerId.Destroy();
		if (_hostHub == this)
		{
			_hostHub = null;
			_hostHubSet = false;
		}
		if (_localHub == this)
		{
			_localHub = null;
			_localHubSet = false;
		}
		OnPlayerRemoved?.Invoke(this);
	}

	public override void OnStopClient()
	{
		base.OnStopClient();
		OnBeforePlayerDestroyed?.Invoke(this);
	}

	public override string ToString()
	{
		return string.Format("{0} (Name='{1}', NetID='{2}', PlayerID='{3}')", "ReferenceHub", base.name, base.netId, PlayerId);
	}

	public static ReferenceHub GetHub(GameObject player)
	{
		if (!TryGetHub(player, out var hub))
		{
			return null;
		}
		return hub;
	}

	public static ReferenceHub GetHub(MonoBehaviour player)
	{
		if (!TryGetHub(player.gameObject, out var hub))
		{
			return null;
		}
		return hub;
	}

	public static bool TryGetHub(GameObject player, out ReferenceHub hub)
	{
		if (player == null)
		{
			hub = null;
			return false;
		}
		if (!HubsByGameObjects.TryGetValue(player, out hub))
		{
			return player.TryGetComponent<ReferenceHub>(out hub);
		}
		return true;
	}

	public static bool TryGetHub(NetworkConnection connection, out ReferenceHub hub)
	{
		NetworkIdentity identity = connection.identity;
		if (!connection.isReady || identity == null)
		{
			hub = null;
			return false;
		}
		if (!HubsByGameObjects.TryGetValue(identity.gameObject, out hub))
		{
			return identity.TryGetComponent<ReferenceHub>(out hub);
		}
		return true;
	}

	public static bool TryGetHubNetID(uint netId, out ReferenceHub hub)
	{
		if (NetworkUtils.SpawnedNetIds.TryGetValue(netId, out var value) && TryGetHub(value.gameObject, out hub))
		{
			return true;
		}
		hub = null;
		return false;
	}

	public static bool TryGetLocalHub(out ReferenceHub hub)
	{
		if (_localHubSet)
		{
			hub = _localHub;
			return true;
		}
		foreach (ReferenceHub allHub in AllHubs)
		{
			if (allHub.isLocalPlayer)
			{
				hub = allHub;
				_localHub = allHub;
				_localHubSet = true;
				return true;
			}
		}
		hub = null;
		return false;
	}

	public static bool TryGetPovHub(out ReferenceHub hub)
	{
		if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub2))
		{
			hub = hub2;
			return true;
		}
		return TryGetLocalHub(out hub);
	}

	public static bool TryGetHostHub(out ReferenceHub hub)
	{
		if (_hostHubSet)
		{
			hub = _hostHub;
			return true;
		}
		foreach (ReferenceHub allHub in AllHubs)
		{
			if (allHub.IsHost)
			{
				hub = allHub;
				_hostHub = allHub;
				_hostHubSet = true;
				return true;
			}
		}
		hub = null;
		return false;
	}

	public static ReferenceHub GetHub(int playerId)
	{
		if (!TryGetHub(playerId, out var hub))
		{
			return null;
		}
		return hub;
	}

	public static bool TryGetHub(int playerId, out ReferenceHub hub)
	{
		if (playerId > 0)
		{
			if (HubByPlayerIds.TryGetValue(playerId, out hub))
			{
				return true;
			}
			foreach (ReferenceHub allHub in AllHubs)
			{
				if (allHub.PlayerId == playerId)
				{
					HubByPlayerIds[playerId] = allHub;
					hub = allHub;
					return true;
				}
			}
		}
		hub = null;
		return false;
	}

	public bool Equals(ReferenceHub other)
	{
		return this == other;
	}

	public override bool Equals(object obj)
	{
		if (obj is ReferenceHub referenceHub)
		{
			return this == referenceHub;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.gameObject.GetHashCode();
	}

	public static bool operator ==(ReferenceHub left, ReferenceHub right)
	{
		return (UnityEngine.Object)left == (UnityEngine.Object)right;
	}

	public static bool operator !=(ReferenceHub left, ReferenceHub right)
	{
		return (UnityEngine.Object)left != (UnityEngine.Object)right;
	}

	public override bool Weaved()
	{
		return true;
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteRecyclablePlayerId(_playerId);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteRecyclablePlayerId(_playerId);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _playerId, null, reader.ReadRecyclablePlayerId());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _playerId, null, reader.ReadRecyclablePlayerId());
		}
	}
}
