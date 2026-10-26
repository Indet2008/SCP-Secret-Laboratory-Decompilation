namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/Network Room Player")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-room-player")]
	public class NetworkRoomPlayer : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Tooltip("This flag controls whether the default UI is shown for the room player")]
		public bool showRoomGUI = true;

		[global::UnityEngine.Header("Diagnostics")]
		[global::UnityEngine.Tooltip("Diagnostic flag indicating whether this player is ready for the game to begin")]
		[global::Mirror.SyncVar(hook = "ReadyStateChanged")]
		public bool readyToBegin;

		[global::UnityEngine.Tooltip("Diagnostic index of the player, e.g. Player1, Player2, etc.")]
		[global::Mirror.SyncVar(hook = "IndexChanged")]
		public int index;

		public bool NetworkreadyToBegin
		{
			get
			{
				return readyToBegin;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref readyToBegin, 1uL, ReadyStateChanged);
			}
		}

		public int Networkindex
		{
			get
			{
				return index;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref index, 2uL, IndexChanged);
			}
		}

		public virtual void Start()
		{
			if (global::Mirror.NetworkManager.singleton is global::Mirror.NetworkRoomManager networkRoomManager)
			{
				if (networkRoomManager.dontDestroyOnLoad)
				{
					global::UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
				}
				networkRoomManager.roomSlots.Add(this);
				if (global::Mirror.NetworkServer.active)
				{
					networkRoomManager.RecalculateRoomPlayerIndices();
				}
				if (global::Mirror.NetworkClient.active)
				{
					networkRoomManager.CallOnClientEnterRoom();
				}
			}
			else
			{
				global::UnityEngine.Debug.LogError("RoomPlayer could not find a NetworkRoomManager. The RoomPlayer requires a NetworkRoomManager object to function. Make sure that there is one in the scene.");
			}
		}

		public virtual void OnDisable()
		{
			if (global::Mirror.NetworkClient.active && global::Mirror.NetworkManager.singleton is global::Mirror.NetworkRoomManager networkRoomManager)
			{
				networkRoomManager.roomSlots.Remove(this);
				networkRoomManager.CallOnClientExitRoom();
			}
		}

		[global::Mirror.Command]
		public void CmdChangeReadyState(bool readyState)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteBool(readyState);
			SendCommandInternal("System.Void Mirror.NetworkRoomPlayer::CmdChangeReadyState(System.Boolean)", -485050255, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		public virtual void IndexChanged(int oldIndex, int newIndex)
		{
		}

		public virtual void ReadyStateChanged(bool oldReadyState, bool newReadyState)
		{
		}

		public virtual void OnClientEnterRoom()
		{
		}

		public virtual void OnClientExitRoom()
		{
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdChangeReadyState__Boolean(bool readyState)
		{
			NetworkreadyToBegin = readyState;
			global::Mirror.NetworkRoomManager networkRoomManager = global::Mirror.NetworkManager.singleton as global::Mirror.NetworkRoomManager;
			if (networkRoomManager != null)
			{
				networkRoomManager.ReadyStatusChanged();
			}
		}

		protected static void InvokeUserCode_CmdChangeReadyState__Boolean(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdChangeReadyState called on client.");
			}
			else
			{
				((global::Mirror.NetworkRoomPlayer)obj).UserCode_CmdChangeReadyState__Boolean(reader.ReadBool());
			}
		}

		static NetworkRoomPlayer()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkRoomPlayer), "System.Void Mirror.NetworkRoomPlayer::CmdChangeReadyState(System.Boolean)", InvokeUserCode_CmdChangeReadyState__Boolean, requiresAuthority: true);
		}

		protected override void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(readyToBegin);
				writer.WriteInt(index);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteBool(readyToBegin);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteInt(index);
			}
		}

		protected override void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref readyToBegin, ReadyStateChanged, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref index, IndexChanged, reader.ReadInt());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref readyToBegin, ReadyStateChanged, reader.ReadBool());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref index, IndexChanged, reader.ReadInt());
			}
		}
	}
}
