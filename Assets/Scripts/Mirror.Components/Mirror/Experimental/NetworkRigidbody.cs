namespace Mirror.Experimental
{
	[global::UnityEngine.AddComponentMenu("Network/ Experimental/Network Rigidbody")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-rigidbody")]
	[global::System.Obsolete("Use the new NetworkRigidbodyReliable/Unreliable component with Snapshot Interpolation instead.")]
	public class NetworkRigidbody : global::Mirror.NetworkBehaviour
	{
		public class ClientSyncState
		{
			public double nextSyncTime;

			public global::UnityEngine.Vector3 velocity;

			public global::UnityEngine.Vector3 angularVelocity;

			public bool isKinematic;

			public bool useGravity;

			public float drag;

			public float angularDrag;
		}

		[global::UnityEngine.Header("Settings")]
		[global::UnityEngine.SerializeField]
		internal global::UnityEngine.Rigidbody target;

		[global::UnityEngine.Tooltip("Set to true if moves come from owner client, set to false if moves always come from server")]
		public bool clientAuthority;

		[global::UnityEngine.Header("Velocity")]
		[global::UnityEngine.Tooltip("Syncs Velocity every SyncInterval")]
		[global::UnityEngine.SerializeField]
		private bool syncVelocity = true;

		[global::UnityEngine.Tooltip("Set velocity to 0 each frame (only works if syncVelocity is false")]
		[global::UnityEngine.SerializeField]
		private bool clearVelocity;

		[global::UnityEngine.Tooltip("Only Syncs Value if distance between previous and current is great than sensitivity")]
		[global::UnityEngine.SerializeField]
		private float velocitySensitivity = 0.1f;

		[global::UnityEngine.Header("Angular Velocity")]
		[global::UnityEngine.Tooltip("Syncs AngularVelocity every SyncInterval")]
		[global::UnityEngine.SerializeField]
		private bool syncAngularVelocity = true;

		[global::UnityEngine.Tooltip("Set angularVelocity to 0 each frame (only works if syncAngularVelocity is false")]
		[global::UnityEngine.SerializeField]
		private bool clearAngularVelocity;

		[global::UnityEngine.Tooltip("Only Syncs Value if distance between previous and current is great than sensitivity")]
		[global::UnityEngine.SerializeField]
		private float angularVelocitySensitivity = 0.1f;

		private readonly global::Mirror.Experimental.NetworkRigidbody.ClientSyncState previousValue = new global::Mirror.Experimental.NetworkRigidbody.ClientSyncState();

		[global::Mirror.SyncVar(hook = "OnVelocityChanged")]
		private global::UnityEngine.Vector3 velocity;

		[global::Mirror.SyncVar(hook = "OnAngularVelocityChanged")]
		private global::UnityEngine.Vector3 angularVelocity;

		[global::Mirror.SyncVar(hook = "OnIsKinematicChanged")]
		private bool isKinematic;

		[global::Mirror.SyncVar(hook = "OnUseGravityChanged")]
		private bool useGravity;

		[global::Mirror.SyncVar(hook = "OnuDragChanged")]
		private float drag;

		[global::Mirror.SyncVar(hook = "OnAngularDragChanged")]
		private float angularDrag;

		private bool IgnoreSync
		{
			get
			{
				if (!base.isServer)
				{
					return ClientWithAuthority;
				}
				return true;
			}
		}

		private bool ClientWithAuthority
		{
			get
			{
				if (clientAuthority)
				{
					return base.isOwned;
				}
				return false;
			}
		}

		public global::UnityEngine.Vector3 Networkvelocity
		{
			get
			{
				return velocity;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref velocity, 1uL, OnVelocityChanged);
			}
		}

		public global::UnityEngine.Vector3 NetworkangularVelocity
		{
			get
			{
				return angularVelocity;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref angularVelocity, 2uL, OnAngularVelocityChanged);
			}
		}

		public bool NetworkisKinematic
		{
			get
			{
				return isKinematic;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref isKinematic, 4uL, OnIsKinematicChanged);
			}
		}

		public bool NetworkuseGravity
		{
			get
			{
				return useGravity;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref useGravity, 8uL, OnUseGravityChanged);
			}
		}

		public float Networkdrag
		{
			get
			{
				return drag;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref drag, 16uL, OnuDragChanged);
			}
		}

		public float NetworkangularDrag
		{
			get
			{
				return angularDrag;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref angularDrag, 32uL, OnAngularDragChanged);
			}
		}

		protected override void OnValidate()
		{
			base.OnValidate();
			if (target == null)
			{
				target = GetComponent<global::UnityEngine.Rigidbody>();
			}
		}

		private void OnVelocityChanged(global::UnityEngine.Vector3 _, global::UnityEngine.Vector3 newValue)
		{
			if (!IgnoreSync)
			{
				target.velocity = newValue;
			}
		}

		private void OnAngularVelocityChanged(global::UnityEngine.Vector3 _, global::UnityEngine.Vector3 newValue)
		{
			if (!IgnoreSync)
			{
				target.angularVelocity = newValue;
			}
		}

		private void OnIsKinematicChanged(bool _, bool newValue)
		{
			if (!IgnoreSync)
			{
				target.isKinematic = newValue;
			}
		}

		private void OnUseGravityChanged(bool _, bool newValue)
		{
			if (!IgnoreSync)
			{
				target.useGravity = newValue;
			}
		}

		private void OnuDragChanged(float _, float newValue)
		{
			if (!IgnoreSync)
			{
				target.drag = newValue;
			}
		}

		private void OnAngularDragChanged(float _, float newValue)
		{
			if (!IgnoreSync)
			{
				target.angularDrag = newValue;
			}
		}

		internal void Update()
		{
			if (base.isServer)
			{
				SyncToClients();
			}
			else if (ClientWithAuthority)
			{
				SendToServer();
			}
		}

		internal void FixedUpdate()
		{
			if (clearAngularVelocity && !syncAngularVelocity)
			{
				target.angularVelocity = global::UnityEngine.Vector3.zero;
			}
			if (clearVelocity && !syncVelocity)
			{
				target.velocity = global::UnityEngine.Vector3.zero;
			}
		}

		[global::Mirror.Server]
		private void SyncToClients()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogWarning("[Server] function 'System.Void Mirror.Experimental.NetworkRigidbody::SyncToClients()' called when server was not active");
				return;
			}
			global::UnityEngine.Vector3 vector = (syncVelocity ? target.velocity : default(global::UnityEngine.Vector3));
			global::UnityEngine.Vector3 vector2 = (syncAngularVelocity ? target.angularVelocity : default(global::UnityEngine.Vector3));
			bool num = syncVelocity && (previousValue.velocity - vector).sqrMagnitude > velocitySensitivity * velocitySensitivity;
			bool flag = syncAngularVelocity && (previousValue.angularVelocity - vector2).sqrMagnitude > angularVelocitySensitivity * angularVelocitySensitivity;
			if (num)
			{
				Networkvelocity = vector;
				previousValue.velocity = vector;
			}
			if (flag)
			{
				NetworkangularVelocity = vector2;
				previousValue.angularVelocity = vector2;
			}
			NetworkisKinematic = target.isKinematic;
			NetworkuseGravity = target.useGravity;
			Networkdrag = target.drag;
			NetworkangularDrag = target.angularDrag;
		}

		[global::Mirror.Client]
		private void SendToServer()
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("[Client] function 'System.Void Mirror.Experimental.NetworkRigidbody::SendToServer()' called when client was not active");
				return;
			}
			if (!base.isOwned)
			{
				global::UnityEngine.Debug.LogWarning("SendToServer called without authority");
				return;
			}
			SendVelocity();
			SendRigidBodySettings();
		}

		[global::Mirror.Client]
		private void SendVelocity()
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("[Client] function 'System.Void Mirror.Experimental.NetworkRigidbody::SendVelocity()' called when client was not active");
				return;
			}
			double localTime = global::Mirror.NetworkTime.localTime;
			if (localTime < previousValue.nextSyncTime)
			{
				return;
			}
			global::UnityEngine.Vector3 vector = (syncVelocity ? target.velocity : default(global::UnityEngine.Vector3));
			global::UnityEngine.Vector3 vector2 = (syncAngularVelocity ? target.angularVelocity : default(global::UnityEngine.Vector3));
			bool flag = syncVelocity && (previousValue.velocity - vector).sqrMagnitude > velocitySensitivity * velocitySensitivity;
			int num;
			if (syncAngularVelocity)
			{
				num = (((previousValue.angularVelocity - vector2).sqrMagnitude > angularVelocitySensitivity * angularVelocitySensitivity) ? 1 : 0);
				if (num != 0)
				{
					CmdSendVelocityAndAngular(vector, vector2);
					previousValue.velocity = vector;
					previousValue.angularVelocity = vector2;
					goto IL_010e;
				}
			}
			else
			{
				num = 0;
			}
			if (flag)
			{
				CmdSendVelocity(vector);
				previousValue.velocity = vector;
			}
			goto IL_010e;
			IL_010e:
			if (((uint)num | (flag ? 1u : 0u)) != 0)
			{
				previousValue.nextSyncTime = localTime + (double)syncInterval;
			}
		}

		[global::Mirror.Client]
		private void SendRigidBodySettings()
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogWarning("[Client] function 'System.Void Mirror.Experimental.NetworkRigidbody::SendRigidBodySettings()' called when client was not active");
				return;
			}
			if (previousValue.isKinematic != target.isKinematic)
			{
				CmdSendIsKinematic(target.isKinematic);
				previousValue.isKinematic = target.isKinematic;
			}
			if (previousValue.useGravity != target.useGravity)
			{
				CmdSendUseGravity(target.useGravity);
				previousValue.useGravity = target.useGravity;
			}
			if (previousValue.drag != target.drag)
			{
				CmdSendDrag(target.drag);
				previousValue.drag = target.drag;
			}
			if (previousValue.angularDrag != target.angularDrag)
			{
				CmdSendAngularDrag(target.angularDrag);
				previousValue.angularDrag = target.angularDrag;
			}
		}

		[global::Mirror.Command]
		private void CmdSendVelocity(global::UnityEngine.Vector3 velocity)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(velocity);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendVelocity(UnityEngine.Vector3)", 778299891, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSendVelocityAndAngular(global::UnityEngine.Vector3 velocity, global::UnityEngine.Vector3 angularVelocity)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(velocity);
			writer.WriteVector3(angularVelocity);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendVelocityAndAngular(UnityEngine.Vector3,UnityEngine.Vector3)", 600596091, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSendIsKinematic(bool isKinematic)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteBool(isKinematic);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendIsKinematic(System.Boolean)", -594703317, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSendUseGravity(bool useGravity)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteBool(useGravity);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendUseGravity(System.Boolean)", -1841377529, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSendDrag(float drag)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteFloat(drag);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendDrag(System.Single)", -1542731250, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSendAngularDrag(float angularDrag)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteFloat(angularDrag);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkRigidbody::CmdSendAngularDrag(System.Single)", -1552888100, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdSendVelocity__Vector3(global::UnityEngine.Vector3 velocity)
		{
			if (clientAuthority)
			{
				Networkvelocity = velocity;
				target.velocity = velocity;
			}
		}

		protected static void InvokeUserCode_CmdSendVelocity__Vector3(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendVelocity called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendVelocity__Vector3(reader.ReadVector3());
			}
		}

		protected void UserCode_CmdSendVelocityAndAngular__Vector3__Vector3(global::UnityEngine.Vector3 velocity, global::UnityEngine.Vector3 angularVelocity)
		{
			if (clientAuthority)
			{
				if (syncVelocity)
				{
					Networkvelocity = velocity;
					target.velocity = velocity;
				}
				NetworkangularVelocity = angularVelocity;
				target.angularVelocity = angularVelocity;
			}
		}

		protected static void InvokeUserCode_CmdSendVelocityAndAngular__Vector3__Vector3(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendVelocityAndAngular called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendVelocityAndAngular__Vector3__Vector3(reader.ReadVector3(), reader.ReadVector3());
			}
		}

		protected void UserCode_CmdSendIsKinematic__Boolean(bool isKinematic)
		{
			if (clientAuthority)
			{
				NetworkisKinematic = isKinematic;
				target.isKinematic = isKinematic;
			}
		}

		protected static void InvokeUserCode_CmdSendIsKinematic__Boolean(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendIsKinematic called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendIsKinematic__Boolean(reader.ReadBool());
			}
		}

		protected void UserCode_CmdSendUseGravity__Boolean(bool useGravity)
		{
			if (clientAuthority)
			{
				NetworkuseGravity = useGravity;
				target.useGravity = useGravity;
			}
		}

		protected static void InvokeUserCode_CmdSendUseGravity__Boolean(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendUseGravity called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendUseGravity__Boolean(reader.ReadBool());
			}
		}

		protected void UserCode_CmdSendDrag__Single(float drag)
		{
			if (clientAuthority)
			{
				Networkdrag = drag;
				target.drag = drag;
			}
		}

		protected static void InvokeUserCode_CmdSendDrag__Single(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendDrag called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendDrag__Single(reader.ReadFloat());
			}
		}

		protected void UserCode_CmdSendAngularDrag__Single(float angularDrag)
		{
			if (clientAuthority)
			{
				NetworkangularDrag = angularDrag;
				target.angularDrag = angularDrag;
			}
		}

		protected static void InvokeUserCode_CmdSendAngularDrag__Single(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendAngularDrag called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkRigidbody)obj).UserCode_CmdSendAngularDrag__Single(reader.ReadFloat());
			}
		}

		static NetworkRigidbody()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendVelocity(UnityEngine.Vector3)", InvokeUserCode_CmdSendVelocity__Vector3, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendVelocityAndAngular(UnityEngine.Vector3,UnityEngine.Vector3)", InvokeUserCode_CmdSendVelocityAndAngular__Vector3__Vector3, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendIsKinematic(System.Boolean)", InvokeUserCode_CmdSendIsKinematic__Boolean, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendUseGravity(System.Boolean)", InvokeUserCode_CmdSendUseGravity__Boolean, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendDrag(System.Single)", InvokeUserCode_CmdSendDrag__Single, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkRigidbody), "System.Void Mirror.Experimental.NetworkRigidbody::CmdSendAngularDrag(System.Single)", InvokeUserCode_CmdSendAngularDrag__Single, requiresAuthority: true);
		}

		protected override void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteVector3(velocity);
				writer.WriteVector3(angularVelocity);
				writer.WriteBool(isKinematic);
				writer.WriteBool(useGravity);
				writer.WriteFloat(drag);
				writer.WriteFloat(angularDrag);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteVector3(velocity);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteVector3(angularVelocity);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteBool(isKinematic);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteBool(useGravity);
			}
			if ((base.syncVarDirtyBits & 0x10L) != 0L)
			{
				writer.WriteFloat(drag);
			}
			if ((base.syncVarDirtyBits & 0x20L) != 0L)
			{
				writer.WriteFloat(angularDrag);
			}
		}

		protected override void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref velocity, OnVelocityChanged, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref angularVelocity, OnAngularVelocityChanged, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref isKinematic, OnIsKinematicChanged, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref useGravity, OnUseGravityChanged, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref drag, OnuDragChanged, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref angularDrag, OnAngularDragChanged, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref velocity, OnVelocityChanged, reader.ReadVector3());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref angularVelocity, OnAngularVelocityChanged, reader.ReadVector3());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref isKinematic, OnIsKinematicChanged, reader.ReadBool());
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref useGravity, OnUseGravityChanged, reader.ReadBool());
			}
			if ((num & 0x10L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref drag, OnuDragChanged, reader.ReadFloat());
			}
			if ((num & 0x20L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref angularDrag, OnAngularDragChanged, reader.ReadFloat());
			}
		}
	}
}
