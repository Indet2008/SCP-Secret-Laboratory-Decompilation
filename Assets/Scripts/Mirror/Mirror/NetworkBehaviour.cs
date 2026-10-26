namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/networkbehaviour")]
	public abstract class NetworkBehaviour : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.Tooltip("Server Authority calls OnSerialize on the server and syncs it to clients.\n\nClient Authority calls OnSerialize on the owning client, syncs it to server, which then broadcasts it to all other clients.\n\nUse server authority for cheat safety.")]
		[global::UnityEngine.HideInInspector]
		public global::Mirror.SyncDirection syncDirection;

		[global::UnityEngine.Tooltip("By default synced data is sent from the server to all Observers of the object.\nChange this to Owner to only have the server update the client that has ownership authority for this object")]
		[global::UnityEngine.HideInInspector]
		public global::Mirror.SyncMode syncMode;

		[global::UnityEngine.Tooltip("Time in seconds until next change is synchronized to the client. '0' means send immediately if changed. '0.5' means only send changes every 500ms.\n(This is for state synchronization like SyncVars, SyncLists, OnSerialize. Not for Cmds, Rpcs, etc.)")]
		[global::UnityEngine.Range(0f, 2f)]
		[global::UnityEngine.HideInInspector]
		public float syncInterval;

		internal double lastSyncTime;

		protected readonly global::System.Collections.Generic.List<global::Mirror.SyncObject> syncObjects = new global::System.Collections.Generic.List<global::Mirror.SyncObject>();

		internal ulong syncObjectDirtyBits;

		private ulong syncVarHookGuard;

		private global::Mirror.NetworkIdentity _identityCache;

		private bool _identitySet;

		public bool isServer => netIdentity.isServer;

		public bool isClient => netIdentity.isClient;

		public bool isLocalPlayer => netIdentity.isLocalPlayer;

		public bool isServerOnly => netIdentity.isServerOnly;

		public bool isClientOnly => netIdentity.isClientOnly;

		public bool isOwned => netIdentity.isOwned;

		[global::System.Obsolete(".hasAuthority was renamed to .isOwned. This is easier to understand and prepares for SyncDirection, where there is a difference betwen isOwned and authority.")]
		public bool hasAuthority => isOwned;

		public bool authority
		{
			get
			{
				if (!isClient)
				{
					return syncDirection == global::Mirror.SyncDirection.ServerToClient;
				}
				if (syncDirection == global::Mirror.SyncDirection.ClientToServer)
				{
					return isOwned;
				}
				return false;
			}
		}

		public uint netId => netIdentity.netId;

		public global::Mirror.NetworkConnection connectionToServer => netIdentity.connectionToServer;

		public global::Mirror.NetworkConnectionToClient connectionToClient => netIdentity.connectionToClient;

		public global::Mirror.NetworkIdentity netIdentity
		{
			get
			{
				if (_identitySet)
				{
					return _identityCache;
				}
				_identitySet = true;
				_identityCache = GetComponent<global::Mirror.NetworkIdentity>();
				return _identityCache;
			}
			internal set
			{
				_identityCache = value;
			}
		}

		public byte ComponentIndex { get; internal set; }

		protected ulong syncVarDirtyBits { get; private set; }

		internal bool HasSyncObjects()
		{
			return syncObjects.Count > 0;
		}

		protected bool GetSyncVarHookGuard(ulong dirtyBit)
		{
			return (syncVarHookGuard & dirtyBit) != 0;
		}

		protected void SetSyncVarHookGuard(ulong dirtyBit, bool value)
		{
			if (value)
			{
				syncVarHookGuard |= dirtyBit;
			}
			else
			{
				syncVarHookGuard &= ~dirtyBit;
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		private void SetSyncObjectDirtyBit(ulong dirtyBit)
		{
			syncObjectDirtyBits |= dirtyBit;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void SetSyncVarDirtyBit(ulong dirtyBit)
		{
			syncVarDirtyBits |= dirtyBit;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void SetDirty()
		{
			SetSyncVarDirtyBit(ulong.MaxValue);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public bool IsDirty()
		{
			if ((syncVarDirtyBits | syncObjectDirtyBits) != 0L)
			{
				return global::Mirror.NetworkTime.localTime - lastSyncTime >= (double)syncInterval;
			}
			return false;
		}

		public void ClearAllDirtyBits()
		{
			lastSyncTime = global::Mirror.NetworkTime.localTime;
			syncVarDirtyBits = 0uL;
			syncObjectDirtyBits = 0uL;
			for (int i = 0; i < syncObjects.Count; i++)
			{
				syncObjects[i].ClearChanges();
			}
		}

		protected void InitSyncObject(global::Mirror.SyncObject syncObject)
		{
			if (syncObject == null)
			{
				global::UnityEngine.Debug.LogError("Uninitialized SyncObject. Manually call the constructor on your SyncList, SyncSet, SyncDictionary or SyncField<T>");
				return;
			}
			int count = syncObjects.Count;
			syncObjects.Add(syncObject);
			ulong nthBit = (ulong)(1L << count);
			syncObject.OnDirty = () =>
			{
				SetSyncObjectDirtyBit(nthBit);
			};
			syncObject.IsWritable = () =>
			{
				if (global::Mirror.NetworkServer.active && global::Mirror.NetworkClient.active)
				{
					if (syncDirection != global::Mirror.SyncDirection.ServerToClient)
					{
						return isOwned;
					}
					return true;
				}
				if (global::Mirror.NetworkServer.active)
				{
					return syncDirection == global::Mirror.SyncDirection.ServerToClient;
				}
				if (global::Mirror.NetworkClient.active)
				{
					if (netId != 0)
					{
						if (syncDirection == global::Mirror.SyncDirection.ClientToServer)
						{
							return isOwned;
						}
						return false;
					}
					return true;
				}
				throw new global::System.Exception("InitSyncObject: IsWritable: neither NetworkServer nor NetworkClient are active.");
			};
			syncObject.IsRecording = () =>
			{
				if (isServer && isClient)
				{
					return netIdentity.observers.Count > 0;
				}
				if (isServer)
				{
					return netIdentity.observers.Count > 0;
				}
				return isClient && syncDirection == global::Mirror.SyncDirection.ClientToServer && isOwned;
			};
		}

		protected virtual void OnValidate()
		{
		}

		protected void SendCommandInternal(string functionFullName, int functionHashCode, global::Mirror.NetworkWriter writer, int channelId, bool requiresAuthority = true)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("Command " + functionFullName + " called on " + base.name + " without an active client.", base.gameObject);
			}
			else if (!global::Mirror.NetworkClient.ready)
			{
				if (channelId == 0)
				{
					global::UnityEngine.Debug.LogWarning("Command " + functionFullName + " called on " + base.name + " while NetworkClient is not ready.\nThis may be ignored if client intentionally set NotReady.", base.gameObject);
				}
			}
			else if (requiresAuthority && !isLocalPlayer && !isOwned)
			{
				global::UnityEngine.Debug.LogWarning("Command " + functionFullName + " called on " + base.name + " without authority.", base.gameObject);
			}
			else if (global::Mirror.NetworkClient.connection == null)
			{
				global::UnityEngine.Debug.LogError("Command " + functionFullName + " called on " + base.name + " with no client running.", base.gameObject);
			}
			else
			{
				global::Mirror.CommandMessage message = new global::Mirror.CommandMessage
				{
					netId = netId,
					componentIndex = ComponentIndex,
					functionHash = (ushort)functionHashCode,
					payload = writer.ToArraySegment()
				};
				global::Mirror.NetworkClient.connection.Send(message, channelId);
			}
		}

		protected void SendRPCInternal(string functionFullName, int functionHashCode, global::Mirror.NetworkWriter writer, int channelId, bool includeOwner)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("RPC Function " + functionFullName + " called without an active server.", base.gameObject);
				return;
			}
			if (!isServer)
			{
				global::UnityEngine.Debug.LogWarning("ClientRpc " + functionFullName + " called on un-spawned object: " + base.name, base.gameObject);
				return;
			}
			global::Mirror.RpcMessage rpcMessage = new global::Mirror.RpcMessage
			{
				netId = netId,
				componentIndex = ComponentIndex,
				functionHash = (ushort)functionHashCode,
				payload = writer.ToArraySegment()
			};
			if (netIdentity.observers == null || netIdentity.observers.Count == 0)
			{
				return;
			}
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			networkWriterPooled.Write(rpcMessage);
			foreach (global::Mirror.NetworkConnectionToClient value in netIdentity.observers.Values)
			{
				if (((value != netIdentity.connectionToClient) | includeOwner) && value.isReady)
				{
					value.Send(rpcMessage, channelId);
				}
			}
		}

		protected void SendTargetRPCInternal(global::Mirror.NetworkConnection conn, string functionFullName, int functionHashCode, global::Mirror.NetworkWriter writer, int channelId)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("TargetRPC " + functionFullName + " was called on " + base.name + " when server not active.", base.gameObject);
				return;
			}
			if (!isServer)
			{
				global::UnityEngine.Debug.LogWarning("TargetRpc " + functionFullName + " called on " + base.name + " but that object has not been spawned or has been unspawned.", base.gameObject);
				return;
			}
			if (conn == null)
			{
				conn = connectionToClient;
			}
			if (conn == null)
			{
				global::UnityEngine.Debug.LogError("TargetRPC " + functionFullName + " can't be sent because it was given a null connection. Make sure " + base.name + " is owned by a connection, or if you pass a connection manually then make sure it's not null. For example, TargetRpcs can be called on Player/Pet which are owned by a connection. However, they can not be called on Monsters/Npcs which don't have an owner connection.", base.gameObject);
			}
			else if (!(conn is global::Mirror.NetworkConnectionToClient))
			{
				global::UnityEngine.Debug.LogError("TargetRPC " + functionFullName + " called on " + base.name + " requires a NetworkConnectionToClient but was given " + conn.GetType().Name, base.gameObject);
			}
			else
			{
				global::Mirror.RpcMessage message = new global::Mirror.RpcMessage
				{
					netId = netId,
					componentIndex = ComponentIndex,
					functionHash = (ushort)functionHashCode,
					payload = writer.ToArraySegment()
				};
				conn.Send(message, channelId);
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void GeneratedSyncVarSetter<T>(T value, ref T field, ulong dirtyBit, global::System.Action<T, T> OnChanged)
		{
			if (!SyncVarEqual(value, ref field))
			{
				T arg = field;
				SetSyncVar(value, ref field, dirtyBit);
				if (OnChanged != null && global::Mirror.NetworkServer.activeHost && !GetSyncVarHookGuard(dirtyBit))
				{
					SetSyncVarHookGuard(dirtyBit, value: true);
					OnChanged(arg, value);
					SetSyncVarHookGuard(dirtyBit, value: false);
				}
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void GeneratedSyncVarSetter_GameObject(global::UnityEngine.GameObject value, ref global::UnityEngine.GameObject field, ulong dirtyBit, global::System.Action<global::UnityEngine.GameObject, global::UnityEngine.GameObject> OnChanged, ref uint netIdField)
		{
			if (!SyncVarGameObjectEqual(value, netIdField))
			{
				global::UnityEngine.GameObject arg = field;
				SetSyncVarGameObject(value, ref field, dirtyBit, ref netIdField);
				if (OnChanged != null && global::Mirror.NetworkServer.activeHost && !GetSyncVarHookGuard(dirtyBit))
				{
					SetSyncVarHookGuard(dirtyBit, value: true);
					OnChanged(arg, value);
					SetSyncVarHookGuard(dirtyBit, value: false);
				}
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void GeneratedSyncVarSetter_NetworkIdentity(global::Mirror.NetworkIdentity value, ref global::Mirror.NetworkIdentity field, ulong dirtyBit, global::System.Action<global::Mirror.NetworkIdentity, global::Mirror.NetworkIdentity> OnChanged, ref uint netIdField)
		{
			if (!SyncVarNetworkIdentityEqual(value, netIdField))
			{
				global::Mirror.NetworkIdentity arg = field;
				SetSyncVarNetworkIdentity(value, ref field, dirtyBit, ref netIdField);
				if (OnChanged != null && global::Mirror.NetworkServer.activeHost && !GetSyncVarHookGuard(dirtyBit))
				{
					SetSyncVarHookGuard(dirtyBit, value: true);
					OnChanged(arg, value);
					SetSyncVarHookGuard(dirtyBit, value: false);
				}
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void GeneratedSyncVarSetter_NetworkBehaviour<T>(T value, ref T field, ulong dirtyBit, global::System.Action<T, T> OnChanged, ref global::Mirror.NetworkBehaviourSyncVar netIdField) where T : global::Mirror.NetworkBehaviour
		{
			if (!SyncVarNetworkBehaviourEqual(value, netIdField))
			{
				T arg = field;
				SetSyncVarNetworkBehaviour(value, ref field, dirtyBit, ref netIdField);
				if (OnChanged != null && global::Mirror.NetworkServer.activeHost && !GetSyncVarHookGuard(dirtyBit))
				{
					SetSyncVarHookGuard(dirtyBit, value: true);
					OnChanged(arg, value);
					SetSyncVarHookGuard(dirtyBit, value: false);
				}
			}
		}

		[global::System.ComponentModel.EditorBrowsable(global::System.ComponentModel.EditorBrowsableState.Never)]
		public static bool SyncVarGameObjectEqual(global::UnityEngine.GameObject newGameObject, uint netIdField)
		{
			uint num = 0u;
			if (newGameObject != null && newGameObject.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				num = component.netId;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning($"SetSyncVarGameObject GameObject {newGameObject} has a zero netId. Maybe it is not spawned yet?");
				}
			}
			return num == netIdField;
		}

		protected void SetSyncVarGameObject(global::UnityEngine.GameObject newGameObject, ref global::UnityEngine.GameObject gameObjectField, ulong dirtyBit, ref uint netIdField)
		{
			if (GetSyncVarHookGuard(dirtyBit))
			{
				return;
			}
			uint num = 0u;
			if (newGameObject != null && newGameObject.TryGetComponent<global::Mirror.NetworkIdentity>(out var component))
			{
				num = component.netId;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning($"SetSyncVarGameObject GameObject {newGameObject} has a zero netId. Maybe it is not spawned yet?");
				}
			}
			SetSyncVarDirtyBit(dirtyBit);
			gameObjectField = newGameObject;
			netIdField = num;
		}

		protected global::UnityEngine.GameObject GetSyncVarGameObject(uint netId, ref global::UnityEngine.GameObject gameObjectField)
		{
			if (isServer || !isClient)
			{
				return gameObjectField;
			}
			if (global::Mirror.NetworkClient.spawned.TryGetValue(netId, out var value) && value != null)
			{
				return gameObjectField = value.gameObject;
			}
			return null;
		}

		[global::System.ComponentModel.EditorBrowsable(global::System.ComponentModel.EditorBrowsableState.Never)]
		public static bool SyncVarNetworkIdentityEqual(global::Mirror.NetworkIdentity newIdentity, uint netIdField)
		{
			uint num = 0u;
			if (newIdentity != null)
			{
				num = newIdentity.netId;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning($"SetSyncVarNetworkIdentity NetworkIdentity {newIdentity} has a zero netId. Maybe it is not spawned yet?");
				}
			}
			return num == netIdField;
		}

		public void GeneratedSyncVarDeserialize<T>(ref T field, global::System.Action<T, T> OnChanged, T value)
		{
			T val = field;
			field = value;
			if (OnChanged != null && !SyncVarEqual(val, ref field))
			{
				OnChanged(val, field);
			}
		}

		public void GeneratedSyncVarDeserialize_GameObject(ref global::UnityEngine.GameObject field, global::System.Action<global::UnityEngine.GameObject, global::UnityEngine.GameObject> OnChanged, global::Mirror.NetworkReader reader, ref uint netIdField)
		{
			uint value = netIdField;
			global::UnityEngine.GameObject arg = field;
			netIdField = reader.ReadUInt();
			field = GetSyncVarGameObject(netIdField, ref field);
			if (OnChanged != null && !SyncVarEqual(value, ref netIdField))
			{
				OnChanged(arg, field);
			}
		}

		public void GeneratedSyncVarDeserialize_NetworkIdentity(ref global::Mirror.NetworkIdentity field, global::System.Action<global::Mirror.NetworkIdentity, global::Mirror.NetworkIdentity> OnChanged, global::Mirror.NetworkReader reader, ref uint netIdField)
		{
			uint value = netIdField;
			global::Mirror.NetworkIdentity arg = field;
			netIdField = reader.ReadUInt();
			field = GetSyncVarNetworkIdentity(netIdField, ref field);
			if (OnChanged != null && !SyncVarEqual(value, ref netIdField))
			{
				OnChanged(arg, field);
			}
		}

		public void GeneratedSyncVarDeserialize_NetworkBehaviour<T>(ref T field, global::System.Action<T, T> OnChanged, global::Mirror.NetworkReader reader, ref global::Mirror.NetworkBehaviourSyncVar netIdField) where T : global::Mirror.NetworkBehaviour
		{
			global::Mirror.NetworkBehaviourSyncVar value = netIdField;
			T arg = field;
			netIdField = reader.ReadNetworkBehaviourSyncVar();
			field = GetSyncVarNetworkBehaviour(netIdField, ref field);
			if (OnChanged != null && !SyncVarEqual(value, ref netIdField))
			{
				OnChanged(arg, field);
			}
		}

		protected void SetSyncVarNetworkIdentity(global::Mirror.NetworkIdentity newIdentity, ref global::Mirror.NetworkIdentity identityField, ulong dirtyBit, ref uint netIdField)
		{
			if (GetSyncVarHookGuard(dirtyBit))
			{
				return;
			}
			uint num = 0u;
			if (newIdentity != null)
			{
				num = newIdentity.netId;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning($"SetSyncVarNetworkIdentity NetworkIdentity {newIdentity} has a zero netId. Maybe it is not spawned yet?");
				}
			}
			SetSyncVarDirtyBit(dirtyBit);
			netIdField = num;
			identityField = newIdentity;
		}

		protected global::Mirror.NetworkIdentity GetSyncVarNetworkIdentity(uint netId, ref global::Mirror.NetworkIdentity identityField)
		{
			if (isServer || !isClient)
			{
				return identityField;
			}
			global::Mirror.NetworkClient.spawned.TryGetValue(netId, out identityField);
			return identityField;
		}

		protected static bool SyncVarNetworkBehaviourEqual<T>(T newBehaviour, global::Mirror.NetworkBehaviourSyncVar syncField) where T : global::Mirror.NetworkBehaviour
		{
			uint num = 0u;
			byte componentIndex = 0;
			if (newBehaviour != null)
			{
				num = newBehaviour.netId;
				componentIndex = newBehaviour.ComponentIndex;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning($"SetSyncVarNetworkIdentity NetworkIdentity {newBehaviour} has a zero netId. Maybe it is not spawned yet?");
				}
			}
			return syncField.Equals(num, componentIndex);
		}

		protected void SetSyncVarNetworkBehaviour<T>(T newBehaviour, ref T behaviourField, ulong dirtyBit, ref global::Mirror.NetworkBehaviourSyncVar syncField) where T : global::Mirror.NetworkBehaviour
		{
			if (GetSyncVarHookGuard(dirtyBit))
			{
				return;
			}
			uint num = 0u;
			byte componentIndex = 0;
			if (newBehaviour != null)
			{
				num = newBehaviour.netId;
				componentIndex = newBehaviour.ComponentIndex;
				if (num == 0)
				{
					global::UnityEngine.Debug.LogWarning(string.Format("{0} NetworkIdentity {1} has a zero netId. Maybe it is not spawned yet?", "SetSyncVarNetworkBehaviour", newBehaviour));
				}
			}
			syncField = new global::Mirror.NetworkBehaviourSyncVar(num, componentIndex);
			SetSyncVarDirtyBit(dirtyBit);
			behaviourField = newBehaviour;
		}

		protected T GetSyncVarNetworkBehaviour<T>(global::Mirror.NetworkBehaviourSyncVar syncNetBehaviour, ref T behaviourField) where T : global::Mirror.NetworkBehaviour
		{
			if (isServer || !isClient)
			{
				return behaviourField;
			}
			if (!global::Mirror.NetworkClient.spawned.TryGetValue(syncNetBehaviour.netId, out var value))
			{
				return null;
			}
			behaviourField = value.NetworkBehaviours[syncNetBehaviour.componentIndex] as T;
			return behaviourField;
		}

		protected static bool SyncVarEqual<T>(T value, ref T fieldValue)
		{
			return global::System.Collections.Generic.EqualityComparer<T>.Default.Equals(value, fieldValue);
		}

		protected void SetSyncVar<T>(T value, ref T fieldValue, ulong dirtyBit)
		{
			SetSyncVarDirtyBit(dirtyBit);
			fieldValue = value;
		}

		public virtual void OnSerialize(global::Mirror.NetworkWriter writer, bool initialState)
		{
			SerializeSyncObjects(writer, initialState);
			SerializeSyncVars(writer, initialState);
		}

		public virtual void OnDeserialize(global::Mirror.NetworkReader reader, bool initialState)
		{
			DeserializeSyncObjects(reader, initialState);
			DeserializeSyncVars(reader, initialState);
		}

		private void SerializeSyncObjects(global::Mirror.NetworkWriter writer, bool initialState)
		{
			if (initialState)
			{
				SerializeObjectsAll(writer);
			}
			else
			{
				SerializeObjectsDelta(writer);
			}
		}

		private void DeserializeSyncObjects(global::Mirror.NetworkReader reader, bool initialState)
		{
			if (initialState)
			{
				DeserializeObjectsAll(reader);
			}
			else
			{
				DeserializeObjectsDelta(reader);
			}
		}

		protected virtual void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool initialState)
		{
		}

		protected virtual void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
		}

		public void SerializeObjectsAll(global::Mirror.NetworkWriter writer)
		{
			for (int i = 0; i < syncObjects.Count; i++)
			{
				syncObjects[i].OnSerializeAll(writer);
			}
		}

		public void SerializeObjectsDelta(global::Mirror.NetworkWriter writer)
		{
			writer.WriteULong(syncObjectDirtyBits);
			for (int i = 0; i < syncObjects.Count; i++)
			{
				global::Mirror.SyncObject syncObject = syncObjects[i];
				if ((syncObjectDirtyBits & (ulong)(1L << i)) != 0L)
				{
					syncObject.OnSerializeDelta(writer);
				}
			}
		}

		internal void DeserializeObjectsAll(global::Mirror.NetworkReader reader)
		{
			for (int i = 0; i < syncObjects.Count; i++)
			{
				syncObjects[i].OnDeserializeAll(reader);
			}
		}

		internal void DeserializeObjectsDelta(global::Mirror.NetworkReader reader)
		{
			ulong num = reader.ReadULong();
			for (int i = 0; i < syncObjects.Count; i++)
			{
				global::Mirror.SyncObject syncObject = syncObjects[i];
				if ((num & (ulong)(1L << i)) != 0L)
				{
					syncObject.OnDeserializeDelta(reader);
				}
			}
		}

		internal void Serialize(global::Mirror.NetworkWriter writer, bool initialState)
		{
			int position = writer.Position;
			writer.WriteByte(0);
			int position2 = writer.Position;
			try
			{
				OnSerialize(writer, initialState);
			}
			catch (global::System.Exception ex)
			{
				global::UnityEngine.Debug.LogError($"OnSerialize failed for: object={base.name} component={GetType()} sceneId={netIdentity.sceneId:X}\n\n{ex}");
			}
			int position3 = writer.Position;
			writer.Position = position;
			byte value = (byte)((position3 - position2) & 0xFF);
			writer.WriteByte(value);
			writer.Position = position3;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal static int ErrorCorrection(int size, byte safety)
		{
			return (size & -256) | safety;
		}

		internal bool Deserialize(global::Mirror.NetworkReader reader, bool initialState)
		{
			bool result = true;
			byte b = reader.ReadByte();
			int position = reader.Position;
			try
			{
				OnDeserialize(reader, initialState);
			}
			catch (global::System.Exception ex)
			{
				global::UnityEngine.Debug.LogError($"OnDeserialize failed Exception={ex.GetType()} (see below) object={base.name} component={GetType()} netId={netId}. Possible Reasons:\n" + $"  * Do {GetType()}'s OnSerialize and OnDeserialize calls write the same amount of data? \n" + $"  * Was there an exception in {GetType()}'s OnSerialize/OnDeserialize code?\n" + "  * Are the server and client the exact same project?\n  * Maybe this OnDeserialize call was meant for another GameObject? The sceneIds can easily get out of sync if the Hierarchy was modified only in the client OR the server. Try rebuilding both.\n\n" + $"Exception {ex}");
				result = false;
			}
			int num = reader.Position - position;
			byte b2 = (byte)(num & 0xFF);
			if (b2 != b)
			{
				global::UnityEngine.Debug.LogWarning($"{base.name} (netId={netId}): {GetType()} OnDeserialize size mismatch. It read {num} bytes, which caused a size hash mismatch of {b2:X2} vs. {b:X2}. Make sure that OnSerialize and OnDeserialize write/read the same amount of data in all cases.");
				int num2 = ErrorCorrection(num, b);
				reader.Position = position + num2;
				result = false;
			}
			return result;
		}

		internal void ResetSyncObjects()
		{
			foreach (global::Mirror.SyncObject syncObject in syncObjects)
			{
				syncObject.Reset();
			}
		}

		public virtual void OnStartServer()
		{
		}

		public virtual void OnStopServer()
		{
		}

		public virtual void OnStartClient()
		{
		}

		public virtual void OnStopClient()
		{
		}

		public virtual void OnStartLocalPlayer()
		{
		}

		public virtual void OnStopLocalPlayer()
		{
		}

		public virtual void OnStartAuthority()
		{
		}

		public virtual void OnStopAuthority()
		{
		}

		[global::System.ComponentModel.EditorBrowsable(global::System.ComponentModel.EditorBrowsableState.Never)]
		public virtual bool Weaved()
		{
			return false;
		}
	}
}
