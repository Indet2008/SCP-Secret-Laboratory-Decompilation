namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.DefaultExecutionOrder(-1)]
	[global::UnityEngine.AddComponentMenu("Network/Network Identity")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-identity")]
	public sealed class NetworkIdentity : global::UnityEngine.MonoBehaviour
	{
		public delegate void ClientAuthorityCallback(global::Mirror.NetworkConnectionToClient conn, global::Mirror.NetworkIdentity identity, bool authorityState);

		public readonly global::System.Collections.Generic.Dictionary<int, global::Mirror.NetworkConnectionToClient> observers = new global::System.Collections.Generic.Dictionary<int, global::Mirror.NetworkConnectionToClient>();

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_SceneId")]
		[global::UnityEngine.HideInInspector]
		public ulong sceneId;

		[global::UnityEngine.SerializeField]
		[global::UnityEngine.HideInInspector]
		private uint _assetId;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_ServerOnly")]
		[global::UnityEngine.Tooltip("Prevents this object from being spawned / enabled on clients")]
		public bool serverOnly;

		internal bool destroyCalled;

		private global::Mirror.NetworkConnectionToClient _connectionToClient;

		private const int MaxNetworkBehaviours = 64;

		[global::UnityEngine.Tooltip("Visibility can overwrite interest management. ForceHidden can be useful to hide monsters while they respawn. ForceShown can be useful for score NetworkIdentities that should always broadcast to everyone in the world.")]
		public global::Mirror.Visibility visible;

		private global::Mirror.NetworkIdentitySerialization lastSerialization = new global::Mirror.NetworkIdentitySerialization
		{
			ownerWriter = new global::Mirror.NetworkWriter(),
			observersWriter = new global::Mirror.NetworkWriter()
		};

		private static readonly global::System.Collections.Generic.Dictionary<ulong, global::Mirror.NetworkIdentity> sceneIds = new global::System.Collections.Generic.Dictionary<ulong, global::Mirror.NetworkIdentity>();

		private static uint nextNetworkId = 1u;

		[global::UnityEngine.SerializeField]
		[global::UnityEngine.HideInInspector]
		private bool hasSpawned;

		private bool clientStarted;

		internal static global::Mirror.NetworkIdentity previousLocalPlayer = null;

		private bool hadAuthority;

		public bool isClient { get; internal set; }

		public bool isServer { get; internal set; }

		public bool isLocalPlayer { get; internal set; }

		public bool isServerOnly
		{
			get
			{
				if (isServer)
				{
					return !isClient;
				}
				return false;
			}
		}

		public bool isClientOnly
		{
			get
			{
				if (isClient)
				{
					return !isServer;
				}
				return false;
			}
		}

		public bool isOwned { get; internal set; }

		[global::System.Obsolete(".hasAuthority was renamed to .isOwned. This is easier to understand and prepares for SyncDirection, where there is a difference betwen isOwned and authority.")]
		public bool hasAuthority => isOwned;

		public uint netId { get; internal set; }

		public uint assetId
		{
			get
			{
				return _assetId;
			}
			internal set
			{
				if (value == 0)
				{
					global::UnityEngine.Debug.LogError($"Can not set AssetId to empty guid on NetworkIdentity '{base.name}', old assetId '{_assetId}'");
				}
				else
				{
					_assetId = value;
				}
			}
		}

		public global::Mirror.NetworkConnection connectionToServer { get; internal set; }

		public global::Mirror.NetworkConnectionToClient connectionToClient
		{
			get
			{
				return _connectionToClient;
			}
			internal set
			{
				_connectionToClient?.RemoveOwnedObject(this);
				_connectionToClient = value;
				_connectionToClient?.AddOwnedObject(this);
			}
		}

		public global::Mirror.NetworkBehaviour[] NetworkBehaviours { get; private set; }

		public bool SpawnedFromInstantiate { get; private set; }

		public static event global::Mirror.NetworkIdentity.ClientAuthorityCallback clientAuthorityCallback;

		internal void HandleRemoteCall(byte componentIndex, ushort functionHash, global::Mirror.RemoteCalls.RemoteCallType remoteCallType, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection = null)
		{
			if (this == null)
			{
				global::UnityEngine.Debug.LogWarning($"{remoteCallType} [{functionHash}] received for deleted object [netId={netId}]");
				return;
			}
			if (componentIndex >= NetworkBehaviours.Length)
			{
				global::UnityEngine.Debug.LogWarning($"Component [{componentIndex}] not found for [netId={netId}]");
				return;
			}
			global::Mirror.NetworkBehaviour component = NetworkBehaviours[componentIndex];
			if (!global::Mirror.RemoteCalls.RemoteProcedureCalls.Invoke(functionHash, remoteCallType, reader, component, senderConnection))
			{
				global::UnityEngine.Debug.LogError($"Found no receiver for incoming {remoteCallType} [{functionHash}] on {base.gameObject.name}, the server and client should have the same NetworkBehaviour instances [netId={netId}].");
			}
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		internal static void ResetStatics()
		{
			ResetClientStatics();
			ResetServerStatics();
		}

		internal static void ResetClientStatics()
		{
			previousLocalPlayer = null;
			clientAuthorityCallback = null;
		}

		internal static void ResetServerStatics()
		{
			nextNetworkId = 1u;
		}

		public static global::Mirror.NetworkIdentity GetSceneIdentity(ulong id)
		{
			return sceneIds[id];
		}

		internal static uint GetNextNetworkId()
		{
			return nextNetworkId++;
		}

		public static void ResetNextNetworkId()
		{
			nextNetworkId = 1u;
		}

		internal void InitializeNetworkBehaviours()
		{
			NetworkBehaviours = GetComponentsInChildren<global::Mirror.NetworkBehaviour>(includeInactive: true);
			ValidateComponents();
			for (int i = 0; i < NetworkBehaviours.Length; i++)
			{
				global::Mirror.NetworkBehaviour obj = NetworkBehaviours[i];
				obj.netIdentity = this;
				obj.ComponentIndex = (byte)i;
			}
		}

		private void ValidateComponents()
		{
			if (NetworkBehaviours == null)
			{
				InitializeNetworkBehaviours();
			}
			else if (NetworkBehaviours.Length > 64)
			{
				global::UnityEngine.Debug.LogError($"NetworkIdentity {base.name} has too many NetworkBehaviour components: only {64} NetworkBehaviour components are allowed in order to save bandwidth.", this);
			}
		}

		internal void Awake()
		{
			InitializeNetworkBehaviours();
			if (hasSpawned)
			{
				global::UnityEngine.Debug.LogError(base.name + " has already spawned. Don't call Instantiate for NetworkIdentities that were in the scene since the beginning (aka scene objects).  Otherwise the client won't know which object to use for a SpawnSceneObject message.");
				SpawnedFromInstantiate = true;
				global::UnityEngine.Object.Destroy(base.gameObject);
			}
			hasSpawned = true;
		}

		private void OnValidate()
		{
			hasSpawned = false;
		}

		public static uint AssetGuidToUint(global::System.Guid guid)
		{
			return (uint)guid.GetHashCode();
		}

		private void OnDestroy()
		{
			if (SpawnedFromInstantiate)
			{
				return;
			}
			if (isServer && !destroyCalled)
			{
				global::Mirror.NetworkServer.Destroy(base.gameObject);
			}
			if (isLocalPlayer && global::Mirror.NetworkClient.localPlayer == this)
			{
				global::Mirror.NetworkClient.localPlayer = null;
			}
			if (isClient)
			{
				if (global::Mirror.NetworkClient.connection != null)
				{
					global::Mirror.NetworkClient.connection.owned.Remove(this);
				}
				global::Mirror.NetworkClient.spawned.Remove(netId);
			}
		}

		internal void OnStartServer()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStartServer();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStopServer()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStopServer();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStartClient()
		{
			if (clientStarted)
			{
				return;
			}
			clientStarted = true;
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStartClient();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStopClient()
		{
			if (!clientStarted)
			{
				return;
			}
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStopClient();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStartLocalPlayer()
		{
			if (previousLocalPlayer == this)
			{
				return;
			}
			previousLocalPlayer = this;
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStartLocalPlayer();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStopLocalPlayer()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStopLocalPlayer();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		private (ulong, ulong) ServerDirtyMasks(bool initialState)
		{
			ulong num = 0uL;
			ulong num2 = 0uL;
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				global::Mirror.NetworkBehaviour networkBehaviour = networkBehaviours[i];
				bool flag = networkBehaviour.IsDirty();
				ulong num3 = (uint)(1 << i);
				if (initialState || ((networkBehaviour.syncDirection == global::Mirror.SyncDirection.ServerToClient) & flag))
				{
					num |= num3;
				}
				if (networkBehaviour.syncMode == global::Mirror.SyncMode.Observers && (initialState | flag))
				{
					num2 |= num3;
				}
			}
			return (num, num2);
		}

		private ulong ClientDirtyMask()
		{
			ulong num = 0uL;
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				global::Mirror.NetworkBehaviour networkBehaviour = networkBehaviours[i];
				if (isOwned && networkBehaviour.syncDirection == global::Mirror.SyncDirection.ClientToServer && networkBehaviour.IsDirty())
				{
					num |= (uint)(1 << i);
				}
			}
			return num;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal static bool IsDirty(ulong mask, int index)
		{
			ulong num = (ulong)(1 << index);
			return (mask & num) != 0;
		}

		internal void SerializeServer(bool initialState, global::Mirror.NetworkWriter ownerWriter, global::Mirror.NetworkWriter observersWriter)
		{
			ValidateComponents();
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			var (num, num2) = ServerDirtyMasks(initialState);
			if (num != 0L)
			{
				global::Mirror.Compression.CompressVarUInt(ownerWriter, num);
			}
			if (num2 != 0L)
			{
				global::Mirror.Compression.CompressVarUInt(observersWriter, num2);
			}
			if ((num | num2) == 0L)
			{
				return;
			}
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				global::Mirror.NetworkBehaviour networkBehaviour = networkBehaviours[i];
				bool flag = IsDirty(num, i);
				bool flag2 = IsDirty(num2, i);
				if (!(flag | flag2))
				{
					continue;
				}
				using (global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get())
				{
					networkBehaviour.Serialize(networkWriterPooled, initialState);
					global::System.ArraySegment<byte> arraySegment = networkWriterPooled.ToArraySegment();
					if (flag)
					{
						ownerWriter.WriteBytes(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
					}
					if (flag2)
					{
						observersWriter.WriteBytes(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
					}
				}
				if (!initialState)
				{
					networkBehaviour.ClearAllDirtyBits();
				}
			}
		}

		internal void SerializeClient(global::Mirror.NetworkWriter writer)
		{
			ValidateComponents();
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			ulong num = ClientDirtyMask();
			if (num != 0L)
			{
				global::Mirror.Compression.CompressVarUInt(writer, num);
			}
			if (num == 0L)
			{
				return;
			}
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				global::Mirror.NetworkBehaviour networkBehaviour = networkBehaviours[i];
				if (IsDirty(num, i))
				{
					networkBehaviour.Serialize(writer, initialState: false);
					networkBehaviour.ClearAllDirtyBits();
				}
			}
		}

		internal bool DeserializeServer(global::Mirror.NetworkReader reader)
		{
			ValidateComponents();
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			ulong mask = global::Mirror.Compression.DecompressVarUInt(reader);
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				if (!IsDirty(mask, i))
				{
					continue;
				}
				global::Mirror.NetworkBehaviour networkBehaviour = networkBehaviours[i];
				if (networkBehaviour.syncDirection == global::Mirror.SyncDirection.ClientToServer)
				{
					if (!networkBehaviour.Deserialize(reader, initialState: false))
					{
						return false;
					}
					networkBehaviour.SetDirty();
				}
			}
			return true;
		}

		internal void DeserializeClient(global::Mirror.NetworkReader reader, bool initialState)
		{
			ValidateComponents();
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			ulong mask = global::Mirror.Compression.DecompressVarUInt(reader);
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				if (IsDirty(mask, i))
				{
					networkBehaviours[i].Deserialize(reader, initialState);
				}
			}
		}

		internal global::Mirror.NetworkIdentitySerialization GetServerSerializationAtTick(int tick)
		{
			if (lastSerialization.tick != tick)
			{
				lastSerialization.ownerWriter.Position = 0;
				lastSerialization.observersWriter.Position = 0;
				SerializeServer(initialState: false, lastSerialization.ownerWriter, lastSerialization.observersWriter);
				lastSerialization.tick = tick;
			}
			return lastSerialization;
		}

		internal void AddObserver(global::Mirror.NetworkConnectionToClient conn)
		{
			if (!observers.ContainsKey(conn.connectionId))
			{
				if (observers.Count == 0)
				{
					ClearAllComponentsDirtyBits();
				}
				observers[conn.connectionId] = conn;
				conn.AddToObserving(this);
			}
		}

		internal void ClearAllComponentsDirtyBits()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			for (int i = 0; i < networkBehaviours.Length; i++)
			{
				networkBehaviours[i].ClearAllDirtyBits();
			}
		}

		internal void RemoveObserver(global::Mirror.NetworkConnection conn)
		{
			observers.Remove(conn.connectionId);
		}

		public bool AssignClientAuthority(global::Mirror.NetworkConnectionToClient conn)
		{
			if (!isServer)
			{
				global::UnityEngine.Debug.LogError("AssignClientAuthority can only be called on the server for spawned objects.");
				return false;
			}
			if (conn == null)
			{
				global::UnityEngine.Debug.LogError($"AssignClientAuthority for {base.gameObject} owner cannot be null. Use RemoveClientAuthority() instead.");
				return false;
			}
			if (connectionToClient != null && conn != connectionToClient)
			{
				global::UnityEngine.Debug.LogError($"AssignClientAuthority for {base.gameObject} already has an owner. Use RemoveClientAuthority() first.");
				return false;
			}
			SetClientOwner(conn);
			global::Mirror.NetworkServer.SendChangeOwnerMessage(this, conn);
			clientAuthorityCallback?.Invoke(conn, this, authorityState: true);
			return true;
		}

		internal void SetClientOwner(global::Mirror.NetworkConnectionToClient conn)
		{
			if (connectionToClient != null && conn != connectionToClient)
			{
				global::UnityEngine.Debug.LogError($"Object {this} netId={netId} already has an owner. Use RemoveClientAuthority() first", this);
			}
			else
			{
				connectionToClient = conn;
			}
		}

		public void RemoveClientAuthority()
		{
			if (!isServer)
			{
				global::UnityEngine.Debug.LogError("RemoveClientAuthority can only be called on the server for spawned objects.");
			}
			else if (connectionToClient?.identity == this)
			{
				global::UnityEngine.Debug.LogError("RemoveClientAuthority cannot remove authority for a player object");
			}
			else if (connectionToClient != null)
			{
				clientAuthorityCallback?.Invoke(connectionToClient, this, authorityState: false);
				global::Mirror.NetworkConnectionToClient conn = connectionToClient;
				connectionToClient = null;
				global::Mirror.NetworkServer.SendChangeOwnerMessage(this, conn);
			}
		}

		internal void Reset()
		{
			hasSpawned = false;
			clientStarted = false;
			isClient = false;
			isServer = false;
			isOwned = false;
			NotifyAuthority();
			netId = 0u;
			connectionToServer = null;
			connectionToClient = null;
			ClearObservers();
			if (isLocalPlayer && global::Mirror.NetworkClient.localPlayer == this)
			{
				global::Mirror.NetworkClient.localPlayer = null;
			}
			previousLocalPlayer = null;
			isLocalPlayer = false;
		}

		internal void NotifyAuthority()
		{
			if (!hadAuthority && isOwned)
			{
				OnStartAuthority();
			}
			if (hadAuthority && !isOwned)
			{
				OnStopAuthority();
			}
			hadAuthority = isOwned;
		}

		internal void OnStartAuthority()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStartAuthority();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void OnStopAuthority()
		{
			global::Mirror.NetworkBehaviour[] networkBehaviours = NetworkBehaviours;
			foreach (global::Mirror.NetworkBehaviour networkBehaviour in networkBehaviours)
			{
				try
				{
					networkBehaviour.OnStopAuthority();
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception, networkBehaviour);
				}
			}
		}

		internal void ClearObservers()
		{
			foreach (global::Mirror.NetworkConnectionToClient value in observers.Values)
			{
				value.RemoveFromObserving(this, isDestroyed: true);
			}
			observers.Clear();
		}
	}
}
