namespace Mirror
{
	public static class NetworkClient
	{
		private static double lastSendTime;

		internal static readonly global::System.Collections.Generic.Dictionary<ushort, global::Mirror.NetworkMessageDelegate> handlers = new global::System.Collections.Generic.Dictionary<ushort, global::Mirror.NetworkMessageDelegate>();

		public static readonly global::System.Collections.Generic.Dictionary<uint, global::Mirror.NetworkIdentity> spawned = new global::System.Collections.Generic.Dictionary<uint, global::Mirror.NetworkIdentity>();

		public static bool ready;

		internal static global::Mirror.ConnectState connectState = global::Mirror.ConnectState.None;

		public static global::System.Action OnConnectedEvent;

		public static global::System.Action OnDisconnectedEvent;

		public static global::System.Action<global::Mirror.TransportError, string> OnErrorEvent;

		public static readonly global::System.Collections.Generic.Dictionary<uint, global::UnityEngine.GameObject> prefabs = new global::System.Collections.Generic.Dictionary<uint, global::UnityEngine.GameObject>();

		internal static readonly global::System.Collections.Generic.Dictionary<uint, global::Mirror.SpawnHandlerDelegate> spawnHandlers = new global::System.Collections.Generic.Dictionary<uint, global::Mirror.SpawnHandlerDelegate>();

		internal static readonly global::System.Collections.Generic.Dictionary<uint, global::Mirror.UnSpawnDelegate> unspawnHandlers = new global::System.Collections.Generic.Dictionary<uint, global::Mirror.UnSpawnDelegate>();

		internal static bool isSpawnFinished;

		internal static readonly global::System.Collections.Generic.Dictionary<ulong, global::Mirror.NetworkIdentity> spawnableObjects = new global::System.Collections.Generic.Dictionary<ulong, global::Mirror.NetworkIdentity>();

		internal static global::Mirror.Unbatcher unbatcher = new global::Mirror.Unbatcher();

		public static global::Mirror.InterestManagementBase aoi;

		public static bool isLoadingScene;

		public static global::Mirror.ConnectionQuality connectionQuality = global::Mirror.ConnectionQuality.ESTIMATING;

		public static global::Mirror.SnapshotInterpolationSettings snapshotSettings = new global::Mirror.SnapshotInterpolationSettings();

		public static double bufferTimeMultiplier;

		public static global::System.Collections.Generic.SortedList<double, global::Mirror.TimeSnapshot> snapshots = new global::System.Collections.Generic.SortedList<double, global::Mirror.TimeSnapshot>();

		internal static double localTimeline;

		internal static double localTimescale = 1.0;

		private static global::Mirror.ExponentialMovingAverage driftEma;

		[global::UnityEngine.Header("Snapshot Interpolation: Dynamic Adjustment")]
		[global::UnityEngine.Tooltip("Automatically adjust bufferTimeMultiplier for smooth results.\nSets a low multiplier on stable connections, and a high multiplier on jittery connections.")]
		public static bool dynamicAdjustment = true;

		[global::UnityEngine.Tooltip("Safety buffer that is always added to the dynamic bufferTimeMultiplier adjustment.")]
		public static float dynamicAdjustmentTolerance = 1f;

		[global::UnityEngine.Tooltip("Dynamic adjustment is computed over n-second exponential moving average standard deviation.")]
		public static int deliveryTimeEmaDuration = 2;

		private static global::Mirror.ExponentialMovingAverage deliveryTimeEma;

		public static int sendRate => global::Mirror.NetworkServer.sendRate;

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

		public static global::Mirror.NetworkConnection connection { get; internal set; }

		public static global::Mirror.NetworkIdentity localPlayer { get; internal set; }

		public static bool active
		{
			get
			{
				if (connectState != global::Mirror.ConnectState.Connecting)
				{
					return connectState == global::Mirror.ConnectState.Connected;
				}
				return true;
			}
		}

		public static bool activeHost => connection is global::Mirror.LocalConnectionToServer;

		public static bool isConnecting => connectState == global::Mirror.ConnectState.Connecting;

		public static bool isConnected => connectState == global::Mirror.ConnectState.Connected;

		[global::System.Obsolete("NetworkClient.isHostClient was renamed to .activeHost to be more obvious")]
		public static bool isHostClient => activeHost;

		[global::System.Obsolete("NetworkClient snapshot interpolation settings were moved to NetworkClient.snapshotSettings.*")]
		public static float catchupNegativeThreshold => snapshotSettings.catchupNegativeThreshold;

		[global::System.Obsolete("NetworkClient snapshot interpolation settings were moved to NetworkClient.snapshotSettings.*")]
		public static float catchupPositiveThreshold => snapshotSettings.catchupPositiveThreshold;

		[global::System.Obsolete("NetworkClient snapshot interpolation settings were moved to NetworkClient.snapshotSettings.*")]
		public static double catchupSpeed => snapshotSettings.catchupSpeed;

		[global::System.Obsolete("NetworkClient snapshot interpolation settings were moved to NetworkClient.snapshotSettings.*")]
		public static double slowdownSpeed => snapshotSettings.slowdownSpeed;

		[global::System.Obsolete("NetworkClient snapshot interpolation settings were moved to NetworkClient.snapshotSettings.*")]
		public static int driftEmaDuration => snapshotSettings.driftEmaDuration;

		public static double initialBufferTime => (double)global::Mirror.NetworkServer.sendInterval * snapshotSettings.bufferTimeMultiplier;

		public static double bufferTime => (double)global::Mirror.NetworkServer.sendInterval * bufferTimeMultiplier;

