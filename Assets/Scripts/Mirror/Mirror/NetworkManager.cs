namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/Network Manager")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-manager")]
	public class NetworkManager : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.Header("Configuration")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("m_DontDestroyOnLoad")]
		[global::UnityEngine.Tooltip("Should the Network Manager object be persisted through scene changes?")]
		public bool dontDestroyOnLoad = true;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_RunInBackground")]
		[global::UnityEngine.Tooltip("Multiplayer games should always run in the background so the network doesn't time out.")]
		public bool runInBackground = true;

		[global::UnityEngine.Header("Headless Builds")]
		[global::UnityEngine.Tooltip("Should the server auto-start when 'Server Build' is checked in build settings")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("startOnHeadless")]
		public bool autoStartServerBuild = true;

		[global::UnityEngine.Tooltip("Automatically connect the client in headless builds. Useful for CCU tests with bot clients.\n\nAddress may be passed as command line argument.\n\nMake sure that only 'autostartServer' or 'autoconnectClient' is enabled, not both!")]
		public bool autoConnectClientBuild;

		[global::UnityEngine.Tooltip("Server & Client send rate per second. Use 60-100Hz for fast paced games like Counter-Strike to minimize latency. Use around 30Hz for games like WoW to minimize computations. Use around 1-10Hz for slow paced games like EVE.")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("serverTickRate")]
		public int sendRate = 60;

		[global::UnityEngine.Header("Scene Management")]
		[global::Mirror.Scene]
		[global::UnityEngine.Serialization.FormerlySerializedAs("m_OfflineScene")]
		[global::UnityEngine.Tooltip("Scene that Mirror will switch to when the client or server is stopped")]
		public string offlineScene = "";

		[global::Mirror.Scene]
		[global::UnityEngine.Serialization.FormerlySerializedAs("m_OnlineScene")]
		[global::UnityEngine.Tooltip("Scene that Mirror will switch to when the server is started. Clients will recieve a Scene Message to load the server's current scene when they connect.")]
		public string onlineScene = "";

		[global::UnityEngine.Header("Network Info")]
		[global::UnityEngine.Tooltip("Transport component attached to this object that server and client will use to connect")]
		public global::Mirror.Transport transport;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_NetworkAddress")]
		[global::UnityEngine.Tooltip("Network Address where the client should connect to the server. Server does not use this for anything.")]
		public string networkAddress = "localhost";

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_MaxConnections")]
		[global::UnityEngine.Tooltip("Maximum number of concurrent connections.")]
		public int maxConnections = 100;

		[global::UnityEngine.Tooltip("When enabled, the server automatically disconnects inactive connections after the configured timeout.")]
		public bool disconnectInactiveConnections;

		[global::UnityEngine.Tooltip("Timeout in seconds for server to automatically disconnect inactive connections if 'disconnectInactiveConnections' is enabled.")]
		public float disconnectInactiveTimeout = 60f;

		[global::UnityEngine.Header("Authentication")]
		[global::UnityEngine.Tooltip("Authentication component attached to this object")]
		public global::Mirror.NetworkAuthenticator authenticator;

		[global::UnityEngine.Header("Player Object")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("m_PlayerPrefab")]
		[global::UnityEngine.Tooltip("Prefab of the player object. Prefab must have a Network Identity component. May be an empty game object or a full avatar.")]
		public global::UnityEngine.GameObject playerPrefab;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_AutoCreatePlayer")]
		[global::UnityEngine.Tooltip("Should Mirror automatically spawn the player after scene change?")]
		public bool autoCreatePlayer = true;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_PlayerSpawnMethod")]
		[global::UnityEngine.Tooltip("Round Robin or Random order of Start Position selection")]
		public global::Mirror.PlayerSpawnMethod playerSpawnMethod;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_SpawnPrefabs")]
		[global::UnityEngine.HideInInspector]
		public global::System.Collections.Generic.List<global::UnityEngine.GameObject> spawnPrefabs = new global::System.Collections.Generic.List<global::UnityEngine.GameObject>();

		public static global::System.Collections.Generic.List<global::UnityEngine.Transform> startPositions = new global::System.Collections.Generic.List<global::UnityEngine.Transform>();

		public static int startPositionIndex;

		[global::UnityEngine.Header("Snapshot Interpolation")]
		public global::Mirror.SnapshotInterpolationSettings snapshotSettings = new global::Mirror.SnapshotInterpolationSettings();

		[global::UnityEngine.Header("Connection Quality")]
		public float connectionQualityInterval = 3f;

		private double lastConnectionQualityUpdate;

		private global::Mirror.ConnectionQuality lastConnectionQuality = global::Mirror.ConnectionQuality.ESTIMATING;

		[global::UnityEngine.Header("Debug")]
		public bool timeInterpolationGui;

		internal static global::Mirror.NetworkConnection clientReadyConnection;

		protected bool clientLoadedScene;

		private bool finishStartHostPending;

		public static global::UnityEngine.AsyncOperation loadingSceneAsync;

		private global::Mirror.SceneOperation clientSceneOperation;

		[global::System.Obsolete("NetworkManager.serverTickRate was renamed to sendRate because that's what it configures for both server & client now.")]
		public int serverTickRate => sendRate;

		[global::System.Obsolete("NetworkManager.serverTickInterval was moved to NetworkServer.tickInterval for consistency.")]
		public float serverTickInterval => global::Mirror.NetworkServer.tickInterval;

		public static global::Mirror.NetworkManager singleton { get; internal set; }

		public int numPlayers => global::System.Linq.Enumerable.Count(global::Mirror.NetworkServer.connections, (global::System.Collections.Generic.KeyValuePair<int, global::Mirror.NetworkConnectionToClient> kv) => kv.Value.identity != null);

		public bool isNetworkActive
		{
			get
			{
				if (!global::Mirror.NetworkServer.active)
				{
					return global::Mirror.NetworkClient.active;
				}
				return true;
			}
		}

		public global::Mirror.NetworkManagerMode mode { get; private set; }

		public static string networkSceneName { get; protected set; } = "";

		public virtual void OnValidate()
		{
			maxConnections = global::UnityEngine.Mathf.Max(maxConnections, 0);
			if (playerPrefab != null && !playerPrefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var _))
			{
				global::UnityEngine.Debug.LogError("NetworkManager - Player Prefab must have a NetworkIdentity.");
				playerPrefab = null;
			}
			if (playerPrefab != null && spawnPrefabs.Contains(playerPrefab))
			{
				global::UnityEngine.Debug.LogWarning("NetworkManager - Player Prefab doesn't need to be in Spawnable Prefabs list too. Removing it.");
				spawnPrefabs.Remove(playerPrefab);
			}
		}

		public virtual void Reset()
		{
			global::Mirror.NetworkManager[] componentsInChildren = base.transform.root.GetComponentsInChildren<global::Mirror.NetworkManager>();
			foreach (global::Mirror.NetworkManager networkManager in componentsInChildren)
			{
				if (networkManager != this)
				{
					global::UnityEngine.Debug.LogError($"{base.name} detected another component of type {(typeof(global::Mirror.NetworkManager))} in its hierarchy on {networkManager.name}. There can only be one, please remove one of them.");
					break;
				}
			}
		}

		public virtual void Awake()
		{
			if (InitializeSingleton())
			{
				ApplyConfiguration();
				networkSceneName = offlineScene;
				global::UnityEngine.SceneManagement.SceneManager.sceneLoaded += OnSceneLoaded;
			}
		}

		public virtual void Start()
		{
			if (autoStartServerBuild)
			{
				StartServer();
			}
			else if (autoConnectClientBuild)
			{
				StartClient();
			}
		}

		public virtual void Update()
		{
			ApplyConfiguration();
		}

		public virtual void LateUpdate()
		{
			UpdateScene();
			UpdateConnectionQuality();
		}

		private void UpdateConnectionQuality()
		{
			if (global::Mirror.NetworkClient.active && !(global::Mirror.NetworkTime.time < lastConnectionQualityUpdate + (double)connectionQualityInterval))
			{
				lastConnectionQualityUpdate = global::Mirror.NetworkTime.time;
				CalculateConnectionQuality();
				if (global::Mirror.NetworkClient.connectionQuality != lastConnectionQuality)
				{
					OnConnectionQualityChanged(lastConnectionQuality, global::Mirror.NetworkClient.connectionQuality);
					lastConnectionQuality = global::Mirror.NetworkClient.connectionQuality;
				}
			}
		}

		protected virtual void CalculateConnectionQuality()
		{
			global::Mirror.NetworkClient.connectionQuality = global::Mirror.ConnectionQualityHeuristics.Simple(global::Mirror.NetworkTime.rtt, global::Mirror.NetworkTime.rttVariance);
		}

		protected virtual void OnConnectionQualityChanged(global::Mirror.ConnectionQuality previous, global::Mirror.ConnectionQuality current)
		{
			global::UnityEngine.Debug.Log($"[Mirror] Connection Quality changed from {previous} to {current}");
		}

		private bool IsServerOnlineSceneChangeNeeded()
		{
			if (!string.IsNullOrWhiteSpace(onlineScene) && !global::Mirror.Utils.IsSceneActive(onlineScene))
			{
				return onlineScene != offlineScene;
			}
			return false;
		}

		[global::System.Obsolete("NetworkManager.IsSceneActive moved to Utils.IsSceneActive")]
		public static bool IsSceneActive(string scene)
		{
			return global::Mirror.Utils.IsSceneActive(scene);
		}

		private void ApplyConfiguration()
		{
			global::Mirror.NetworkServer.tickRate = sendRate;
			global::Mirror.NetworkClient.snapshotSettings = snapshotSettings;
		}

		private void SetupServer()
		{
			InitializeSingleton();
			if (runInBackground)
			{
				global::UnityEngine.Application.runInBackground = true;
			}
			if (authenticator != null)
			{
				authenticator.OnStartServer();
				authenticator.OnServerAuthenticated.AddListener(OnServerAuthenticated);
			}
			ConfigureHeadlessFrameRate();
			global::Mirror.NetworkServer.disconnectInactiveConnections = disconnectInactiveConnections;
			global::Mirror.NetworkServer.disconnectInactiveTimeout = disconnectInactiveTimeout;
			global::Mirror.NetworkServer.Listen(maxConnections);
			RegisterServerMessages();
		}

		public void StartServer()
		{
			if (global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogWarning("Server already started.");
				return;
			}
			mode = global::Mirror.NetworkManagerMode.ServerOnly;
			SetupServer();
			OnStartServer();
			if (IsServerOnlineSceneChangeNeeded())
			{
				ServerChangeScene(onlineScene);
			}
			else
			{
				global::Mirror.NetworkServer.SpawnObjects();
			}
		}

		private void SetupClient()
		{
			InitializeSingleton();
			if (runInBackground)
			{
				global::UnityEngine.Application.runInBackground = true;
			}
			if (authenticator != null)
			{
				authenticator.OnStartClient();
				authenticator.OnClientAuthenticated.AddListener(OnClientAuthenticated);
			}
		}

		public virtual void StartClient()
		{
			if (global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("Client already started.");
				return;
			}
			mode = global::Mirror.NetworkManagerMode.ClientOnly;
			SetupClient();
			ConfigureHeadlessFrameRate();
			RegisterClientMessages();
			if (string.IsNullOrWhiteSpace(networkAddress))
			{
				global::UnityEngine.Debug.LogError("Must set the Network Address field in the manager");
				return;
			}
			global::Mirror.NetworkClient.Connect(networkAddress);
			OnStartClient();
		}

		public void StartClient(global::System.Uri uri)
		{
			if (global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("Client already started.");
				return;
			}
			mode = global::Mirror.NetworkManagerMode.ClientOnly;
			SetupClient();
			RegisterClientMessages();
			networkAddress = uri.Host;
			global::Mirror.NetworkClient.Connect(uri);
			OnStartClient();
		}

		public void StartHost()
		{
			if (global::Mirror.NetworkServer.active || global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("Server or Client already started.");
				return;
			}
			mode = global::Mirror.NetworkManagerMode.Host;
			SetupServer();
			if (IsServerOnlineSceneChangeNeeded())
			{
				finishStartHostPending = true;
				ServerChangeScene(onlineScene);
			}
			else
			{
				FinishStartHost();
			}
		}

		private void FinishStartHost()
		{
			global::Mirror.NetworkClient.ConnectHost();
			OnStartServer();
			OnStartHost();
			global::Mirror.NetworkServer.SpawnObjects();
			SetupClient();
			networkAddress = "localhost";
			RegisterClientMessages();
			global::Mirror.HostMode.InvokeOnConnected();
			OnStartClient();
		}

		public void StopHost()
		{
			OnStopHost();
			StopClient();
			StopServer();
		}

		public void StopServer()
		{
			if (global::Mirror.NetworkServer.active)
			{
				if (authenticator != null)
				{
					authenticator.OnServerAuthenticated.RemoveListener(OnServerAuthenticated);
					authenticator.OnStopServer();
				}
				OnStopServer();
				global::Mirror.NetworkServer.Shutdown();
				mode = global::Mirror.NetworkManagerMode.Offline;
				if (!string.IsNullOrWhiteSpace(offlineScene))
				{
					ServerChangeScene(offlineScene);
				}
				startPositionIndex = 0;
				networkSceneName = "";
			}
		}

		public void StopClient()
		{
			if (mode != global::Mirror.NetworkManagerMode.Offline)
			{
				if (mode == global::Mirror.NetworkManagerMode.Host)
				{
					OnServerDisconnect(global::Mirror.NetworkServer.localConnection);
				}
				global::Mirror.NetworkClient.Disconnect();
				OnClientDisconnectInternal();
			}
		}

		public virtual void OnApplicationQuit()
		{
			if (global::Mirror.NetworkClient.isConnected)
			{
				StopClient();
			}
			if (global::Mirror.NetworkServer.active)
			{
				StopServer();
			}
			ResetStatics();
		}

		public virtual void ConfigureHeadlessFrameRate()
		{
			global::UnityEngine.Application.targetFrameRate = sendRate;
		}

		private bool InitializeSingleton()
		{
			if (singleton != null && singleton == this)
			{
				return true;
			}
			if (dontDestroyOnLoad)
			{
				if (singleton != null)
				{
					global::UnityEngine.Debug.LogWarning("Multiple NetworkManagers detected in the scene. Only one NetworkManager can exist at a time. The duplicate NetworkManager will be destroyed.");
					global::UnityEngine.Object.Destroy(base.gameObject);
					return false;
				}
				singleton = this;
				if (global::UnityEngine.Application.isPlaying)
				{
					base.transform.SetParent(null);
					global::UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
				}
			}
			else
			{
				singleton = this;
			}
			if (transport == null)
			{
				if (!TryGetComponent<global::Mirror.Transport>(out var component))
				{
					global::UnityEngine.Debug.LogError("No Transport on Network Manager...add a transport and assign it.");
					return false;
				}
				global::UnityEngine.Debug.LogWarning($"No Transport assigned to Network Manager - Using {component} found on same object.");
				transport = component;
			}
			global::Mirror.Transport.active = transport;
			return true;
		}

		private void RegisterServerMessages()
		{
			global::Mirror.NetworkServer.OnConnectedEvent = OnServerConnectInternal;
			global::Mirror.NetworkServer.OnDisconnectedEvent = OnServerDisconnect;
			global::Mirror.NetworkServer.OnErrorEvent = OnServerError;
			global::Mirror.NetworkServer.RegisterHandler<global::Mirror.AddPlayerMessage>(OnServerAddPlayerInternal);
			global::Mirror.NetworkServer.ReplaceHandler<global::Mirror.ReadyMessage>(OnServerReadyMessageInternal);
		}

		private void RegisterClientMessages()
		{
			global::Mirror.NetworkClient.OnConnectedEvent = OnClientConnectInternal;
			global::Mirror.NetworkClient.OnDisconnectedEvent = OnClientDisconnectInternal;
			global::Mirror.NetworkClient.OnErrorEvent = OnClientError;
			global::Mirror.NetworkClient.RegisterHandler<global::Mirror.NotReadyMessage>(OnClientNotReadyMessageInternal);
			global::Mirror.NetworkClient.RegisterHandler<global::Mirror.SceneMessage>(OnClientSceneInternal, requireAuthentication: false);
			if (playerPrefab != null)
			{
				global::Mirror.NetworkClient.RegisterPrefab(playerPrefab);
			}
			foreach (global::UnityEngine.GameObject item in global::System.Linq.Enumerable.Where(spawnPrefabs, (global::UnityEngine.GameObject t) => t != null))
			{
				global::Mirror.NetworkClient.RegisterPrefab(item);
			}
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		public static void ResetStatics()
		{
			if ((bool)singleton)
			{
				singleton.StopHost();
			}
			startPositions.Clear();
			startPositionIndex = 0;
			clientReadyConnection = null;
			loadingSceneAsync = null;
			networkSceneName = string.Empty;
			singleton = null;
		}

		public virtual void OnDestroy()
		{
		}

		public virtual void ServerChangeScene(string newSceneName)
		{
			if (string.IsNullOrWhiteSpace(newSceneName))
			{
				global::UnityEngine.Debug.LogError("ServerChangeScene empty scene name");
				return;
			}
			if (global::Mirror.NetworkServer.isLoadingScene && newSceneName == networkSceneName)
			{
				global::UnityEngine.Debug.LogError("Scene change is already in progress for " + newSceneName);
				return;
			}
			global::Mirror.NetworkServer.SetAllClientsNotReady();
			networkSceneName = newSceneName;
			OnServerChangeScene(newSceneName);
			global::Mirror.NetworkServer.isLoadingScene = true;
			loadingSceneAsync = global::UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(newSceneName);
			if (global::Mirror.NetworkServer.active)
			{
				global::Mirror.NetworkServer.SendToAll(new global::Mirror.SceneMessage
				{
					sceneName = newSceneName
				});
			}
			startPositionIndex = 0;
			startPositions.Clear();
		}

		internal void ClientChangeScene(string newSceneName, global::Mirror.SceneOperation sceneOperation = global::Mirror.SceneOperation.Normal, bool customHandling = false)
		{
			if (string.IsNullOrWhiteSpace(newSceneName))
			{
				global::UnityEngine.Debug.LogError("ClientChangeScene empty scene name");
				return;
			}
			OnClientChangeScene(newSceneName, sceneOperation, customHandling);
			if (global::Mirror.NetworkServer.active)
			{
				return;
			}
			global::Mirror.NetworkClient.isLoadingScene = true;
			clientSceneOperation = sceneOperation;
			if (customHandling)
			{
				return;
			}
			switch (sceneOperation)
			{
			case global::Mirror.SceneOperation.Normal:
				loadingSceneAsync = global::UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(newSceneName);
				break;
			case global::Mirror.SceneOperation.LoadAdditive:
				if (!global::UnityEngine.SceneManagement.SceneManager.GetSceneByName(newSceneName).IsValid() && !global::UnityEngine.SceneManagement.SceneManager.GetSceneByPath(newSceneName).IsValid())
				{
					loadingSceneAsync = global::UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(newSceneName, global::UnityEngine.SceneManagement.LoadSceneMode.Additive);
					break;
				}
				global::UnityEngine.Debug.LogWarning("Scene " + newSceneName + " is already loaded");
				global::Mirror.NetworkClient.isLoadingScene = false;
				break;
			case global::Mirror.SceneOperation.UnloadAdditive:
				if (global::UnityEngine.SceneManagement.SceneManager.GetSceneByName(newSceneName).IsValid() || global::UnityEngine.SceneManagement.SceneManager.GetSceneByPath(newSceneName).IsValid())
				{
					loadingSceneAsync = global::UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync(newSceneName, global::UnityEngine.SceneManagement.UnloadSceneOptions.UnloadAllEmbeddedSceneObjects);
					break;
				}
				global::UnityEngine.Debug.LogWarning("Cannot unload " + newSceneName + " with UnloadAdditive operation");
				global::Mirror.NetworkClient.isLoadingScene = false;
				break;
			}
			if (sceneOperation == global::Mirror.SceneOperation.Normal)
			{
				networkSceneName = newSceneName;
			}
		}

		private void OnSceneLoaded(global::UnityEngine.SceneManagement.Scene scene, global::UnityEngine.SceneManagement.LoadSceneMode mode)
		{
			if (mode == global::UnityEngine.SceneManagement.LoadSceneMode.Additive)
			{
				if (global::Mirror.NetworkServer.active)
				{
					global::Mirror.NetworkServer.SpawnObjects();
				}
				if (global::Mirror.NetworkClient.active)
				{
					global::Mirror.NetworkClient.PrepareToSpawnSceneObjects();
				}
			}
		}

		private void UpdateScene()
		{
			if (loadingSceneAsync != null && loadingSceneAsync.isDone)
			{
				try
				{
					FinishLoadScene();
				}
				finally
				{
					loadingSceneAsync.allowSceneActivation = true;
					loadingSceneAsync = null;
				}
			}
		}

		protected void FinishLoadScene()
		{
			global::Mirror.NetworkServer.isLoadingScene = false;
			global::Mirror.NetworkClient.isLoadingScene = false;
			if (mode == global::Mirror.NetworkManagerMode.Host)
			{
				FinishLoadSceneHost();
			}
			else if (mode == global::Mirror.NetworkManagerMode.ServerOnly)
			{
				FinishLoadSceneServerOnly();
			}
			else if (mode == global::Mirror.NetworkManagerMode.ClientOnly)
			{
				FinishLoadSceneClientOnly();
			}
		}

		private void FinishLoadSceneHost()
		{
			if (clientReadyConnection != null)
			{
				clientLoadedScene = true;
				clientReadyConnection = null;
			}
			if (finishStartHostPending)
			{
				finishStartHostPending = false;
				FinishStartHost();
				OnServerSceneChanged(networkSceneName);
				return;
			}
			global::Mirror.NetworkServer.SpawnObjects();
			OnServerSceneChanged(networkSceneName);
			if (global::Mirror.NetworkClient.isConnected)
			{
				OnClientSceneChanged();
			}
		}

		private void FinishLoadSceneServerOnly()
		{
			global::Mirror.NetworkServer.SpawnObjects();
			OnServerSceneChanged(networkSceneName);
		}

		private void FinishLoadSceneClientOnly()
		{
			if (clientReadyConnection != null)
			{
				clientLoadedScene = true;
				clientReadyConnection = null;
			}
			if (global::Mirror.NetworkClient.isConnected)
			{
				OnClientSceneChanged();
			}
		}

		public static void RegisterStartPosition(global::UnityEngine.Transform start)
		{
			startPositions.Add(start);
			startPositions = global::System.Linq.Enumerable.ToList(global::System.Linq.Enumerable.OrderBy(startPositions, (global::UnityEngine.Transform transform) => transform.GetSiblingIndex()));
		}

		public static void UnRegisterStartPosition(global::UnityEngine.Transform start)
		{
			startPositions.Remove(start);
		}

		public virtual global::UnityEngine.Transform GetStartPosition()
		{
			startPositions.RemoveAll((global::UnityEngine.Transform t) => t == null);
			if (startPositions.Count == 0)
			{
				return null;
			}
			if (playerSpawnMethod == global::Mirror.PlayerSpawnMethod.Random)
			{
				return startPositions[global::UnityEngine.Random.Range(0, startPositions.Count)];
			}
			global::UnityEngine.Transform result = startPositions[startPositionIndex];
			startPositionIndex = (startPositionIndex + 1) % startPositions.Count;
			return result;
		}

		private void OnServerConnectInternal(global::Mirror.NetworkConnectionToClient conn)
		{
			if (authenticator != null)
			{
				authenticator.OnServerAuthenticate(conn);
			}
			else
			{
				OnServerAuthenticated(conn);
			}
		}

		private void OnServerAuthenticated(global::Mirror.NetworkConnectionToClient conn)
		{
			conn.isAuthenticated = true;
			if (networkSceneName != "" && networkSceneName != offlineScene)
			{
				global::Mirror.SceneMessage message = new global::Mirror.SceneMessage
				{
					sceneName = networkSceneName
				};
				conn.Send(message);
			}
			OnServerConnect(conn);
		}

		private void OnServerReadyMessageInternal(global::Mirror.NetworkConnectionToClient conn, global::Mirror.ReadyMessage msg)
		{
			OnServerReady(conn);
		}

		private void OnServerAddPlayerInternal(global::Mirror.NetworkConnectionToClient conn, global::Mirror.AddPlayerMessage msg)
		{
			global::Mirror.NetworkIdentity component;
			if (autoCreatePlayer && playerPrefab == null)
			{
				global::UnityEngine.Debug.LogError("The PlayerPrefab is empty on the NetworkManager. Please setup a PlayerPrefab object.");
			}
			else if (autoCreatePlayer && !playerPrefab.TryGetComponent<global::Mirror.NetworkIdentity>(out component))
			{
				global::UnityEngine.Debug.LogError("The PlayerPrefab does not have a NetworkIdentity. Please add a NetworkIdentity to the player prefab.");
			}
			else if (conn.identity != null)
			{
				global::UnityEngine.Debug.LogError("There is already a player for this connection.");
			}
			else
			{
				OnServerAddPlayer(conn);
			}
		}

		private void OnClientConnectInternal()
		{
			if (authenticator != null)
			{
				authenticator.OnClientAuthenticate();
			}
			else
			{
				OnClientAuthenticated();
			}
		}

		private void OnClientAuthenticated()
		{
			global::Mirror.NetworkClient.connection.isAuthenticated = true;
			if (string.IsNullOrWhiteSpace(onlineScene) || onlineScene == offlineScene || global::Mirror.Utils.IsSceneActive(onlineScene))
			{
				clientLoadedScene = false;
			}
			else
			{
				clientLoadedScene = true;
				clientReadyConnection = global::Mirror.NetworkClient.connection;
			}
			OnClientConnect();
		}

		private void OnClientDisconnectInternal()
		{
			if (mode == global::Mirror.NetworkManagerMode.ServerOnly || mode == global::Mirror.NetworkManagerMode.Offline)
			{
				return;
			}
			OnClientDisconnect();
			if (authenticator != null)
			{
				authenticator.OnClientAuthenticated.RemoveListener(OnClientAuthenticated);
				authenticator.OnStopClient();
			}
			if (mode == global::Mirror.NetworkManagerMode.Host)
			{
				mode = global::Mirror.NetworkManagerMode.ServerOnly;
			}
			else
			{
				mode = global::Mirror.NetworkManagerMode.Offline;
			}
			OnStopClient();
			global::Mirror.NetworkClient.Shutdown();
			if (mode != global::Mirror.NetworkManagerMode.ServerOnly)
			{
				if (!string.IsNullOrWhiteSpace(offlineScene) && !global::Mirror.Utils.IsSceneActive(offlineScene) && loadingSceneAsync == null && !global::Mirror.NetworkServer.active)
				{
					ClientChangeScene(offlineScene);
				}
				networkSceneName = "";
			}
		}

		private void OnClientNotReadyMessageInternal(global::Mirror.NotReadyMessage msg)
		{
			global::Mirror.NetworkClient.ready = false;
			OnClientNotReady();
		}

		private void OnClientSceneInternal(global::Mirror.SceneMessage msg)
		{
			if (global::Mirror.NetworkClient.isConnected)
			{
				ClientChangeScene(msg.sceneName, msg.sceneOperation, msg.customHandling);
			}
		}

		public virtual void OnServerConnect(global::Mirror.NetworkConnectionToClient conn)
		{
		}

		public virtual void OnServerDisconnect(global::Mirror.NetworkConnectionToClient conn)
		{
			global::Mirror.NetworkServer.DestroyPlayerForConnection(conn);
		}

		public virtual void OnServerReady(global::Mirror.NetworkConnectionToClient conn)
		{
			_ = conn.identity == null;
			global::Mirror.NetworkServer.SetClientReady(conn);
		}

		public virtual void OnServerAddPlayer(global::Mirror.NetworkConnectionToClient conn)
		{
			global::UnityEngine.Transform startPosition = GetStartPosition();
			global::UnityEngine.GameObject gameObject = ((startPosition != null) ? global::UnityEngine.Object.Instantiate(playerPrefab, startPosition.position, startPosition.rotation) : global::UnityEngine.Object.Instantiate(playerPrefab));
			gameObject.name = $"{playerPrefab.name} [connId={conn.connectionId}]";
			global::Mirror.NetworkServer.AddPlayerForConnection(conn, gameObject);
		}

		public virtual void OnServerError(global::Mirror.NetworkConnectionToClient conn, global::Mirror.TransportError error, string reason)
		{
		}

		public virtual void OnServerChangeScene(string newSceneName)
		{
		}

		public virtual void OnServerSceneChanged(string sceneName)
		{
		}

		public virtual void OnClientConnect()
		{
			if (!clientLoadedScene)
			{
				if (!global::Mirror.NetworkClient.ready)
				{
					global::Mirror.NetworkClient.Ready();
				}
				if (autoCreatePlayer)
				{
					global::Mirror.NetworkClient.AddPlayer();
				}
			}
		}

		public virtual void OnClientDisconnect()
		{
		}

		public virtual void OnClientError(global::Mirror.TransportError error, string reason)
		{
		}

		public virtual void OnClientNotReady()
		{
		}

		public virtual void OnClientChangeScene(string newSceneName, global::Mirror.SceneOperation sceneOperation, bool customHandling)
		{
		}

		public virtual void OnClientSceneChanged()
		{
			if (global::Mirror.NetworkClient.connection.isAuthenticated && !global::Mirror.NetworkClient.ready)
			{
				global::Mirror.NetworkClient.Ready();
			}
			if (global::Mirror.NetworkClient.connection.isAuthenticated && clientSceneOperation == global::Mirror.SceneOperation.Normal && autoCreatePlayer && global::Mirror.NetworkClient.localPlayer == null)
			{
				global::Mirror.NetworkClient.AddPlayer();
			}
		}

		public virtual void OnStartHost()
		{
		}

		public virtual void OnStartServer()
		{
		}

		public virtual void OnStartClient()
		{
		}

		public virtual void OnStopServer()
		{
		}

		public virtual void OnStopClient()
		{
		}

		public virtual void OnStopHost()
		{
		}
	}
}
