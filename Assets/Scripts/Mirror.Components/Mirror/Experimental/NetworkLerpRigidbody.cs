namespace Mirror.Experimental
{
	[global::UnityEngine.AddComponentMenu("Network/ Experimental/Network Lerp Rigidbody")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-lerp-rigidbody")]
	[global::System.Obsolete("Use the new NetworkRigidbodyReliable/Unreliable component with Snapshot Interpolation instead.")]
	public class NetworkLerpRigidbody : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Header("Settings")]
		[global::UnityEngine.SerializeField]
		internal global::UnityEngine.Rigidbody target;

		[global::UnityEngine.Tooltip("How quickly current velocity approaches target velocity")]
		[global::UnityEngine.SerializeField]
		private float lerpVelocityAmount = 0.5f;

		[global::UnityEngine.Tooltip("How quickly current position approaches target position")]
		[global::UnityEngine.SerializeField]
		private float lerpPositionAmount = 0.5f;

		[global::UnityEngine.Tooltip("Set to true if moves come from owner client, set to false if moves always come from server")]
		[global::UnityEngine.SerializeField]
		private bool clientAuthority;

		private double nextSyncTime;

		[global::Mirror.SyncVar]
		private global::UnityEngine.Vector3 targetVelocity;

		[global::Mirror.SyncVar]
		private global::UnityEngine.Vector3 targetPosition;

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

		public global::UnityEngine.Vector3 NetworktargetVelocity
		{
			get
			{
				return targetVelocity;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref targetVelocity, 1uL, null);
			}
		}

		public global::UnityEngine.Vector3 NetworktargetPosition
		{
			get
			{
				return targetPosition;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref targetPosition, 2uL, null);
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

		private void Update()
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

		private void SyncToClients()
		{
			NetworktargetVelocity = target.velocity;
			NetworktargetPosition = target.position;
		}

		private void SendToServer()
		{
			double localTime = global::Mirror.NetworkTime.localTime;
			if (localTime > nextSyncTime)
			{
				nextSyncTime = localTime + (double)syncInterval;
				CmdSendState(target.velocity, target.position);
			}
		}

		[global::Mirror.Command]
		private void CmdSendState(global::UnityEngine.Vector3 velocity, global::UnityEngine.Vector3 position)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(velocity);
			writer.WriteVector3(position);
			SendCommandInternal("System.Void Mirror.Experimental.NetworkLerpRigidbody::CmdSendState(UnityEngine.Vector3,UnityEngine.Vector3)", 222547705, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		private void FixedUpdate()
		{
			if (!IgnoreSync)
			{
				target.velocity = global::UnityEngine.Vector3.Lerp(target.velocity, targetVelocity, lerpVelocityAmount);
				target.position = global::UnityEngine.Vector3.Lerp(target.position, targetPosition, lerpPositionAmount);
				target.position += target.velocity * global::UnityEngine.Time.fixedDeltaTime;
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdSendState__Vector3__Vector3(global::UnityEngine.Vector3 velocity, global::UnityEngine.Vector3 position)
		{
			target.velocity = velocity;
			target.position = position;
			NetworktargetVelocity = velocity;
			NetworktargetPosition = position;
		}

		protected static void InvokeUserCode_CmdSendState__Vector3__Vector3(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSendState called on client.");
			}
			else
			{
				((global::Mirror.Experimental.NetworkLerpRigidbody)obj).UserCode_CmdSendState__Vector3__Vector3(reader.ReadVector3(), reader.ReadVector3());
			}
		}

		static NetworkLerpRigidbody()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.Experimental.NetworkLerpRigidbody), "System.Void Mirror.Experimental.NetworkLerpRigidbody::CmdSendState(UnityEngine.Vector3,UnityEngine.Vector3)", InvokeUserCode_CmdSendState__Vector3__Vector3, requiresAuthority: true);
		}

		protected override void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteVector3(targetVelocity);
				writer.WriteVector3(targetPosition);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteVector3(targetVelocity);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteVector3(targetPosition);
			}
		}

		protected override void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref targetVelocity, null, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref targetPosition, null, reader.ReadVector3());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref targetVelocity, null, reader.ReadVector3());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref targetPosition, null, reader.ReadVector3());
			}
		}
	}
}