		private static void AddTransportHandlers()
		{
			RemoveTransportHandlers();
			global::Mirror.Transport transport = global::Mirror.Transport.active;
			transport.OnClientConnected = (global::System.Action)global::System.Delegate.Combine(transport.OnClientConnected, new global::System.Action(OnTransportConnected));
			global::Mirror.Transport transport2 = global::Mirror.Transport.active;
			transport2.OnClientDataReceived = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Combine(transport2.OnClientDataReceived, new global::System.Action<global::System.ArraySegment<byte>, int>(OnTransportData));
			global::Mirror.Transport transport3 = global::Mirror.Transport.active;
			transport3.OnClientDisconnected = (global::System.Action)global::System.Delegate.Combine(transport3.OnClientDisconnected, new global::System.Action(OnTransportDisconnected));
			global::Mirror.Transport transport4 = global::Mirror.Transport.active;
			transport4.OnClientError = (global::System.Action<global::Mirror.TransportError, string>)global::System.Delegate.Combine(transport4.OnClientError, new global::System.Action<global::Mirror.TransportError, string>(OnTransportError));
		}

		private static void RemoveTransportHandlers()
		{
			global::Mirror.Transport transport = global::Mirror.Transport.active;
			transport.OnClientConnected = (global::System.Action)global::System.Delegate.Remove(transport.OnClientConnected, new global::System.Action(OnTransportConnected));
			global::Mirror.Transport transport2 = global::Mirror.Transport.active;
			transport2.OnClientDataReceived = (global::System.Action<global::System.ArraySegment<byte>, int>)global::System.Delegate.Remove(transport2.OnClientDataReceived, new global::System.Action<global::System.ArraySegment<byte>, int>(OnTransportData));
			global::Mirror.Transport transport3 = global::Mirror.Transport.active;
			transport3.OnClientDisconnected = (global::System.Action)global::System.Delegate.Remove(transport3.OnClientDisconnected, new global::System.Action(OnTransportDisconnected));
			global::Mirror.Transport transport4 = global::Mirror.Transport.active;
			transport4.OnClientError = (global::System.Action<global::Mirror.TransportError, string>)global::System.Delegate.Remove(transport4.OnClientError, new global::System.Action<global::Mirror.TransportError, string>(OnTransportError));
		}

		private static void Initialize(bool hostMode)
		{
			if (!global::Mirror.WeaverFuse.Weaved())
			{
				throw new global::System.Exception("NetworkClient won't start because Weaving failed or didn't run.");
			}
			unbatcher = new global::Mirror.Unbatcher();
			InitTimeInterpolation();
			RegisterMessageHandlers(hostMode);
			global::Mirror.Transport.active.enabled = true;
		}

		public static void Connect(string address)
		{
			Initialize(hostMode: false);
			AddTransportHandlers();
			connectState = global::Mirror.ConnectState.Connecting;
			global::Mirror.Transport.active.ClientConnect(address);
			connection = new global::Mirror.NetworkConnectionToServer();
		}

		public static void Connect(global::System.Uri uri)
		{
			Initialize(hostMode: false);
			AddTransportHandlers();
			connectState = global::Mirror.ConnectState.Connecting;
			global::Mirror.Transport.active.ClientConnect(uri);
			connection = new global::Mirror.NetworkConnectionToServer();
		}

		public static void ConnectHost()
		{
			Initialize(hostMode: true);
			connectState = global::Mirror.ConnectState.Connected;
			global::Mirror.HostMode.SetupConnections();
		}

		[global::System.Obsolete("NetworkClient.ConnectLocalServer was moved to HostMode.InvokeOnConnected")]
		public static void ConnectLocalServer()
		{
			global::Mirror.HostMode.InvokeOnConnected();
		}

		public static void Disconnect()
		{
			if (connectState == global::Mirror.ConnectState.Connecting || connectState == global::Mirror.ConnectState.Connected)
			{
				connectState = global::Mirror.ConnectState.Disconnecting;
				ready = false;
				connection?.Disconnect();
			}
		}

		private static void OnTransportConnected()
		{
			if (connection != null)
			{
				global::Mirror.NetworkTime.ResetStatics();
				connectState = global::Mirror.ConnectState.Connected;
				global::Mirror.NetworkTime.UpdateClient();
				OnConnectedEvent?.Invoke();
			}
			else
			{
				global::UnityEngine.Debug.LogError("Skipped Connect message handling because connection is null.");
			}
		}

		private static bool UnpackAndInvoke(global::Mirror.NetworkReader reader, int channelId)
		{
			if (global::Mirror.NetworkMessages.UnpackId(reader, out var messageId))
			{
				if (handlers.TryGetValue(messageId, out var value))
				{
					value(connection, reader, channelId);
					if (connection != null)
					{
						connection.lastMessageTime = global::UnityEngine.Time.time;
					}
					return true;
				}
				global::UnityEngine.Debug.LogWarning($"Unknown message id: {messageId}. This can happen if no handler was registered for this message.");
				return false;
			}
			global::UnityEngine.Debug.LogWarning("Invalid message header.");
			return false;
		}

