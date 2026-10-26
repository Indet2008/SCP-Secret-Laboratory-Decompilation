namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/Network Room Manager")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-room-manager")]
	public class NetworkRoomManager : global::Mirror.NetworkManager
	{
		public struct PendingPlayer
		{
			public global::Mirror.NetworkConnectionToClient conn;

			public global::UnityEngine.GameObject roomPlayer;
		}

		[global::UnityEngine.Header("Room Settings")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("m_ShowRoomGUI")]
		[global::UnityEngine.SerializeField]
		[global::UnityEngine.Tooltip("This flag controls whether the default UI is shown for the room")]
		public bool showRoomGUI = true;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_MinPlayers")]
		[global::UnityEngine.SerializeField]
		[global::UnityEngine.Tooltip("Minimum number of players to auto-start the game")]
		public int minPlayers = 1;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_RoomPlayerPrefab")]
		[global::UnityEngine.SerializeField]
		[global::UnityEngine.Tooltip("Prefab to use for the Room Player")]
		public global::Mirror.NetworkRoomPlayer roomPlayerPrefab;

		[global::Mirror.Scene]
		public string RoomScene;

		[global::Mirror.Scene]
		public string GameplayScene;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_PendingPlayers")]
		public global::System.Collections.Generic.List<global::Mirror.NetworkRoomManager.PendingPlayer> pendingPlayers = new global::System.Collections.Generic.List<global::Mirror.NetworkRoomManager.PendingPlayer>();

		[global::UnityEngine.Header("Diagnostics")]
		[global::UnityEngine.Tooltip("Diagnostic flag indicating all players are ready to play")]
		[global::UnityEngine.Serialization.FormerlySerializedAs("allPlayersReady")]
		[global::UnityEngine.SerializeField]
		private bool _allPlayersReady;

		[global::UnityEngine.Tooltip("List of Room Player objects")]
		public global::System.Collections.Generic.List<global::Mirror.NetworkRoomPlayer> roomSlots = new global::System.Collections.Generic.List<global::Mirror.NetworkRoomPlayer>();

		public int clientIndex;

		public bool allPlayersReady
		{
			get
			{
				return _allPlayersReady;
			}
			set
			{
				bool num = _allPlayersReady;
				bool flag = value;
				if (num != flag)
				{
					_allPlayersReady = value;
					if (flag)
					{
						OnRoomServerPlayersReady();
					}
					else
					{
						OnRoomServerPlayersNotReady();
					}
				}
			}
		}

		public override void OnValidate()
		{
			base.OnValidate();
			minPlayers = global::UnityEngine.Mathf.Min(minPlayers, maxConnections);
			minPlayers = global::UnityEngine.Mathf.Max(minPlayers, 0);
			if (roomPlayerPrefab != null && roomPlayerPrefab.GetComponent<global::Mirror.NetworkIdentity>() == null)
			{
				roomPlayerPrefab = null;
				global::UnityEngine.Debug.LogError("RoomPlayer prefab must have a NetworkIdentity component.");
			}
		}

		private void SceneLoadedForPlayer(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject roomPlayer)
		{
			global::UnityEngine.Debug.Log($"NetworkRoom SceneLoadedForPlayer scene: {(global::UnityEngine.SceneManagement.SceneManager.GetActiveScene().path)} {conn}");
			if (global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				global::Mirror.NetworkRoomManager.PendingPlayer item = default;
				item.conn = conn;
				item.roomPlayer = roomPlayer;
				pendingPlayers.Add(item);
				return;
			}
			global::UnityEngine.GameObject gameObject = OnRoomServerCreateGamePlayer(conn, roomPlayer);
			if (gameObject == null)
			{
				global::UnityEngine.Transform startPosition = GetStartPosition();
				gameObject = ((startPosition != null) ? global::UnityEngine.Object.Instantiate(playerPrefab, startPosition.position, startPosition.rotation) : global::UnityEngine.Object.Instantiate(playerPrefab, global::UnityEngine.Vector3.zero, global::UnityEngine.Quaternion.identity));
			}
			if (OnRoomServerSceneLoadedForPlayer(conn, roomPlayer, gameObject))
			{
				global::Mirror.NetworkServer.ReplacePlayerForConnection(conn, gameObject, keepAuthority: true);
			}
		}

		internal void CallOnClientEnterRoom()
		{
			OnRoomClientEnter();
			foreach (global::Mirror.NetworkRoomPlayer roomSlot in roomSlots)
			{
				if (roomSlot != null)
				{
					roomSlot.OnClientEnterRoom();
				}
			}
		}

		internal void CallOnClientExitRoom()
		{
			OnRoomClientExit();
			foreach (global::Mirror.NetworkRoomPlayer roomSlot in roomSlots)
			{
				if (roomSlot != null)
				{
					roomSlot.OnClientExitRoom();
				}
			}
		}

		public void CheckReadyToBegin()
		{
			if (global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				int num = global::System.Linq.Enumerable.Count(global::Mirror.NetworkServer.connections, (global::System.Collections.Generic.KeyValuePair<int, global::Mirror.NetworkConnectionToClient> conn) => conn.Value != null && conn.Value.identity != null && conn.Value.identity.TryGetComponent<global::Mirror.NetworkRoomPlayer>(out var component) && component.readyToBegin);
				if (minPlayers <= 0 || num >= minPlayers)
				{
					pendingPlayers.Clear();
					allPlayersReady = true;
				}
				else
				{
					allPlayersReady = false;
				}
			}
		}

		public override void OnServerConnect(global::Mirror.NetworkConnectionToClient conn)
		{
			if (!global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				global::UnityEngine.Debug.Log($"Not in Room scene...disconnecting {conn}");
				conn.Disconnect();
			}
			else
			{
				base.OnServerConnect(conn);
				OnRoomServerConnect(conn);
			}
		}

		public override void OnServerDisconnect(global::Mirror.NetworkConnectionToClient conn)
		{
			if (conn.identity != null)
			{
				global::Mirror.NetworkRoomPlayer component = conn.identity.GetComponent<global::Mirror.NetworkRoomPlayer>();
				if (component != null)
				{
					roomSlots.Remove(component);
				}
				foreach (global::Mirror.NetworkIdentity item in conn.owned)
				{
					component = item.GetComponent<global::Mirror.NetworkRoomPlayer>();
					if (component != null)
					{
						roomSlots.Remove(component);
					}
				}
			}
			allPlayersReady = false;
			foreach (global::Mirror.NetworkRoomPlayer roomSlot in roomSlots)
			{
				if (roomSlot != null)
				{
					roomSlot.GetComponent<global::Mirror.NetworkRoomPlayer>().NetworkreadyToBegin = false;
				}
			}
			if (global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				RecalculateRoomPlayerIndices();
			}
			OnRoomServerDisconnect(conn);
			base.OnServerDisconnect(conn);
			if (base.numPlayers < 1)
			{
				StopServer();
			}
		}

		public override void OnServerReady(global::Mirror.NetworkConnectionToClient conn)
		{
			global::UnityEngine.Debug.Log($"NetworkRoomManager OnServerReady {conn}");
			base.OnServerReady(conn);
			if (conn != null && conn.identity != null)
			{
				global::UnityEngine.GameObject gameObject = conn.identity.gameObject;
				if (gameObject != null && gameObject.GetComponent<global::Mirror.NetworkRoomPlayer>() != null)
				{
					SceneLoadedForPlayer(conn, gameObject);
				}
			}
		}

		public override void OnServerAddPlayer(global::Mirror.NetworkConnectionToClient conn)
		{
			clientIndex++;
			if (global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				allPlayersReady = false;
				global::UnityEngine.GameObject gameObject = OnRoomServerCreateRoomPlayer(conn);
				if (gameObject == null)
				{
					gameObject = global::UnityEngine.Object.Instantiate(roomPlayerPrefab.gameObject, global::UnityEngine.Vector3.zero, global::UnityEngine.Quaternion.identity);
				}
				global::Mirror.NetworkServer.AddPlayerForConnection(conn, gameObject);
			}
			else
			{
				global::UnityEngine.Debug.Log($"Not in Room scene...disconnecting {conn}");
				conn.Disconnect();
			}
		}

		[global::Mirror.Server]
		public void RecalculateRoomPlayerIndices()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogWarning("[Server] function 'System.Void Mirror.NetworkRoomManager::RecalculateRoomPlayerIndices()' called when server was not active");
			}
			else if (roomSlots.Count > 0)
			{
				for (int i = 0; i < roomSlots.Count; i++)
				{
					roomSlots[i].Networkindex = i;
				}
			}
		}

		public override void ServerChangeScene(string newSceneName)
		{
			if (newSceneName == RoomScene)
			{
				foreach (global::Mirror.NetworkRoomPlayer roomSlot in roomSlots)
				{
					if (!(roomSlot == null))
					{
						global::Mirror.NetworkIdentity component = roomSlot.GetComponent<global::Mirror.NetworkIdentity>();
						if (global::Mirror.NetworkServer.active)
						{
							roomSlot.GetComponent<global::Mirror.NetworkRoomPlayer>().NetworkreadyToBegin = false;
							global::Mirror.NetworkServer.ReplacePlayerForConnection(component.connectionToClient, roomSlot.gameObject);
						}
					}
				}
				allPlayersReady = false;
			}
			base.ServerChangeScene(newSceneName);
		}

		public override void OnServerSceneChanged(string sceneName)
		{
			if (sceneName != RoomScene)
			{
				foreach (global::Mirror.NetworkRoomManager.PendingPlayer pendingPlayer in pendingPlayers)
				{
					SceneLoadedForPlayer(pendingPlayer.conn, pendingPlayer.roomPlayer);
				}
				pendingPlayers.Clear();
			}
			OnRoomServerSceneChanged(sceneName);
		}

		public override void OnStartServer()
		{
			if (string.IsNullOrWhiteSpace(RoomScene))
			{
				global::UnityEngine.Debug.LogError("NetworkRoomManager RoomScene is empty. Set the RoomScene in the inspector for the NetworkRoomManager");
			}
			else if (string.IsNullOrWhiteSpace(GameplayScene))
			{
				global::UnityEngine.Debug.LogError("NetworkRoomManager PlayScene is empty. Set the PlayScene in the inspector for the NetworkRoomManager");
			}
			else
			{
				OnRoomStartServer();
			}
		}

		public override void OnStartHost()
		{
			OnRoomStartHost();
		}

		public override void OnStopServer()
		{
			roomSlots.Clear();
			OnRoomStopServer();
		}

		public override void OnStopHost()
		{
			OnRoomStopHost();
		}

		public override void OnStartClient()
		{
			if (roomPlayerPrefab == null || roomPlayerPrefab.gameObject == null)
			{
				global::UnityEngine.Debug.LogError("NetworkRoomManager no RoomPlayer prefab is registered. Please add a RoomPlayer prefab.");
			}
			else
			{
				global::Mirror.NetworkClient.RegisterPrefab(roomPlayerPrefab.gameObject);
			}
			if (playerPrefab == null)
			{
				global::UnityEngine.Debug.LogError("NetworkRoomManager no GamePlayer prefab is registered. Please add a GamePlayer prefab.");
			}
			OnRoomStartClient();
		}

		public override void OnClientConnect()
		{
			OnRoomClientConnect();
			base.OnClientConnect();
		}

		public override void OnClientDisconnect()
		{
			OnRoomClientDisconnect();
			base.OnClientDisconnect();
		}

		public override void OnStopClient()
		{
			OnRoomStopClient();
			CallOnClientExitRoom();
			roomSlots.Clear();
		}

		public override void OnClientSceneChanged()
		{
			if (global::Mirror.Utils.IsSceneActive(RoomScene))
			{
				if (global::Mirror.NetworkClient.isConnected)
				{
					CallOnClientEnterRoom();
				}
			}
			else
			{
				CallOnClientExitRoom();
			}
			base.OnClientSceneChanged();
			OnRoomClientSceneChanged();
		}

		public virtual void OnRoomStartHost()
		{
		}

		public virtual void OnRoomStopHost()
		{
		}

		public virtual void OnRoomStartServer()
		{
		}

		public virtual void OnRoomStopServer()
		{
		}

		public virtual void OnRoomServerConnect(global::Mirror.NetworkConnectionToClient conn)
		{
		}

		public virtual void OnRoomServerDisconnect(global::Mirror.NetworkConnectionToClient conn)
		{
		}

		public virtual void OnRoomServerSceneChanged(string sceneName)
		{
		}

		public virtual global::UnityEngine.GameObject OnRoomServerCreateRoomPlayer(global::Mirror.NetworkConnectionToClient conn)
		{
			return null;
		}

		public virtual global::UnityEngine.GameObject OnRoomServerCreateGamePlayer(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject roomPlayer)
		{
			return null;
		}

		public virtual void OnRoomServerAddPlayer(global::Mirror.NetworkConnectionToClient conn)
		{
			base.OnServerAddPlayer(conn);
		}

		public virtual bool OnRoomServerSceneLoadedForPlayer(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject roomPlayer, global::UnityEngine.GameObject gamePlayer)
		{
			return true;
		}

		public virtual void ReadyStatusChanged()
		{
			int num = 0;
			int num2 = 0;
			foreach (global::Mirror.NetworkRoomPlayer roomSlot in roomSlots)
			{
				if (roomSlot != null)
				{
					num++;
					if (roomSlot.readyToBegin)
					{
						num2++;
					}
				}
			}
			if (num == num2)
			{
				CheckReadyToBegin();
			}
			else
			{
				allPlayersReady = false;
			}
		}

		public virtual void OnRoomServerPlayersReady()
		{
			ServerChangeScene(GameplayScene);
		}

		public virtual void OnRoomServerPlayersNotReady()
		{
		}

		public virtual void OnRoomClientEnter()
		{
		}

		public virtual void OnRoomClientExit()
		{
		}

		public virtual void OnRoomClientConnect()
		{
		}

		public virtual void OnRoomClientDisconnect()
		{
		}

		public virtual void OnRoomStartClient()
		{
		}

		public virtual void OnRoomStopClient()
		{
		}

		public virtual void OnRoomClientSceneChanged()
		{
		}
	}
}
