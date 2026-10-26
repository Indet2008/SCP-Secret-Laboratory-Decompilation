namespace Mirror
{
	public static class NetworkServer
	{
		private enum DestroyMode
		{
			Destroy = 0,
			Reset = 1
		}

		private static bool initialized;

		public static int maxConnections;

		public static int tickRate = 60;

		private static double lastSendTime;

		public static global::System.Collections.Generic.Dictionary<int, global::Mirror.NetworkConnectionToClient> connections = new global::System.Collections.Generic.Dictionary<int, global::Mirror.NetworkConnectionToClient>();

		internal static global::System.Collections.Generic.Dictionary<ushort, global::Mirror.NetworkMessageDelegate> handlers = new global::System.Collections.Generic.Dictionary<ushort, global::Mirror.NetworkMessageDelegate>();

		public static readonly global::System.Collections.Generic.Dictionary<uint, global::Mirror.NetworkIdentity> spawned = new global::System.Collections.Generic.Dictionary<uint, global::Mirror.NetworkIdentity>();

		public static bool dontListen;

		public static bool isLoadingScene;

		public static global::Mirror.InterestManagementBase aoi;

		public static bool disconnectInactiveConnections;

		public static float disconnectInactiveTimeout = 60f;

		public static global::System.Action<global::Mirror.NetworkConnectionToClient> OnConnectedEvent;

		public static global::System.Action<global::Mirror.NetworkConnectionToClient> OnDisconnectedEvent;

		public static global::System.Action<global::Mirror.NetworkConnectionToClient, global::Mirror.TransportError, string> OnErrorEvent;

		public static int actualTickRate;

		private static double actualTickRateStart;

		private static int actualTickRateCounter;

		public static global::Mirror.TimeSample earlyUpdateDuration;

		public static global::Mirror.TimeSample lateUpdateDuration;

		public static global::Mirror.TimeSample fullUpdateDuration;

		internal static readonly global::System.Collections.Generic.List<global::Mirror.NetworkConnectionToClient> connectionsCopy = new global::System.Collections.Generic.List<global::Mirror.NetworkConnectionToClient>();

		public static float tickInterval
		{
			get
			{
				if (tickRate >= int.MaxValue)
				{
					return 0f;
				}
				return 1f / (float)tickRate;
			}
		}

		public static int sendRate => tickRate;

		public static float sendInterval
		{
			get
			{
				if (sendRate >= int.MaxValue)
				{
					return 0f;
				}
				return 1f / (float)sendRate;
			}
		}

		public static global::Mirror.LocalConnectionToClient localConnection { get; private set; }

		[global::System.Obsolete("NetworkServer.localClientActive was renamed to .activeHost to be more obvious")]
		public static bool localClientActive => activeHost;

		public static bool active { get; internal set; }

		public static bool activeHost => localConnection != null;

		public static void Listen(int maxConns)
		{
			Initialize();
			maxConnections = maxConns;
			if (!dontListen)
			{
				global::Mirror.Transport.active.ServerStart();
			}
			active = true;
			RegisterMessageHandlers();
		}

		private static void Initialize()
		{
			if (!initialized)
			{
				if (!global::Mirror.WeaverFuse.Weaved())
				{
					throw new global::System.Exception("NetworkServer won't start because Weaving failed or didn't run.");
				}
				connections.Clear();
				if (aoi != null)
				{
					aoi.Reset();
				}
				global::Mirror.NetworkTime.ResetStatics();
				AddTransportHandlers();
				initialized = true;
				earlyUpdateDuration = new global::Mirror.TimeSample(sendRate);
				lateUpdateDuration = new global::Mirror.TimeSample(sendRate);
				fullUpdateDuration = new global::Mirror.TimeSample(sendRate);
			}
		}

		private static void AddTransportHandlers()
		{
			global::Mirror.Transport transport = global::Mirror.Transport.active;
			transport.OnServerConnected = (global::System.Action<int>)global::System.Delegate.Combine(transport.OnServerConnected, new global::System.Action<int>(OnTransportConnected));
			global::Mirror.Transport transport2 = global::Mirror.Transport.active;
			transport2.OnServerDataReceived = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(transport2.OnServerDataReceived, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnTransportData));
			global::Mirror.Transport transport3 = global::Mirror.Transport.active;
			transport3.OnServerDisconnected = (global::System.Action<int>)global::System.Delegate.Combine(transport3.OnServerDisconnected, new global::System.Action<int>(OnTransportDisconnected));
			global::Mirror.Transport transport4 = global::Mirror.Transport.active;
			transport4.OnServerError = (global::System.Action<int, global::Mirror.TransportError, string>)global::System.Delegate.Combine(transport4.OnServerError, new global::System.Action<int, global::Mirror.TransportError, string>(OnTransportError));
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		public static void Shutdown()
		{
			if (initialized)
			{
				DisconnectAll();
				global::Mirror.Transport.active.ServerStop();
				RemoveTransportHandlers();
				initialized = false;
			}
			dontListen = false;
			isLoadingScene = false;
			lastSendTime = 0.0;
			actualTickRate = 0;
			localConnection = null;
			connections.Clear();
			connectionsCopy.Clear();
			handlers.Clear();
			CleanupSpawned();
			active = false;
			global::Mirror.NetworkIdentity.ResetStatics();
			OnConnectedEvent = null;
			OnDisconnectedEvent = null;
			OnErrorEvent = null;
			if (aoi != null)
			{
				aoi.Reset();
			}
		}

		private static void RemoveTransportHandlers()
		{
			global::Mirror.Transport transport = global::Mirror.Transport.active;
			transport.OnServerConnected = (global::System.Action<int>)global::System.Delegate.Remove(transport.OnServerConnected, new global::System.Action<int>(OnTransportConnected));
			global::Mirror.Transport transport2 = global::Mirror.Transport.active;
			transport2.OnServerDataReceived = (global::System.Action<int, global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(transport2.OnServerDataReceived, new global::System.Action<int, global::System.ArraySegment<byte>, int>(OnTransportData));
			global::Mirror.Transport transport3 = global::Mirror.Transport.active;
			transport3.OnServerDisconnected = (global::System.Action<int>)global::System.Delegate.Remove(transport3.OnServerDisconnected, new global::System.Action<int>(OnTransportDisconnected));
			global::Mirror.Transport transport4 = global::Mirror.Transport.active;
			transport4.OnServerError = (global::System.Action<int, global::Mirror.TransportError, string>)global::System.Delegate.Remove(transport4.OnServerError, new global::System.Action<int, global::Mirror.TransportError, string>(OnTransportError));
		}

		private static void CleanupSpawned()
		{
			foreach (global::Mirror.NetworkIdentity item in global::System.Linq.Enumerable.ToList(spawned.Values))
			{
				if (item != null)
				{
					if (item.sceneId != 0L)
					{
						DestroyObject(item, global::Mirror.NetworkServer.DestroyMode.Reset);
						item.gameObject.SetActive(value: false);
					}
					else
					{
						DestroyObject(item, global::Mirror.NetworkServer.DestroyMode.Destroy);
					}
				}
			}
			spawned.Clear();
		}

		internal static void RegisterMessageHandlers()
		{
			RegisterHandler<global::Mirror.ReadyMessage>(OnClientReadyMessage);
			RegisterHandler<global::Mirror.CommandMessage>(OnCommandMessage);
			RegisterHandler<global::Mirror.NetworkPingMessage>(global::Mirror.NetworkTime.OnServerPing, requireAuthentication: false);
			RegisterHandler<global::Mirror.NetworkPongMessage>(global::Mirror.NetworkTime.OnServerPong, requireAuthentication: false);
			RegisterHandler<global::Mirror.EntityStateMessage>(OnEntityStateMessage);
			RegisterHandler<global::Mirror.TimeSnapshotMessage>(OnTimeSnapshotMessage);
		}

		private static void OnClientReadyMessage(global::Mirror.NetworkConnectionToClient conn, global::Mirror.ReadyMessage msg)
		{
			SetClientReady(conn);
		}

		private static void OnCommandMessage(global::Mirror.NetworkConnectionToClient conn, global::Mirror.CommandMessage msg, int channelId)
		{
			if (!conn.isReady)
			{
				if (channelId == 0)
				{
					global::UnityEngine.Debug.LogWarning("Command received while client is not ready.\nThis may be ignored if client intentionally set NotReady.");
				}
				return;
			}
			if (!spawned.TryGetValue(msg.netId, out var value))
			{
				if (channelId == 0)
				{
					global::UnityEngine.Debug.LogWarning($"Spawned object not found when handling Command message [netId={msg.netId}]");
				}
				return;
			}
			if (global::Mirror.RemoteCalls.RemoteProcedureCalls.CommandRequiresAuthority(msg.functionHash) && value.connectionToClient != conn)
			{
				global::UnityEngine.Debug.LogWarning($"Command for object without authority [netId={msg.netId}]");
				return;
			}
			using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(msg.payload);
			value.HandleRemoteCall(msg.componentIndex, msg.functionHash, global::Mirror.RemoteCalls.RemoteCallType.Command, reader, conn);
		}

		private static void OnEntityStateMessage(global::Mirror.NetworkConnectionToClient connection, global::Mirror.EntityStateMessage message)
		{
			if (!spawned.TryGetValue(message.netId, out var value) || !(value != null))
			{
				return;
			}
			if (value.connectionToClient == connection)
			{
				using (global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(message.payload))
				{
					if (!value.DeserializeServer(reader))
					{
						global::UnityEngine.Debug.LogWarning($"Server failed to deserialize client state for {value.name} with netId={value.netId}, Disconnecting.");
						connection.Disconnect();
					}
					return;
				}
			}
			global::UnityEngine.Debug.LogWarning($"EntityStateMessage from {connection} for {value} without authority.");
		}

		private static void OnTimeSnapshotMessage(global::Mirror.NetworkConnectionToClient connection, global::Mirror.TimeSnapshotMessage _)
		{
			connection.OnTimeSnapshot(new global::Mirror.TimeSnapshot(connection.remoteTimeStamp, global::Mirror.NetworkTime.localTime));
		}

		public static bool AddConnection(global::Mirror.NetworkConnectionToClient conn)
		{
			if (!connections.ContainsKey(conn.connectionId))
			{
				connections[conn.connectionId] = conn;
				return true;
			}
			return false;
		}

		public static bool RemoveConnection(int connectionId)
		{
			return connections.Remove(connectionId);
		}

		internal static void SetLocalConnection(global::Mirror.LocalConnectionToClient conn)
		{
			if (localConnection != null)
			{
				global::UnityEngine.Debug.LogError("Local Connection already exists");
			}
			else
			{
				localConnection = conn;
			}
		}

		internal static void RemoveLocalConnection()
		{
			if (localConnection != null)
			{
				localConnection.Disconnect();
				localConnection = null;
			}
			RemoveConnection(0);
		}

		public static bool HasExternalConnections()
		{
			if (connections.Count > 0)
			{
				if (connections.Count == 1 && localConnection != null)
				{
					return false;
				}
				return true;
			}
			return false;
		}

		public static void SendToAll<T>(T message, int channelId = 0, bool sendToReadyOnly = false) where T : struct, global::Mirror.NetworkMessage
		{
			if (!active)
			{
				global::UnityEngine.Debug.LogWarning("Can not send using NetworkServer.SendToAll<T>(T msg) because NetworkServer is not active");
				return;
			}
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			global::Mirror.NetworkMessages.Pack(message, networkWriterPooled);
			global::System.ArraySegment<byte> segment = networkWriterPooled.ToArraySegment();
			int num = 0;
			foreach (global::Mirror.NetworkConnectionToClient value in connections.Values)
			{
				if (!sendToReadyOnly || value.isReady)
				{
					num++;
					value.Send(segment, channelId);
				}
			}
			global::Mirror.NetworkDiagnostics.OnSend(message, channelId, segment.Count, num);
		}

		public static void SendToReady<T>(T message, int channelId = 0) where T : struct, global::Mirror.NetworkMessage
		{
			if (!active)
			{
				global::UnityEngine.Debug.LogWarning("Can not send using NetworkServer.SendToReady<T>(T msg) because NetworkServer is not active");
			}
			else
			{
				SendToAll(message, channelId, sendToReadyOnly: true);
			}
		}

		private static void SendToObservers<T>(global::Mirror.NetworkIdentity identity, T message, int channelId = 0) where T : struct, global::Mirror.NetworkMessage
		{
			if (identity == null || identity.observers.Count == 0)
			{
				return;
			}
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			global::Mirror.NetworkMessages.Pack(message, networkWriterPooled);
			global::System.ArraySegment<byte> segment = networkWriterPooled.ToArraySegment();
			foreach (global::Mirror.NetworkConnectionToClient value in identity.observers.Values)
			{
				value.Send(segment, channelId);
			}
			global::Mirror.NetworkDiagnostics.OnSend(message, channelId, segment.Count, identity.observers.Count);
		}

		public static void SendToReadyObservers<T>(global::Mirror.NetworkIdentity identity, T message, bool includeOwner = true, int channelId = 0) where T : struct, global::Mirror.NetworkMessage
		{
			if (identity == null || identity.observers.Count == 0)
			{
				return;
			}
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			global::Mirror.NetworkMessages.Pack(message, networkWriterPooled);
			global::System.ArraySegment<byte> segment = networkWriterPooled.ToArraySegment();
			int num = 0;
			foreach (global::Mirror.NetworkConnectionToClient value in identity.observers.Values)
			{
				if (((value != identity.connectionToClient) | includeOwner) && value.isReady)
				{
					num++;
					value.Send(segment, channelId);
				}
			}
			global::Mirror.NetworkDiagnostics.OnSend(message, channelId, segment.Count, num);
		}

		public static void SendToReadyObservers<T>(global::Mirror.NetworkIdentity identity, T message, int channelId) where T : struct, global::Mirror.NetworkMessage
		{
			SendToReadyObservers(identity, message, includeOwner: true, channelId);
		}

		private static void OnTransportConnected(int connectionId)
		{
			if (connectionId == 0)
			{
				global::UnityEngine.Debug.LogError($"Server.HandleConnect: invalid connectionId: {connectionId} . Needs to be != 0, because 0 is reserved for local player.");
				global::Mirror.Transport.active.ServerDisconnect(connectionId);
			}
			else if (connections.ContainsKey(connectionId))
			{
				global::Mirror.Transport.active.ServerDisconnect(connectionId);
			}
			else if (connections.Count < maxConnections)
			{
				OnConnected(new global::Mirror.NetworkConnectionToClient(connectionId));
			}
			else
			{
				global::Mirror.Transport.active.ServerDisconnect(connectionId);
			}
		}

		internal static void OnConnected(global::Mirror.NetworkConnectionToClient conn)
		{
			AddConnection(conn);
			OnConnectedEvent?.Invoke(conn);
		}

		private static bool UnpackAndInvoke(global::Mirror.NetworkConnectionToClient connection, global::Mirror.NetworkReader reader, int channelId)
		{
			if (global::Mirror.NetworkMessages.UnpackId(reader, out var messageId))
			{
				if (handlers.TryGetValue(messageId, out var value))
				{
					value(connection, reader, channelId);
					connection.lastMessageTime = global::UnityEngine.Time.time;
					return true;
				}
				global::UnityEngine.Debug.LogWarning($"Unknown message id: {messageId} for connection: {connection}. This can happen if no handler was registered for this message.");
				return false;
			}
			global::UnityEngine.Debug.LogWarning($"Invalid message header for connection: {connection}.");
			return false;
		}

		internal static void OnTransportData(int connectionId, global::System.ArraySegment<byte> data, int channelId)
		{
			if (connections.TryGetValue(connectionId, out var value))
			{
				if (!value.unbatcher.AddBatch(data))
				{
					global::UnityEngine.Debug.LogWarning("NetworkServer: received Message was too short (messages should start with message id)");
					value.Disconnect();
					return;
				}
				global::System.ArraySegment<byte> message;
				double remoteTimeStamp;
				while (!isLoadingScene && value.unbatcher.GetNextMessage(out message, out remoteTimeStamp))
				{
					using global::Mirror.NetworkReaderPooled networkReaderPooled = global::Mirror.NetworkReaderPool.Get(message);
					if (networkReaderPooled.Remaining >= 2)
					{
						value.remoteTimeStamp = remoteTimeStamp;
						if (!UnpackAndInvoke(value, networkReaderPooled, channelId))
						{
							global::UnityEngine.Debug.LogWarning($"NetworkServer: failed to unpack and invoke message. Disconnecting {connectionId}.");
							value.Disconnect();
							return;
						}
						continue;
					}
					global::UnityEngine.Debug.LogWarning($"NetworkServer: received Message was too short (messages should start with message id). Disconnecting {connectionId}");
					value.Disconnect();
					return;
				}
				if (!isLoadingScene && value.unbatcher.BatchesCount > 0)
				{
					global::UnityEngine.Debug.LogError($"Still had {value.unbatcher.BatchesCount} batches remaining after processing, even though processing was not interrupted by a scene change. This should never happen, as it would cause ever growing batches.\nPossible reasons:\n* A message didn't deserialize as much as it serialized\n*There was no message handler for a message id, so the reader wasn't read until the end.");
				}
			}
			else
			{
				global::UnityEngine.Debug.LogError($"HandleData Unknown connectionId:{connectionId}");
			}
		}

		internal static void OnTransportDisconnected(int connectionId)
		{
			if (connections.TryGetValue(connectionId, out var value))
			{
				RemoveConnection(connectionId);
				if (OnDisconnectedEvent != null)
				{
					OnDisconnectedEvent(value);
				}
				else
				{
					DestroyPlayerForConnection(value);
				}
			}
		}

		private static void OnTransportError(int connectionId, global::Mirror.TransportError error, string reason)
		{
			global::UnityEngine.Debug.LogWarning($"Server Transport Error for connId={connectionId}: {error}: {reason}. This is fine.");
			connections.TryGetValue(connectionId, out var value);
			OnErrorEvent?.Invoke(value, error, reason);
		}

		public static void DestroyPlayerForConnection(global::Mirror.NetworkConnectionToClient conn)
		{
			conn.DestroyOwnedObjects();
			conn.RemoveFromObservingsObservers();
			conn.identity = null;
		}

		public static void RegisterHandler<T>(global::System.Action<global::Mirror.NetworkConnectionToClient, T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			if (handlers.ContainsKey(id))
			{
				global::UnityEngine.Debug.LogWarning($"NetworkServer.RegisterHandler replacing handler for {typeof(T).FullName}, id={id}. If replacement is intentional, use ReplaceHandler instead to avoid this warning.");
			}
			global::Mirror.NetworkMessages.Lookup[id] = typeof(T);
			handlers[id] = global::Mirror.NetworkMessages.WrapHandler(handler, requireAuthentication);
		}

		public static void RegisterHandler<T>(global::System.Action<global::Mirror.NetworkConnectionToClient, T, int> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			if (handlers.ContainsKey(id))
			{
				global::UnityEngine.Debug.LogWarning($"NetworkServer.RegisterHandler replacing handler for {typeof(T).FullName}, id={id}. If replacement is intentional, use ReplaceHandler instead to avoid this warning.");
			}
			global::Mirror.NetworkMessages.Lookup[id] = typeof(T);
			handlers[id] = global::Mirror.NetworkMessages.WrapHandler(handler, requireAuthentication);
		}

		public static void ReplaceHandler<T>(global::System.Action<T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ReplaceHandler((global::Mirror.NetworkConnectionToClient _, T value) =>
			{
				handler(value);
			}, requireAuthentication);
		}

		public static void ReplaceHandler<T>(global::System.Action<global::Mirror.NetworkConnectionToClient, T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			handlers[id] = global::Mirror.NetworkMessages.WrapHandler(handler, requireAuthentication);
		}

		public static void UnregisterHandler<T>() where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			handlers.Remove(id);
		}

		public static void ClearHandlers()
		{
			handlers.Clear();
		}

		internal static bool GetNetworkIdentity(global::UnityEngine.GameObject go, out global::Mirror.NetworkIdentity identity)
		{
			if (!go.TryGetComponent<global::Mirror.NetworkIdentity>(out identity))
			{
				global::UnityEngine.Debug.LogError("GameObject " + go.name + " doesn't have NetworkIdentity.");
				return false;
			}
			return true;
		}

		public static void DisconnectAll()
		{
			foreach (global::Mirror.NetworkConnectionToClient item in global::System.Linq.Enumerable.ToList(connections.Values))
			{
				item.Disconnect();
				if (item.connectionId != 0)
				{
					OnTransportDisconnected(item.connectionId);
				}
			}
			connections.Clear();
			localConnection = null;
		}

		public static bool AddPlayerForConnection(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject player, uint assetId)
		{
			if (GetNetworkIdentity(player, out var identity))
			{
				identity.assetId = assetId;
			}
			return AddPlayerForConnection(conn, player);
		}

		public static bool AddPlayerForConnection(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject player)
		{
			if (!player.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogWarning($"AddPlayer: playerGameObject has no NetworkIdentity. Please add a NetworkIdentity to {player}");
				return false;
			}
			if (conn.identity != null)
			{
				global::UnityEngine.Debug.Log("AddPlayer: player object already exists");
				return false;
			}
			conn.identity = component;
			component.SetClientOwner(conn);
			if (conn is global::Mirror.LocalConnectionToClient)
			{
				component.isOwned = true;
				global::Mirror.NetworkClient.InternalAddPlayer(component);
			}
			SetClientReady(conn);
			Respawn(component);
			return true;
		}

		public static bool ReplacePlayerForConnection(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject player, bool keepAuthority = false)
		{
			if (!player.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError($"ReplacePlayer: playerGameObject has no NetworkIdentity. Please add a NetworkIdentity to {player}");
				return false;
			}
			if (component.connectionToClient != null && component.connectionToClient != conn)
			{
				global::UnityEngine.Debug.LogError($"Cannot replace player for connection. New player is already owned by a different connection{player}");
				return false;
			}
			global::Mirror.NetworkIdentity identity = conn.identity;
			conn.identity = component;
			component.SetClientOwner(conn);
			if (conn is global::Mirror.LocalConnectionToClient)
			{
				component.isOwned = true;
				global::Mirror.NetworkClient.InternalAddPlayer(component);
			}
			SpawnObserversForConnection(conn);
			Respawn(component);
			if (keepAuthority)
			{
				SendChangeOwnerMessage(identity, conn);
			}
			else
			{
				identity.RemoveClientAuthority();
			}
			return true;
		}

		public static bool ReplacePlayerForConnection(global::Mirror.NetworkConnectionToClient conn, global::UnityEngine.GameObject player, uint assetId, bool keepAuthority = false)
		{
			if (GetNetworkIdentity(player, out var identity))
			{
				identity.assetId = assetId;
			}
			return ReplacePlayerForConnection(conn, player, keepAuthority);
		}

		public static void RemovePlayerForConnection(global::Mirror.NetworkConnection conn, bool destroyServerObject)
		{
			if (conn.identity != null)
			{
				if (destroyServerObject)
				{
					Destroy(conn.identity.gameObject);
				}
				else
				{
					UnSpawn(conn.identity.gameObject);
				}
				conn.identity = null;
			}
		}

		public static void SetClientReady(global::Mirror.NetworkConnectionToClient conn)
		{
			conn.isReady = true;
			if (conn.identity != null)
			{
				SpawnObserversForConnection(conn);
			}
		}

		private static void SpawnObserversForConnection(global::Mirror.NetworkConnectionToClient conn)
		{
			if (!conn.isReady)
			{
				return;
			}
			conn.Send<global::Mirror.ObjectSpawnStartedMessage>(default);
			foreach (global::Mirror.NetworkIdentity value in spawned.Values)
			{
				if (!value.gameObject.activeSelf)
				{
					continue;
				}
				if (value.visible == global::Mirror.Visibility.ForceShown)
				{
					value.AddObserver(conn);
				}
				else
				{
					if (value.visible == global::Mirror.Visibility.ForceHidden || value.visible != global::Mirror.Visibility.Default)
					{
						continue;
					}
					if (aoi != null)
					{
						if (aoi.OnCheckObserver(value, conn))
						{
							value.AddObserver(conn);
						}
					}
					else
					{
						value.AddObserver(conn);
					}
				}
			}
			conn.Send<global::Mirror.ObjectSpawnFinishedMessage>(default);
		}

		public static void SetClientNotReady(global::Mirror.NetworkConnectionToClient conn)
		{
			conn.isReady = false;
			conn.RemoveFromObservingsObservers();
			conn.Send<global::Mirror.NotReadyMessage>(default);
		}

		public static void SetAllClientsNotReady()
		{
			foreach (global::Mirror.NetworkConnectionToClient value in connections.Values)
			{
				SetClientNotReady(value);
			}
		}

		internal static void ShowForConnection(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnection conn)
		{
			if (conn.isReady)
			{
				SendSpawnMessage(identity, conn);
			}
		}

		internal static void HideForConnection(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnection conn)
		{
			global::Mirror.ObjectHideMessage message = new global::Mirror.ObjectHideMessage
			{
				netId = identity.netId
			};
			conn.Send(message);
		}

		internal static void SendSpawnMessage(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnection conn)
		{
			if (identity.serverOnly)
			{
				return;
			}
			using global::Mirror.NetworkWriterPooled ownerWriter = global::Mirror.NetworkWriterPool.Get();
			using global::Mirror.NetworkWriterPooled observersWriter = global::Mirror.NetworkWriterPool.Get();
			bool isOwner = identity.connectionToClient == conn;
			global::System.ArraySegment<byte> payload = CreateSpawnMessagePayload(isOwner, identity, ownerWriter, observersWriter);
			global::Mirror.SpawnMessage message = new global::Mirror.SpawnMessage
			{
				netId = identity.netId,
				isLocalPlayer = (conn.identity == identity),
				isOwner = isOwner,
				sceneId = identity.sceneId,
				assetId = identity.assetId,
				position = identity.transform.localPosition,
				rotation = identity.transform.localRotation,
				scale = identity.transform.localScale,
				payload = payload
			};
			conn.Send(message);
		}

		private static global::System.ArraySegment<byte> CreateSpawnMessagePayload(bool isOwner, global::Mirror.NetworkIdentity identity, global::Mirror.NetworkWriterPooled ownerWriter, global::Mirror.NetworkWriterPooled observersWriter)
		{
			if (identity.NetworkBehaviours.Length == 0)
			{
				return default;
			}
			identity.SerializeServer(initialState: true, ownerWriter, observersWriter);
			global::System.ArraySegment<byte> result = ownerWriter.ToArraySegment();
			global::System.ArraySegment<byte> result2 = observersWriter.ToArraySegment();
			if (!isOwner)
			{
				return result2;
			}
			return result;
		}

		internal static void SendChangeOwnerMessage(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient conn)
		{
			if (identity.netId != 0 && !identity.serverOnly && conn.observing.Contains(identity))
			{
				conn.Send(new global::Mirror.ChangeOwnerMessage
				{
					netId = identity.netId,
					isOwner = (identity.connectionToClient == conn),
					isLocalPlayer = (conn.identity == identity)
				});
			}
		}

		private static bool ValidParent(global::Mirror.NetworkIdentity identity)
		{
			if (!(identity.transform.parent == null))
			{
				return identity.transform.parent.gameObject.activeInHierarchy;
			}
			return true;
		}

		public static bool SpawnObjects()
		{
			if (!active)
			{
				return false;
			}
			global::Mirror.NetworkIdentity[] array = global::UnityEngine.Resources.FindObjectsOfTypeAll<global::Mirror.NetworkIdentity>();
			global::Mirror.NetworkIdentity[] array2 = array;
			foreach (global::Mirror.NetworkIdentity networkIdentity in array2)
			{
				if (global::Mirror.Utils.IsSceneObject(networkIdentity) && networkIdentity.netId == 0)
				{
					networkIdentity.gameObject.SetActive(value: true);
				}
			}
			array2 = array;
			foreach (global::Mirror.NetworkIdentity networkIdentity2 in array2)
			{
				if (global::Mirror.Utils.IsSceneObject(networkIdentity2) && networkIdentity2.netId == 0 && ValidParent(networkIdentity2))
				{
					if (!networkIdentity2.gameObject.activeInHierarchy)
					{
						networkIdentity2.InitializeNetworkBehaviours();
					}
					Spawn(networkIdentity2.gameObject, networkIdentity2.connectionToClient);
				}
			}
			return true;
		}

		public static void Spawn(global::UnityEngine.GameObject obj, global::UnityEngine.GameObject ownerPlayer)
		{
			if (!ownerPlayer.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Player object has no NetworkIdentity");
			}
			else if (component.connectionToClient == null)
			{
				global::UnityEngine.Debug.LogError("Player object is not a player.");
			}
			else
			{
				Spawn(obj, component.connectionToClient);
			}
		}

		private static void Respawn(global::Mirror.NetworkIdentity identity)
		{
			if (identity.netId == 0)
			{
				Spawn(identity.gameObject, identity.connectionToClient);
			}
			else
			{
				SendSpawnMessage(identity, identity.connectionToClient);
			}
		}

		public static void Spawn(global::UnityEngine.GameObject obj, global::Mirror.NetworkConnection ownerConnection = null)
		{
			SpawnObject(obj, ownerConnection);
		}

		public static void Spawn(global::UnityEngine.GameObject obj, uint assetId, global::Mirror.NetworkConnection ownerConnection = null)
		{
			if (GetNetworkIdentity(obj, out var identity))
			{
				identity.assetId = assetId;
			}
			SpawnObject(obj, ownerConnection);
		}

		private static void SpawnObject(global::UnityEngine.GameObject obj, global::Mirror.NetworkConnection ownerConnection)
		{
			global::Mirror.NetworkIdentity component;
			if (global::Mirror.Utils.IsPrefab(obj))
			{
				global::UnityEngine.Debug.LogError("GameObject " + obj.name + " is a prefab, it can't be spawned. Instantiate it first.", obj);
			}
			else if (!active)
			{
				global::UnityEngine.Debug.LogError($"SpawnObject for {obj}, NetworkServer is not active. Cannot spawn objects without an active server.", obj);
			}
			else if (!obj.TryGetComponent<global::Mirror.NetworkIdentity>(out component))
			{
				global::UnityEngine.Debug.LogError($"SpawnObject {obj} has no NetworkIdentity. Please add a NetworkIdentity to {obj}", obj);
			}
			else
			{
				if (component.SpawnedFromInstantiate)
				{
					return;
				}
				if (spawned.ContainsKey(component.netId))
				{
					global::UnityEngine.Debug.LogWarning($"{component} with netId={component.netId} was already spawned.", component.gameObject);
					return;
				}
				component.connectionToClient = (global::Mirror.NetworkConnectionToClient)ownerConnection;
				if (ownerConnection is global::Mirror.LocalConnectionToClient)
				{
					component.isOwned = true;
				}
				if (!component.isServer && component.netId == 0)
				{
					component.isLocalPlayer = global::Mirror.NetworkClient.localPlayer == component;
					component.isClient = global::Mirror.NetworkClient.active;
					component.isServer = true;
					component.netId = global::Mirror.NetworkIdentity.GetNextNetworkId();
					spawned[component.netId] = component;
					component.OnStartServer();
				}
				if ((bool)aoi)
				{
					try
					{
						aoi.OnSpawned(component);
					}
					catch (global::System.Exception exception)
					{
						global::UnityEngine.Debug.LogException(exception);
					}
				}
				RebuildObservers(component, initialize: true);
			}
		}

		public static void UnSpawn(global::UnityEngine.GameObject obj)
		{
			DestroyObject(obj, global::Mirror.NetworkServer.DestroyMode.Reset);
		}

		public static void Destroy(global::UnityEngine.GameObject obj)
		{
			DestroyObject(obj, global::Mirror.NetworkServer.DestroyMode.Destroy);
		}

		private static void DestroyObject(global::UnityEngine.GameObject obj, global::Mirror.NetworkServer.DestroyMode mode)
		{
			global::Mirror.NetworkIdentity identity;
			if (obj == null)
			{
				global::UnityEngine.Debug.Log("NetworkServer DestroyObject is null");
			}
			else if (GetNetworkIdentity(obj, out identity))
			{
				DestroyObject(identity, mode);
			}
		}

		private static void DestroyObject(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkServer.DestroyMode mode)
		{
			if (active && (bool)aoi)
			{
				try
				{
					aoi.OnDestroyed(identity);
				}
				catch (global::System.Exception exception)
				{
					global::UnityEngine.Debug.LogException(exception);
				}
			}
			spawned.Remove(identity.netId);
			identity.connectionToClient?.RemoveOwnedObject(identity);
			SendToObservers(identity, new global::Mirror.ObjectDestroyMessage
			{
				netId = identity.netId
			});
			identity.ClearObservers();
			if (global::Mirror.NetworkClient.active && activeHost)
			{
				if (identity.isLocalPlayer)
				{
					identity.OnStopLocalPlayer();
				}
				identity.OnStopClient();
				identity.isOwned = false;
				identity.NotifyAuthority();
				global::Mirror.NetworkClient.connection.owned.Remove(identity);
				global::Mirror.NetworkClient.spawned.Remove(identity.netId);
			}
			identity.OnStopServer();
			switch (mode)
			{
			case global::Mirror.NetworkServer.DestroyMode.Destroy:
				identity.destroyCalled = true;
				if (global::UnityEngine.Application.isPlaying)
				{
					global::UnityEngine.Object.Destroy(identity.gameObject);
				}
				else
				{
					global::UnityEngine.Object.DestroyImmediate(identity.gameObject);
				}
				break;
			case global::Mirror.NetworkServer.DestroyMode.Reset:
				identity.Reset();
				break;
			}
		}

		private static void RebuildObserversDefault(global::Mirror.NetworkIdentity identity, bool initialize)
		{
			if (initialize && identity.visible != global::Mirror.Visibility.ForceHidden)
			{
				AddAllReadyServerConnectionsToObservers(identity);
			}
		}

		internal static void AddAllReadyServerConnectionsToObservers(global::Mirror.NetworkIdentity identity)
		{
			foreach (global::Mirror.NetworkConnectionToClient value in connections.Values)
			{
				if (value.isReady)
				{
					identity.AddObserver(value);
				}
			}
			if (localConnection != null && localConnection.isReady)
			{
				identity.AddObserver(localConnection);
			}
		}

		public static void RebuildObservers(global::Mirror.NetworkIdentity identity, bool initialize)
		{
			if (aoi == null || identity.visible == global::Mirror.Visibility.ForceShown)
			{
				RebuildObserversDefault(identity, initialize);
			}
			else
			{
				aoi.Rebuild(identity, initialize);
			}
		}

		private static global::Mirror.NetworkWriter SerializeForConnection(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient connection)
		{
			global::Mirror.NetworkIdentitySerialization serverSerializationAtTick = identity.GetServerSerializationAtTick(global::UnityEngine.Time.frameCount);
			if (identity.connectionToClient == connection)
			{
				if (serverSerializationAtTick.ownerWriter.Position > 0)
				{
					return serverSerializationAtTick.ownerWriter;
				}
			}
			else if (serverSerializationAtTick.observersWriter.Position > 0)
			{
				return serverSerializationAtTick.observersWriter;
			}
			return null;
		}

		private static void BroadcastToConnection(global::Mirror.NetworkConnectionToClient connection)
		{
			foreach (global::Mirror.NetworkIdentity item in connection.observing)
			{
				if (item != null)
				{
					global::Mirror.NetworkWriter networkWriter = SerializeForConnection(item, connection);
					if (networkWriter != null)
					{
						global::Mirror.EntityStateMessage message = new global::Mirror.EntityStateMessage
						{
							netId = item.netId,
							payload = networkWriter.ToArraySegment()
						};
						connection.Send(message);
					}
				}
				else
				{
					global::UnityEngine.Debug.LogWarning($"Found 'null' entry in observing list for connectionId={connection.connectionId}. Please call NetworkServer.Destroy to destroy networked objects. Don't use GameObject.Destroy.");
				}
			}
		}

		private static bool DisconnectIfInactive(global::Mirror.NetworkConnectionToClient connection)
		{
			if (disconnectInactiveConnections && !connection.IsAlive(disconnectInactiveTimeout))
			{
				global::UnityEngine.Debug.LogWarning($"Disconnecting {connection} for inactivity!");
				connection.Disconnect();
				return true;
			}
			return false;
		}

		private static void Broadcast()
		{
			connectionsCopy.Clear();
			connections.Values.CopyTo(connectionsCopy);
			foreach (global::Mirror.NetworkConnectionToClient item in connectionsCopy)
			{
				if (!DisconnectIfInactive(item))
				{
					if (item.isReady)
					{
						item.Send<global::Mirror.TimeSnapshotMessage>(default, 1);
						BroadcastToConnection(item);
					}
					item.Update();
				}
			}
		}

		internal static void NetworkEarlyUpdate()
		{
			if (active)
			{
				earlyUpdateDuration.Begin();
				fullUpdateDuration.Begin();
			}
			if (global::Mirror.Transport.active != null)
			{
				global::Mirror.Transport.active.ServerEarlyUpdate();
			}
			foreach (global::Mirror.NetworkConnectionToClient value in connections.Values)
			{
				value.UpdateTimeInterpolation();
			}
			if (active)
			{
				earlyUpdateDuration.End();
			}
		}

		internal static void NetworkLateUpdate()
		{
			if (active)
			{
				lateUpdateDuration.Begin();
				if (!global::UnityEngine.Application.isPlaying || global::Mirror.AccurateInterval.Elapsed(global::Mirror.NetworkTime.localTime, sendInterval, ref lastSendTime))
				{
					Broadcast();
				}
			}
			if (global::Mirror.Transport.active != null)
			{
				global::Mirror.Transport.active.ServerLateUpdate();
			}
			if (active)
			{
				actualTickRateCounter++;
				if (global::Mirror.NetworkTime.localTime >= actualTickRateStart + 1.0)
				{
					float num = (float)(global::Mirror.NetworkTime.localTime - actualTickRateStart);
					actualTickRate = global::UnityEngine.Mathf.RoundToInt((float)actualTickRateCounter / num);
					actualTickRateStart = global::Mirror.NetworkTime.localTime;
					actualTickRateCounter = 0;
				}
				lateUpdateDuration.End();
				fullUpdateDuration.End();
			}
		}

		[global::System.Obsolete("NetworkServer.ActivateHostScene was moved to HostMode.ActivateHostScene")]
		public static void ActivateHostScene()
		{
			global::Mirror.HostMode.ActivateHostScene();
		}
	}
}