		internal static void OnTransportData(global::System.ArraySegment<byte> data, int channelId)
		{
			if (connection != null)
			{
				if (!unbatcher.AddBatch(data))
				{
					global::UnityEngine.Debug.LogWarning("NetworkClient: failed to add batch, disconnecting.");
					connection.Disconnect();
					return;
				}
				global::System.ArraySegment<byte> message;
				double remoteTimeStamp;
				while (!isLoadingScene && unbatcher.GetNextMessage(out message, out remoteTimeStamp))
				{
					using global::Mirror.NetworkReaderPooled networkReaderPooled = global::Mirror.NetworkReaderPool.Get(message);
					if (networkReaderPooled.Remaining >= 2)
					{
						connection.remoteTimeStamp = remoteTimeStamp;
						if (!UnpackAndInvoke(networkReaderPooled, channelId))
						{
							global::UnityEngine.Debug.LogWarning("NetworkClient: failed to unpack and invoke message. Disconnecting.");
							connection.Disconnect();
							return;
						}
						continue;
					}
					global::UnityEngine.Debug.LogWarning("NetworkClient: received Message was too short (messages should start with message id)");
					connection.Disconnect();
					return;
				}
				if (!isLoadingScene && unbatcher.BatchesCount > 0)
				{
					global::UnityEngine.Debug.LogError($"Still had {unbatcher.BatchesCount} batches remaining after processing, even though processing was not interrupted by a scene change. This should never happen, as it would cause ever growing batches.\nPossible reasons:\n* A message didn't deserialize as much as it serialized\n*There was no message handler for a message id, so the reader wasn't read until the end.");
				}
			}
			else
			{
				global::UnityEngine.Debug.LogError("Skipped Data message handling because connection is null.");
			}
		}

		internal static void OnTransportDisconnected()
		{
			if (connectState != global::Mirror.ConnectState.Disconnected)
			{
				OnDisconnectedEvent?.Invoke();
				connectState = global::Mirror.ConnectState.Disconnected;
				ready = false;
				snapshots.Clear();
				localTimeline = 0.0;
				connection = null;
				RemoveTransportHandlers();
			}
		}

		private static void OnTransportError(global::Mirror.TransportError error, string reason)
		{
			global::UnityEngine.Debug.LogWarning($"Client Transport Error: {error}: {reason}. This is fine.");
			OnErrorEvent?.Invoke(error, reason);
		}

		public static void Send<T>(T message, int channelId = 0) where T : struct, global::Mirror.NetworkMessage
		{
			if (connection != null)
			{
				if (connectState == global::Mirror.ConnectState.Connected)
				{
					connection.Send(message, channelId);
				}
				else
				{
					global::UnityEngine.Debug.LogError("NetworkClient Send when not connected to a server");
				}
			}
			else
			{
				global::UnityEngine.Debug.LogError("NetworkClient Send with no connection");
			}
		}

		internal static void RegisterMessageHandlers(bool hostMode)
		{
			if (hostMode)
			{
				RegisterHandler<global::Mirror.ObjectDestroyMessage>(OnHostClientObjectDestroy);
				RegisterHandler<global::Mirror.ObjectHideMessage>(OnHostClientObjectHide);
				RegisterHandler((global::Mirror.NetworkPongMessage _) =>
				{
				}, requireAuthentication: false);
				RegisterHandler<global::Mirror.SpawnMessage>(OnHostClientSpawn);
				RegisterHandler((global::Mirror.ObjectSpawnStartedMessage _) =>
				{
				});
				RegisterHandler((global::Mirror.ObjectSpawnFinishedMessage _) =>
				{
				});
				RegisterHandler((global::Mirror.EntityStateMessage _) =>
				{
				});
			}
			else
			{
				RegisterHandler<global::Mirror.ObjectDestroyMessage>(OnObjectDestroy);
				RegisterHandler<global::Mirror.ObjectHideMessage>(OnObjectHide);
				RegisterHandler<global::Mirror.NetworkPongMessage>(global::Mirror.NetworkTime.OnClientPong, requireAuthentication: false);
				RegisterHandler<global::Mirror.NetworkPingMessage>(global::Mirror.NetworkTime.OnClientPing, requireAuthentication: false);
				RegisterHandler<global::Mirror.SpawnMessage>(OnSpawn);
				RegisterHandler<global::Mirror.ObjectSpawnStartedMessage>(OnObjectSpawnStarted);
				RegisterHandler<global::Mirror.ObjectSpawnFinishedMessage>(OnObjectSpawnFinished);
				RegisterHandler<global::Mirror.EntityStateMessage>(OnEntityStateMessage);
			}
			RegisterHandler<global::Mirror.TimeSnapshotMessage>(OnTimeSnapshotMessage);
			RegisterHandler<global::Mirror.ChangeOwnerMessage>(OnChangeOwner);
			RegisterHandler<global::Mirror.RpcMessage>(OnRPCMessage);
		}

		public static void RegisterHandler<T>(global::System.Action<T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			if (handlers.ContainsKey(id))
			{
				global::UnityEngine.Debug.LogWarning($"NetworkClient.RegisterHandler replacing handler for {typeof(T).FullName}, id={id}. If replacement is intentional, use ReplaceHandler instead to avoid this warning.");
			}
			global::Mirror.NetworkMessages.Lookup[id] = typeof(T);
			handlers[id] = global::Mirror.NetworkMessages.WrapHandler<T, global::Mirror.NetworkConnection>(HandlerWrapped, requireAuthentication);
			void HandlerWrapped(global::Mirror.NetworkConnection _, T value)
			{
				handler(value);
			}
		}

		public static void ReplaceHandler<T>(global::System.Action<global::Mirror.NetworkConnection, T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			handlers[id] = global::Mirror.NetworkMessages.WrapHandler(handler, requireAuthentication);
		}

		public static void ReplaceHandler<T>(global::System.Action<T> handler, bool requireAuthentication = true) where T : struct, global::Mirror.NetworkMessage
		{
			ReplaceHandler((global::Mirror.NetworkConnection _, T value) =>
			{
				handler(value);
			}, requireAuthentication);
		}

		public static bool UnregisterHandler<T>() where T : struct, global::Mirror.NetworkMessage
		{
			ushort id = global::Mirror.NetworkMessageId<T>.Id;
			return handlers.Remove(id);
		}

		public static bool GetPrefab(uint assetId, out global::UnityEngine.GameObject prefab)
		{
			prefab = null;
			if (assetId != 0 && prefabs.TryGetValue(assetId, out prefab))
			{
				return prefab != null;
			}
			return false;
		}

