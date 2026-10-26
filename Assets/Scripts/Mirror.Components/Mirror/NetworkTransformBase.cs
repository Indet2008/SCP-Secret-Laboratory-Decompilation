namespace Mirror
{
	public abstract class NetworkTransformBase : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Header("Target")]
		[global::UnityEngine.Tooltip("The Transform component to sync. May be on on this GameObject, or on a child.")]
		public global::UnityEngine.Transform target;

		[global::System.Obsolete("NetworkTransform clientAuthority was replaced with syncDirection. To enable client authority, set SyncDirection to ClientToServer in the Inspector.")]
		[global::UnityEngine.Header("[Obsolete]")]
		[global::UnityEngine.Tooltip("Obsolete: NetworkTransform clientAuthority was replaced with syncDirection. To enable client authority, set SyncDirection to ClientToServer in the Inspector.")]
		public bool clientAuthority;

		public readonly global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot> clientSnapshots = new global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot>(16);

		public readonly global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot> serverSnapshots = new global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot>(16);

		[global::UnityEngine.Header("Selective Sync\nDon't change these at Runtime")]
		public bool syncPosition = true;

		public bool syncRotation = true;

		public bool syncScale;

		[global::UnityEngine.Header("Interpolation")]
		[global::UnityEngine.Tooltip("Set to false to have a snap-like effect on position movement.")]
		public bool interpolatePosition = true;

		[global::UnityEngine.Tooltip("Set to false to have a snap-like effect on rotations.")]
		public bool interpolateRotation = true;

		[global::UnityEngine.Tooltip("Set to false to remove scale smoothing. Example use-case: Instant flipping of sprites that use -X and +X for direction.")]
		public bool interpolateScale = true;

		[global::UnityEngine.Header("Coordinate Space")]
		[global::UnityEngine.Tooltip("Local by default. World may be better when changing hierarchy, or non-NetworkTransforms root position/rotation/scale values.")]
		public global::Mirror.CoordinateSpace coordinateSpace;

		[global::UnityEngine.Header("Send Interval Multiplier")]
		[global::UnityEngine.Tooltip("Check/Sync every multiple of Network Manager send interval (= 1 / NM Send Rate), instead of every send interval.\n(30 NM send rate, and 3 interval, is a send every 0.1 seconds)\nA larger interval means less network sends, which has a variety of upsides. The drawbacks are delays and lower accuracy, you should find a nice balance between not sending too much, but the results looking good for your particular scenario.")]
		[global::UnityEngine.Range(1f, 120f)]
		public uint sendIntervalMultiplier = 1u;

		[global::UnityEngine.Header("Timeline Offset")]
		[global::UnityEngine.Tooltip("Add a small timeline offset to account for decoupled arrival of NetworkTime and NetworkTransform snapshots.\nfixes: https://github.com/MirrorNetworking/Mirror/issues/3427")]
		public bool timelineOffset;

		[global::UnityEngine.Header("Debug")]
		public bool showGizmos;

		public bool showOverlay;

		public global::UnityEngine.Color overlayColor = new global::UnityEngine.Color(0f, 0f, 0f, 0.5f);

		protected bool IsClientWithAuthority
		{
			get
			{
				if (base.isClient)
				{
					return base.authority;
				}
				return false;
			}
		}

		protected double timeStampAdjustment => global::Mirror.NetworkServer.sendInterval * (float)(sendIntervalMultiplier - 1);

		protected double offset => timelineOffset ? (global::Mirror.NetworkServer.sendInterval * (float)sendIntervalMultiplier) : 0f;

		protected virtual void Awake()
		{
		}

		protected override void OnValidate()
		{
			base.OnValidate();
			if (target == null)
			{
				target = base.transform;
			}
			syncInterval = 0f;
			if (coordinateSpace == global::Mirror.CoordinateSpace.World)
			{
				syncScale = false;
			}
			if (clientAuthority)
			{
				syncDirection = global::Mirror.SyncDirection.ClientToServer;
				global::UnityEngine.Debug.LogWarning(base.name + "'s NetworkTransform component has obsolete .clientAuthority enabled. Please disable it and set SyncDirection to ClientToServer instead.");
			}
		}

		protected virtual global::UnityEngine.Vector3 GetPosition()
		{
			if (coordinateSpace != global::Mirror.CoordinateSpace.Local)
			{
				return target.position;
			}
			return target.localPosition;
		}

		protected virtual global::UnityEngine.Quaternion GetRotation()
		{
			if (coordinateSpace != global::Mirror.CoordinateSpace.Local)
			{
				return target.rotation;
			}
			return target.localRotation;
		}

		protected virtual global::UnityEngine.Vector3 GetScale()
		{
			if (coordinateSpace != global::Mirror.CoordinateSpace.Local)
			{
				return target.lossyScale;
			}
			return target.localScale;
		}

		protected virtual void SetPosition(global::UnityEngine.Vector3 position)
		{
			if (coordinateSpace == global::Mirror.CoordinateSpace.Local)
			{
				target.localPosition = position;
			}
			else
			{
				target.position = position;
			}
		}

		protected virtual void SetRotation(global::UnityEngine.Quaternion rotation)
		{
			if (coordinateSpace == global::Mirror.CoordinateSpace.Local)
			{
				target.localRotation = rotation;
			}
			else
			{
				target.rotation = rotation;
			}
		}

		protected virtual void SetScale(global::UnityEngine.Vector3 scale)
		{
			if (coordinateSpace == global::Mirror.CoordinateSpace.Local)
			{
				target.localScale = scale;
			}
		}

		protected virtual global::Mirror.TransformSnapshot Construct()
		{
			return new global::Mirror.TransformSnapshot(global::Mirror.NetworkTime.localTime, 0.0, GetPosition(), GetRotation(), GetScale());
		}

		protected void AddSnapshot(global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot> snapshots, double timeStamp, global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			if (!position.HasValue)
			{
				position = ((snapshots.Count > 0) ? snapshots.Values[snapshots.Count - 1].position : GetPosition());
			}
			if (!rotation.HasValue)
			{
				rotation = ((snapshots.Count > 0) ? snapshots.Values[snapshots.Count - 1].rotation : GetRotation());
			}
			if (!scale.HasValue)
			{
				scale = ((snapshots.Count > 0) ? snapshots.Values[snapshots.Count - 1].scale : GetScale());
			}
			global::Mirror.SnapshotInterpolation.InsertIfNotExists(snapshots, global::Mirror.NetworkClient.snapshotSettings.bufferLimit, new global::Mirror.TransformSnapshot(timeStamp, global::Mirror.NetworkTime.localTime, position.Value, rotation.Value, scale.Value));
		}

		protected virtual void Apply(global::Mirror.TransformSnapshot interpolated, global::Mirror.TransformSnapshot endGoal)
		{
			if (syncPosition)
			{
				SetPosition(interpolatePosition ? interpolated.position : endGoal.position);
			}
			if (syncRotation)
			{
				SetRotation(interpolateRotation ? interpolated.rotation : endGoal.rotation);
			}
			if (syncScale)
			{
				SetScale(interpolateScale ? interpolated.scale : endGoal.scale);
			}
		}

		[global::Mirror.Command]
		public void CmdTeleport(global::UnityEngine.Vector3 destination)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(destination);
			SendCommandInternal("System.Void Mirror.NetworkTransformBase::CmdTeleport(UnityEngine.Vector3)", -788685907, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		public void CmdTeleport(global::UnityEngine.Vector3 destination, global::UnityEngine.Quaternion rotation)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(destination);
			writer.WriteQuaternion(rotation);
			SendCommandInternal("System.Void Mirror.NetworkTransformBase::CmdTeleport(UnityEngine.Vector3,UnityEngine.Quaternion)", -840469116, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		public void RpcTeleport(global::UnityEngine.Vector3 destination)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(destination);
			SendRPCInternal("System.Void Mirror.NetworkTransformBase::RpcTeleport(UnityEngine.Vector3)", 165611234, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		public void RpcTeleport(global::UnityEngine.Vector3 destination, global::UnityEngine.Quaternion rotation)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3(destination);
			writer.WriteQuaternion(rotation);
			SendRPCInternal("System.Void Mirror.NetworkTransformBase::RpcTeleport(UnityEngine.Vector3,UnityEngine.Quaternion)", -84918609, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		private void RpcReset()
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			SendRPCInternal("System.Void Mirror.NetworkTransformBase::RpcReset()", 165401669, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		protected virtual void OnTeleport(global::UnityEngine.Vector3 destination)
		{
			Reset();
			target.position = destination;
		}

		protected virtual void OnTeleport(global::UnityEngine.Vector3 destination, global::UnityEngine.Quaternion rotation)
		{
			Reset();
			target.position = destination;
			target.rotation = rotation;
		}

		public virtual void Reset()
		{
			serverSnapshots.Clear();
			clientSnapshots.Clear();
		}

		protected virtual void OnEnable()
		{
			Reset();
			if (global::Mirror.NetworkServer.active)
			{
				global::Mirror.NetworkIdentity.clientAuthorityCallback += OnClientAuthorityChanged;
			}
		}

		protected virtual void OnDisable()
		{
			Reset();
			if (global::Mirror.NetworkServer.active)
			{
				global::Mirror.NetworkIdentity.clientAuthorityCallback -= OnClientAuthorityChanged;
			}
		}

		[global::Mirror.ServerCallback]
		private void OnClientAuthorityChanged(global::Mirror.NetworkConnectionToClient conn, global::Mirror.NetworkIdentity identity, bool authorityState)
		{
			if (global::Mirror.NetworkServer.active && !(identity != base.netIdentity) && syncDirection == global::Mirror.SyncDirection.ClientToServer)
			{
				Reset();
				RpcReset();
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdTeleport__Vector3(global::UnityEngine.Vector3 destination)
		{
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer)
			{
				OnTeleport(destination);
				RpcTeleport(destination);
			}
		}

		protected static void InvokeUserCode_CmdTeleport__Vector3(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdTeleport called on client.");
			}
			else
			{
				((global::Mirror.NetworkTransformBase)obj).UserCode_CmdTeleport__Vector3(reader.ReadVector3());
			}
		}

		protected void UserCode_CmdTeleport__Vector3__Quaternion(global::UnityEngine.Vector3 destination, global::UnityEngine.Quaternion rotation)
		{
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer)
			{
				OnTeleport(destination, rotation);
				RpcTeleport(destination, rotation);
			}
		}

		protected static void InvokeUserCode_CmdTeleport__Vector3__Quaternion(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdTeleport called on client.");
			}
			else
			{
				((global::Mirror.NetworkTransformBase)obj).UserCode_CmdTeleport__Vector3__Quaternion(reader.ReadVector3(), reader.ReadQuaternion());
			}
		}

		protected void UserCode_RpcTeleport__Vector3(global::UnityEngine.Vector3 destination)
		{
			OnTeleport(destination);
		}

		protected static void InvokeUserCode_RpcTeleport__Vector3(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcTeleport called on server.");
			}
			else
			{
				((global::Mirror.NetworkTransformBase)obj).UserCode_RpcTeleport__Vector3(reader.ReadVector3());
			}
		}

		protected void UserCode_RpcTeleport__Vector3__Quaternion(global::UnityEngine.Vector3 destination, global::UnityEngine.Quaternion rotation)
		{
			OnTeleport(destination, rotation);
		}

		protected static void InvokeUserCode_RpcTeleport__Vector3__Quaternion(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcTeleport called on server.");
			}
			else
			{
				((global::Mirror.NetworkTransformBase)obj).UserCode_RpcTeleport__Vector3__Quaternion(reader.ReadVector3(), reader.ReadQuaternion());
			}
		}

		protected void UserCode_RpcReset()
		{
			Reset();
		}

		protected static void InvokeUserCode_RpcReset(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcReset called on server.");
			}
			else
			{
				((global::Mirror.NetworkTransformBase)obj).UserCode_RpcReset();
			}
		}

		static NetworkTransformBase()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkTransformBase), "System.Void Mirror.NetworkTransformBase::CmdTeleport(UnityEngine.Vector3)", InvokeUserCode_CmdTeleport__Vector3, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkTransformBase), "System.Void Mirror.NetworkTransformBase::CmdTeleport(UnityEngine.Vector3,UnityEngine.Quaternion)", InvokeUserCode_CmdTeleport__Vector3__Quaternion, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkTransformBase), "System.Void Mirror.NetworkTransformBase::RpcTeleport(UnityEngine.Vector3)", InvokeUserCode_RpcTeleport__Vector3);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkTransformBase), "System.Void Mirror.NetworkTransformBase::RpcTeleport(UnityEngine.Vector3,UnityEngine.Quaternion)", InvokeUserCode_RpcTeleport__Vector3__Quaternion);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkTransformBase), "System.Void Mirror.NetworkTransformBase::RpcReset()", InvokeUserCode_RpcReset);
		}
	}
}