		private static void RegisterPrefabIdentity(global::Mirror.NetworkIdentity prefab)
		{
			if (prefab.assetId == 0)
			{
				global::UnityEngine.Debug.LogError("Can not Register '" + prefab.name + "' because it had empty assetid. If this is a scene Object use RegisterSpawnHandler instead");
				return;
			}
			if (prefab.sceneId != 0L)
			{
				global::UnityEngine.Debug.LogError("Can not Register '" + prefab.name + "' because it has a sceneId, make sure you are passing in the original prefab and not an instance in the scene.");
				return;
			}
			if (prefab.GetComponentsInChildren<global::Mirror.NetworkIdentity>().Length > 1)
			{
				global::UnityEngine.Debug.LogError("Prefab '" + prefab.name + "' has multiple NetworkIdentity components. There should only be one NetworkIdentity on a prefab, and it must be on the root object.");
			}
			if (prefabs.ContainsKey(prefab.assetId))
			{
				global::UnityEngine.GameObject gameObject = prefabs[prefab.assetId];
				global::UnityEngine.Debug.LogWarning($"Replacing existing prefab with assetId '{prefab.assetId}'. Old prefab '{gameObject.name}', New prefab '{prefab.name}'");
			}
			if (spawnHandlers.ContainsKey(prefab.assetId) || unspawnHandlers.ContainsKey(prefab.assetId))
			{
				global::UnityEngine.Debug.LogWarning($"Adding prefab '{prefab.name}' with assetId '{prefab.assetId}' when spawnHandlers with same assetId already exists. If you want to use custom spawn handling, then remove the prefab from NetworkManager's registered prefabs first.");
			}
			prefabs[prefab.assetId] = prefab.gameObject;
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab, uint newAssetId)
		{
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not register prefab because it was null");
				return;
			}
			if (newAssetId == 0)
			{
				global::UnityEngine.Debug.LogError("Could not register '" + prefab.name + "' with new assetId because the new assetId was empty");
				return;
			}
			if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Could not register '" + prefab.name + "' since it contains no NetworkIdentity component");
				return;
			}
			if (component.assetId != 0 && component.assetId != newAssetId)
			{
				global::UnityEngine.Debug.LogError($"Could not register '{prefab.name}' to {newAssetId} because it already had an AssetId, Existing assetId {component.assetId}");
				return;
			}
			component.assetId = newAssetId;
			RegisterPrefabIdentity(component);
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab)
		{
			global::Mirror.NetworkIdentity component;
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not register prefab because it was null");
			}
			else if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out component))
			{
				global::UnityEngine.Debug.LogError("Could not register '" + prefab.name + "' since it contains no NetworkIdentity component");
			}
			else
			{
				RegisterPrefabIdentity(component);
			}
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab, uint newAssetId, global::Mirror.SpawnDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {newAssetId}");
				return;
			}
			RegisterPrefab(prefab, newAssetId, (global::Mirror.SpawnMessage msg) => spawnHandler(msg.position, msg.assetId), unspawnHandler);
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab, global::Mirror.SpawnDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not register handler for prefab because the prefab was null");
				return;
			}
			if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Could not register handler for '" + prefab.name + "' since it contains no NetworkIdentity component");
				return;
			}
			if (component.sceneId != 0L)
			{
				global::UnityEngine.Debug.LogError("Can not Register '" + prefab.name + "' because it has a sceneId, make sure you are passing in the original prefab and not an instance in the scene.");
				return;
			}
			if (component.assetId == 0)
			{
				global::UnityEngine.Debug.LogError("Can not Register handler for '" + prefab.name + "' because it had empty assetid. If this is a scene Object use RegisterSpawnHandler instead");
				return;
			}
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {component.assetId}");
				return;
			}
			RegisterPrefab(prefab, (global::Mirror.SpawnMessage msg) => spawnHandler(msg.position, msg.assetId), unspawnHandler);
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab, uint newAssetId, global::Mirror.SpawnHandlerDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (newAssetId == 0)
			{
				global::UnityEngine.Debug.LogError("Could not register handler for '" + prefab.name + "' with new assetId because the new assetId was empty");
				return;
			}
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not register handler for prefab because the prefab was null");
				return;
			}
			if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Could not register handler for '" + prefab.name + "' since it contains no NetworkIdentity component");
				return;
			}
			if (component.assetId != 0 && component.assetId != newAssetId)
			{
				global::UnityEngine.Debug.LogError($"Could not register Handler for '{prefab.name}' to {newAssetId} because it already had an AssetId, Existing assetId {component.assetId}");
				return;
			}
			if (component.sceneId != 0L)
			{
				global::UnityEngine.Debug.LogError("Can not Register '" + prefab.name + "' because it has a sceneId, make sure you are passing in the original prefab and not an instance in the scene.");
				return;
			}
			component.assetId = newAssetId;
			uint assetId = component.assetId;
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {assetId}");
				return;
			}
			if (unspawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null UnSpawnHandler for {assetId}");
				return;
			}
			if (spawnHandlers.ContainsKey(assetId) || unspawnHandlers.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogWarning($"Replacing existing spawnHandlers for prefab '{prefab.name}' with assetId '{assetId}'");
			}
			if (prefabs.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogError($"assetId '{assetId}' is already used by prefab '{prefabs[assetId].name}', unregister the prefab first before trying to add handler");
			}
			if (prefab.GetComponentsInChildren<global::Mirror.NetworkIdentity>().Length > 1)
			{
				global::UnityEngine.Debug.LogError("Prefab '" + prefab.name + "' has multiple NetworkIdentity components. There should only be one NetworkIdentity on a prefab, and it must be on the root object.");
			}
			spawnHandlers[assetId] = spawnHandler;
			unspawnHandlers[assetId] = unspawnHandler;
		}

		public static void RegisterPrefab(global::UnityEngine.GameObject prefab, global::Mirror.SpawnHandlerDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not register handler for prefab because the prefab was null");
				return;
			}
			if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Could not register handler for '" + prefab.name + "' since it contains no NetworkIdentity component");
				return;
			}
			if (component.sceneId != 0L)
			{
				global::UnityEngine.Debug.LogError("Can not Register '" + prefab.name + "' because it has a sceneId, make sure you are passing in the original prefab and not an instance in the scene.");
				return;
			}
			uint assetId = component.assetId;
			if (assetId == 0)
			{
				global::UnityEngine.Debug.LogError("Can not Register handler for '" + prefab.name + "' because it had empty assetid. If this is a scene Object use RegisterSpawnHandler instead");
				return;
			}
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {assetId}");
				return;
			}
			if (unspawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null UnSpawnHandler for {assetId}");
				return;
			}
			if (spawnHandlers.ContainsKey(assetId) || unspawnHandlers.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogWarning($"Replacing existing spawnHandlers for prefab '{prefab.name}' with assetId '{assetId}'");
			}
			if (prefabs.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogError($"assetId '{assetId}' is already used by prefab '{prefabs[assetId].name}', unregister the prefab first before trying to add handler");
			}
			if (prefab.GetComponentsInChildren<global::Mirror.NetworkIdentity>().Length > 1)
			{
				global::UnityEngine.Debug.LogError("Prefab '" + prefab.name + "' has multiple NetworkIdentity components. There should only be one NetworkIdentity on a prefab, and it must be on the root object.");
			}
			spawnHandlers[assetId] = spawnHandler;
			unspawnHandlers[assetId] = unspawnHandler;
		}

		public static void UnregisterPrefab(global::UnityEngine.GameObject prefab)
		{
			if (prefab == null)
			{
				global::UnityEngine.Debug.LogError("Could not unregister prefab because it was null");
				return;
			}
			if (!prefab.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				global::UnityEngine.Debug.LogError("Could not unregister '" + prefab.name + "' since it contains no NetworkIdentity component");
				return;
			}
			uint assetId = component.assetId;
			prefabs.Remove(assetId);
			spawnHandlers.Remove(assetId);
			unspawnHandlers.Remove(assetId);
		}

		public static void RegisterSpawnHandler(uint assetId, global::Mirror.SpawnDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {assetId}");
				return;
			}
			RegisterSpawnHandler(assetId, (global::Mirror.SpawnMessage msg) => spawnHandler(msg.position, msg.assetId), unspawnHandler);
		}

		public static void RegisterSpawnHandler(uint assetId, global::Mirror.SpawnHandlerDelegate spawnHandler, global::Mirror.UnSpawnDelegate unspawnHandler)
		{
			if (spawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null SpawnHandler for {assetId}");
				return;
			}
			if (unspawnHandler == null)
			{
				global::UnityEngine.Debug.LogError($"Can not Register null UnSpawnHandler for {assetId}");
				return;
			}
			if (assetId == 0)
			{
				global::UnityEngine.Debug.LogError("Can not Register SpawnHandler for empty assetId");
				return;
			}
			if (spawnHandlers.ContainsKey(assetId) || unspawnHandlers.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogWarning($"Replacing existing spawnHandlers for {assetId}");
			}
			if (prefabs.ContainsKey(assetId))
			{
				global::UnityEngine.Debug.LogError($"assetId '{assetId}' is already used by prefab '{prefabs[assetId].name}'");
			}
			spawnHandlers[assetId] = spawnHandler;
			unspawnHandlers[assetId] = unspawnHandler;
		}

		public static void UnregisterSpawnHandler(uint assetId)
		{
			spawnHandlers.Remove(assetId);
			unspawnHandlers.Remove(assetId);
		}

		public static void ClearSpawners()
		{
			prefabs.Clear();
			spawnHandlers.Clear();
			unspawnHandlers.Clear();
		}

		internal static bool InvokeUnSpawnHandler(uint assetId, global::UnityEngine.GameObject obj)
		{
			if (unspawnHandlers.TryGetValue(assetId, out var value) && value != null)
			{
				value(obj);
				return true;
			}
			return false;
		}

		public static bool Ready()
		{
			if (ready)
			{
				global::UnityEngine.Debug.LogError("NetworkClient is already ready. It shouldn't be called twice.");
				return false;
			}
			if (connection == null)
			{
				global::UnityEngine.Debug.LogError("Ready() called with invalid connection object: conn=null");
				return false;
			}
			ready = true;
			connection.isReady = true;
			connection.Send<global::Mirror.ReadyMessage>(default);
			return true;
		}

		internal static void InternalAddPlayer(global::Mirror.NetworkIdentity identity)
		{
			localPlayer = identity;
			if (ready && connection != null)
			{
				connection.identity = identity;
			}
			else
			{
				global::UnityEngine.Debug.LogWarning("NetworkClient can't AddPlayer before being ready. Please call NetworkClient.Ready() first. Clients are considered ready after joining the game world.");
			}
		}

		public static bool AddPlayer()
		{
			if (connection == null)
			{
				global::UnityEngine.Debug.LogError("AddPlayer requires a valid NetworkClient.connection.");
				return false;
			}
			if (!ready)
			{
				global::UnityEngine.Debug.LogError("AddPlayer requires a ready NetworkClient.");
				return false;
			}
			if (connection.identity != null)
			{
				global::UnityEngine.Debug.LogError("NetworkClient.AddPlayer: a PlayerController was already added. Did you call AddPlayer twice?");
				return false;
			}
			connection.Send<global::Mirror.AddPlayerMessage>(default);
			return true;
		}

		internal static void ApplySpawnPayload(global::Mirror.NetworkIdentity identity, global::Mirror.SpawnMessage message)
		{
			if (message.assetId != 0)
			{
				identity.assetId = message.assetId;
			}
			if (!identity.gameObject.activeSelf)
			{
				identity.gameObject.SetActive(value: true);
			}
			identity.transform.localPosition = message.position;
			identity.transform.localRotation = message.rotation;
			identity.transform.localScale = message.scale;
			identity.isOwned = message.isOwner;
			identity.netId = message.netId;
			if (message.isLocalPlayer)
			{
				InternalAddPlayer(identity);
			}
			InitializeIdentityFlags(identity);
			if (message.payload.Count > 0)
			{
				using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(message.payload);
				identity.DeserializeClient(reader, initialState: true);
			}
			spawned[message.netId] = identity;
			if (identity.isOwned)
			{
				connection?.owned.Add(identity);
			}
			if (isSpawnFinished)
			{
				InvokeIdentityCallbacks(identity);
			}
		}

		internal static bool FindOrSpawnObject(global::Mirror.SpawnMessage message, out global::Mirror.NetworkIdentity identity)
		{
			identity = GetExistingObject(message.netId);
			if (identity != null)
			{
				return true;
			}
			if (message.assetId == 0 && message.sceneId == 0L)
			{
				global::UnityEngine.Debug.LogError($"OnSpawn message with netId '{message.netId}' has no AssetId or sceneId");
				return false;
			}
			identity = ((message.sceneId == 0L) ? SpawnPrefab(message) : SpawnSceneObject(message.sceneId));
			if (identity == null)
			{
				global::UnityEngine.Debug.LogError($"Could not spawn assetId={message.assetId} scene={message.sceneId:X} netId={message.netId}");
				return false;
			}
			return true;
		}

		private static global::Mirror.NetworkIdentity GetExistingObject(uint netid)
		{
			spawned.TryGetValue(netid, out var value);
			return value;
		}

		private static global::Mirror.NetworkIdentity SpawnPrefab(global::Mirror.SpawnMessage message)
		{
			if (spawnHandlers.TryGetValue(message.assetId, out var value))
			{
				global::UnityEngine.GameObject gameObject = value(message);
				if (gameObject == null)
				{
					global::UnityEngine.Debug.LogError($"Spawn Handler returned null, Handler assetId '{message.assetId}'");
					return null;
				}
				if (!gameObject.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
				{
					global::UnityEngine.Debug.LogError($"Object Spawned by handler did not have a NetworkIdentity, Handler assetId '{message.assetId}'");
					return null;
				}
				return component;
			}
			if (GetPrefab(message.assetId, out var prefab))
			{
				return global::UnityEngine.Object.Instantiate(prefab, message.position, message.rotation).GetComponent<global::Mirror.NetworkIdentity>();
			}
			global::UnityEngine.Debug.LogError($"Failed to spawn server object, did you forget to add it to the NetworkManager? assetId={message.assetId} netId={message.netId}");
			return null;
		}

		private static global::Mirror.NetworkIdentity SpawnSceneObject(ulong sceneId)
		{
			global::Mirror.NetworkIdentity andRemoveSceneObject = GetAndRemoveSceneObject(sceneId);
			if (andRemoveSceneObject == null)
			{
				global::UnityEngine.Debug.LogError($"Spawn scene object not found for {sceneId:X}. Make sure that client and server use exactly the same project. This only happens if the hierarchy gets out of sync.");
			}
			return andRemoveSceneObject;
		}

		private static global::Mirror.NetworkIdentity GetAndRemoveSceneObject(ulong sceneId)
		{
			if (spawnableObjects.TryGetValue(sceneId, out var value))
			{
				spawnableObjects.Remove(sceneId);
				return value;
			}
			return null;
		}

		public static void PrepareToSpawnSceneObjects()
		{
			spawnableObjects.Clear();
			global::Mirror.NetworkIdentity[] array = global::UnityEngine.Resources.FindObjectsOfTypeAll<global::Mirror.NetworkIdentity>();
			foreach (global::Mirror.NetworkIdentity networkIdentity in array)
			{
				if (global::Mirror.Utils.IsSceneObject(networkIdentity) && networkIdentity.netId == 0)
				{
					if (spawnableObjects.TryGetValue(networkIdentity.sceneId, out var value))
					{
						global::UnityEngine.Debug.LogWarning($"NetworkClient: Duplicate sceneId {networkIdentity.sceneId} detected on {networkIdentity.gameObject.name} and {value.gameObject.name}\n" + "This can happen if a networked object is persisted in DontDestroyOnLoad through loading / changing to the scene where it originated,\n" + $"otherwise you may need to open and re-save the {networkIdentity.gameObject.scene} to reset scene id's.", networkIdentity.gameObject);
					}
					else
					{
						spawnableObjects.Add(networkIdentity.sceneId, networkIdentity);
					}
				}
			}
		}

		internal static void OnObjectSpawnStarted(global::Mirror.ObjectSpawnStartedMessage _)
		{
			PrepareToSpawnSceneObjects();
			isSpawnFinished = false;
		}

		internal static void OnObjectSpawnFinished(global::Mirror.ObjectSpawnFinishedMessage _)
		{
			foreach (global::Mirror.NetworkIdentity item in global::System.Linq.Enumerable.OrderBy(spawned.Values, (global::Mirror.NetworkIdentity uv) => uv.netId))
			{
				if (item != null)
				{
					BootstrapIdentity(item);
				}
				else
				{
					global::UnityEngine.Debug.LogWarning("Found null entry in NetworkClient.spawned. This is unexpected. Was the NetworkIdentity not destroyed properly?");
				}
			}
			isSpawnFinished = true;
		}

		private static void OnHostClientObjectDestroy(global::Mirror.ObjectDestroyMessage message)
		{
			if (spawned.TryGetValue(message.netId, out var value))
			{
				connection.owned.Remove(value);
			}
			spawned.Remove(message.netId);
		}

		private static void OnHostClientObjectHide(global::Mirror.ObjectHideMessage message)
		{
			if (spawned.TryGetValue(message.netId, out var value) && value != null && aoi != null)
			{
				aoi.SetHostVisibility(value, visible: false);
			}
		}

		internal static void OnHostClientSpawn(global::Mirror.SpawnMessage message)
		{
			if (global::Mirror.NetworkServer.spawned.TryGetValue(message.netId, out var value) && value != null)
			{
				spawned[message.netId] = value;
				if (message.isOwner)
				{
					connection.owned.Add(value);
				}
				if (message.isLocalPlayer)
				{
					InternalAddPlayer(value);
				}
				if (aoi != null)
				{
					aoi.SetHostVisibility(value, visible: true);
				}
				value.isOwned = message.isOwner;
				BootstrapIdentity(value);
			}
		}

		private static void OnEntityStateMessage(global::Mirror.EntityStateMessage message)
		{
			if (spawned.TryGetValue(message.netId, out var value) && value != null)
			{
				using (global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(message.payload))
				{
					value.DeserializeClient(reader, initialState: false);
					return;
				}
			}
			global::UnityEngine.Debug.LogWarning($"Did not find target for sync message for {message.netId}. Were all prefabs added to the NetworkManager's spawnable list?\nNote: this can be completely normal because UDP messages may arrive out of order, so this message might have arrived after a Destroy message.");
		}

		private static void OnRPCMessage(global::Mirror.RpcMessage message)
		{
			if (spawned.TryGetValue(message.netId, out var value))
			{
				using (global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(message.payload))
				{
					value.HandleRemoteCall(message.componentIndex, message.functionHash, global::Mirror.RemoteCalls.RemoteCallType.ClientRpc, reader);
				}
			}
		}

		private static void OnObjectHide(global::Mirror.ObjectHideMessage message)
		{
			DestroyObject(message.netId);
		}

		internal static void OnObjectDestroy(global::Mirror.ObjectDestroyMessage message)
		{
			DestroyObject(message.netId);
		}

		internal static void OnSpawn(global::Mirror.SpawnMessage message)
		{
			if (FindOrSpawnObject(message, out var identity))
			{
				ApplySpawnPayload(identity, message);
			}
		}

		internal static void OnChangeOwner(global::Mirror.ChangeOwnerMessage message)
		{
			global::Mirror.NetworkIdentity existingObject = GetExistingObject(message.netId);
			if (existingObject != null)
			{
				ChangeOwner(existingObject, message);
			}
			else
			{
				global::UnityEngine.Debug.LogError($"OnChangeOwner: Could not find object with netId {message.netId}");
			}
		}

		internal static void ChangeOwner(global::Mirror.NetworkIdentity identity, global::Mirror.ChangeOwnerMessage message)
		{
			if (identity.isLocalPlayer && !message.isLocalPlayer)
			{
				identity.OnStopLocalPlayer();
			}
			identity.isOwned = message.isOwner;
			if (identity.isOwned)
			{
				connection?.owned.Add(identity);
			}
			else
			{
				connection?.owned.Remove(identity);
			}
			identity.NotifyAuthority();
			identity.isLocalPlayer = message.isLocalPlayer;
			if (identity.isLocalPlayer)
			{
				localPlayer = identity;
				identity.connectionToServer = connection;
				identity.OnStartLocalPlayer();
			}
			else if (localPlayer == identity)
			{
				localPlayer = null;
			}
		}

		private static void InitializeIdentityFlags(global::Mirror.NetworkIdentity identity)
		{
			identity.isClient = true;
			identity.isLocalPlayer = localPlayer == identity;
			if (identity.isLocalPlayer)
			{
				identity.connectionToServer = connection;
			}
		}

		private static void InvokeIdentityCallbacks(global::Mirror.NetworkIdentity identity)
		{
			identity.NotifyAuthority();
			identity.OnStartClient();
			if (identity.isLocalPlayer)
			{
				identity.OnStartLocalPlayer();
			}
		}

		private static void BootstrapIdentity(global::Mirror.NetworkIdentity identity)
		{
			InitializeIdentityFlags(identity);
			InvokeIdentityCallbacks(identity);
		}

		private static void BroadcastTimeSnapshot()
		{
			Send<global::Mirror.TimeSnapshotMessage>(default, 1);
		}

		private static void Broadcast()
		{
			if (!connection.isReady || global::Mirror.NetworkServer.active)
			{
				return;
			}
			BroadcastTimeSnapshot();
			foreach (global::Mirror.NetworkIdentity item in connection.owned)
			{
				if (item != null)
				{
					using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
					item.SerializeClient(networkWriterPooled);
					if (networkWriterPooled.Position > 0)
					{
						Send(new global::Mirror.EntityStateMessage
						{
							netId = item.netId,
							payload = networkWriterPooled.ToArraySegment()
						});
					}
				}
				else
				{
					global::UnityEngine.Debug.LogWarning("Found 'null' entry in owned list for client. This is unexpected behaviour.");
				}
			}
		}

		internal static void NetworkEarlyUpdate()
		{
			if (global::Mirror.Transport.active != null)
			{
				global::Mirror.Transport.active.ClientEarlyUpdate();
			}
			UpdateTimeInterpolation();
		}

		internal static void NetworkLateUpdate()
		{
			if (active && (!global::UnityEngine.Application.isPlaying || global::Mirror.AccurateInterval.Elapsed(global::Mirror.NetworkTime.localTime, sendInterval, ref lastSendTime)))
			{
				Broadcast();
			}
			if (connection is global::Mirror.LocalConnectionToServer localConnectionToServer)
			{
				localConnectionToServer.Update();
			}
			else if (connection is global::Mirror.NetworkConnectionToServer networkConnectionToServer && active && connectState == global::Mirror.ConnectState.Connected)
			{
				global::Mirror.NetworkTime.UpdateClient();
				networkConnectionToServer.Update();
			}
			if (global::Mirror.Transport.active != null)
			{
				global::Mirror.Transport.active.ClientLateUpdate();
			}
		}

		public static void DestroyAllClientObjects()
		{
			try
			{
				foreach (global::Mirror.NetworkIdentity value in spawned.Values)
				{
					if (!(value != null) || !(value.gameObject != null))
					{
						continue;
					}
					if (value.isLocalPlayer)
					{
						value.OnStopLocalPlayer();
					}
					value.OnStopClient();
					bool flag = value.connectionToServer is global::Mirror.LocalConnectionToServer;
					if (!value.isServer | flag)
					{
						if (InvokeUnSpawnHandler(value.assetId, value.gameObject))
						{
							value.Reset();
						}
						else if (value.sceneId != 0L)
						{
							value.Reset();
							value.gameObject.SetActive(value: false);
						}
						else
						{
							global::UnityEngine.Object.Destroy(value.gameObject);
						}
					}
				}
				spawned.Clear();
				connection?.owned.Clear();
			}
			catch (global::System.InvalidOperationException exception)
			{
				global::UnityEngine.Debug.LogException(exception);
				global::UnityEngine.Debug.LogError("Could not DestroyAllClientObjects because spawned list was modified during loop, make sure you are not modifying NetworkIdentity.spawned by calling NetworkServer.Destroy or NetworkServer.Spawn in OnDestroy or OnDisable.");
			}
		}

		private static void DestroyObject(uint netId)
		{
			if (spawned.TryGetValue(netId, out var value) && value != null)
			{
				if (value.isLocalPlayer)
				{
					value.OnStopLocalPlayer();
				}
				value.OnStopClient();
				if (InvokeUnSpawnHandler(value.assetId, value.gameObject))
				{
					value.Reset();
				}
				else if (value.sceneId == 0L)
				{
					global::UnityEngine.Object.Destroy(value.gameObject);
				}
				else
				{
					value.gameObject.SetActive(value: false);
					spawnableObjects[value.sceneId] = value;
					value.Reset();
				}
				connection.owned.Remove(value);
				spawned.Remove(netId);
			}
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		public static void Shutdown()
		{
			DestroyAllClientObjects();
			ClearSpawners();
			spawned.Clear();
			connection?.owned.Clear();
			handlers.Clear();
			spawnableObjects.Clear();
			global::Mirror.NetworkIdentity.ResetClientStatics();
			if (global::Mirror.Transport.active != null)
			{
				global::Mirror.Transport.active.ClientDisconnect();
			}
			connectState = global::Mirror.ConnectState.None;
			connection = null;
			localPlayer = null;
			ready = false;
			isSpawnFinished = false;
			isLoadingScene = false;
			lastSendTime = 0.0;
			unbatcher = new global::Mirror.Unbatcher();
			OnConnectedEvent = null;
			OnDisconnectedEvent = null;
			OnErrorEvent = null;
		}

		private static void InitTimeInterpolation()
		{
			bufferTimeMultiplier = snapshotSettings.bufferTimeMultiplier;
			localTimeline = 0.0;
			localTimescale = 1.0;
			snapshots.Clear();
			driftEma = new global::Mirror.ExponentialMovingAverage(global::Mirror.NetworkServer.sendRate * snapshotSettings.driftEmaDuration);
			deliveryTimeEma = new global::Mirror.ExponentialMovingAverage(global::Mirror.NetworkServer.sendRate * snapshotSettings.deliveryTimeEmaDuration);
		}

		private static void OnTimeSnapshotMessage(global::Mirror.TimeSnapshotMessage _)
		{
			OnTimeSnapshot(new global::Mirror.TimeSnapshot(connection.remoteTimeStamp, global::Mirror.NetworkTime.localTime));
		}

		public static void OnTimeSnapshot(global::Mirror.TimeSnapshot snap)
		{
			if (snapshotSettings.dynamicAdjustment)
			{
				bufferTimeMultiplier = global::Mirror.SnapshotInterpolation.DynamicAdjustment(global::Mirror.NetworkServer.sendInterval, deliveryTimeEma.StandardDeviation, snapshotSettings.dynamicAdjustmentTolerance);
			}
			global::Mirror.SnapshotInterpolation.InsertAndAdjust(snapshots, snapshotSettings.bufferLimit, snap, ref localTimeline, ref localTimescale, global::Mirror.NetworkServer.sendInterval, bufferTime, snapshotSettings.catchupSpeed, snapshotSettings.slowdownSpeed, ref driftEma, snapshotSettings.catchupNegativeThreshold, snapshotSettings.catchupPositiveThreshold, ref deliveryTimeEma);
		}

		private static void UpdateTimeInterpolation()
		{
			if (snapshots.Count > 0)
			{
				global::Mirror.SnapshotInterpolation.StepTime(global::UnityEngine.Time.unscaledDeltaTime, ref localTimeline, localTimescale);
				global::Mirror.SnapshotInterpolation.StepInterpolation(snapshots, localTimeline, out var _, out var _, out var _);
			}
		}
	}
}
