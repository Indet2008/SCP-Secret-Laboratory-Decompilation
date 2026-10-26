namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/Network Transform (Unreliable)")]
	public class NetworkTransformUnreliable : global::Mirror.NetworkTransformBase
	{
		[global::UnityEngine.Header("Sync Only If Changed")]
		[global::UnityEngine.Tooltip("When true, changes are not sent unless greater than sensitivity values below.")]
		public bool onlySyncOnChange = true;

		private uint sendIntervalCounter;

		private double lastSendIntervalTime = double.MinValue;

		[global::UnityEngine.Tooltip("How much time, as a multiple of send interval, has passed before clearing buffers.\nA larger buffer means more delay, but results in smoother movement.\nExample: 1 for faster responses minimal smoothing, 5 covers bad pings but has noticable delay, 3 is recommended for balanced results,.")]
		public float bufferResetMultiplier = 3f;

		[global::UnityEngine.Header("Sensitivity")]
		[global::UnityEngine.Tooltip("Sensitivity of changes needed before an updated state is sent over the network")]
		public float positionSensitivity = 0.01f;

		public float rotationSensitivity = 0.01f;

		public float scaleSensitivity = 0.01f;

		protected bool positionChanged;

		protected bool rotationChanged;

		protected bool scaleChanged;

		protected global::Mirror.TransformSnapshot lastSnapshot;

		protected bool cachedSnapshotComparison;

		protected bool hasSentUnchangedPosition;

		private void Update()
		{
			if (base.isServer)
			{
				UpdateServerInterpolation();
			}
			else if (base.isClient && !base.IsClientWithAuthority)
			{
				UpdateClientInterpolation();
			}
		}

		private void LateUpdate()
		{
			if (base.isServer)
			{
				UpdateServerBroadcast();
			}
			else if (base.isClient && base.IsClientWithAuthority)
			{
				UpdateClientBroadcast();
			}
		}

		protected virtual void CheckLastSendTime()
		{
			if (sendIntervalCounter == sendIntervalMultiplier)
			{
				sendIntervalCounter = 0u;
			}
			if (global::Mirror.AccurateInterval.Elapsed(global::Mirror.NetworkTime.localTime, global::Mirror.NetworkServer.sendInterval, ref lastSendIntervalTime))
			{
				sendIntervalCounter++;
			}
		}

		private void UpdateServerBroadcast()
		{
			CheckLastSendTime();
			if (sendIntervalCounter != sendIntervalMultiplier || (syncDirection != global::Mirror.SyncDirection.ServerToClient && !base.IsClientWithAuthority))
			{
				return;
			}
			global::Mirror.TransformSnapshot currentSnapshot = Construct();
			cachedSnapshotComparison = CompareSnapshots(currentSnapshot);
			if (!cachedSnapshotComparison || !hasSentUnchangedPosition || !onlySyncOnChange)
			{
				RpcServerToClientSync((syncPosition && positionChanged) ? new global::UnityEngine.Vector3?(currentSnapshot.position) : ((global::UnityEngine.Vector3?)null), (syncRotation && rotationChanged) ? new global::UnityEngine.Quaternion?(currentSnapshot.rotation) : ((global::UnityEngine.Quaternion?)null), (syncScale && scaleChanged) ? new global::UnityEngine.Vector3?(currentSnapshot.scale) : ((global::UnityEngine.Vector3?)null));
				if (cachedSnapshotComparison)
				{
					hasSentUnchangedPosition = true;
					return;
				}
				hasSentUnchangedPosition = false;
				lastSnapshot = currentSnapshot;
			}
		}

		private void UpdateServerInterpolation()
		{
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer && base.connectionToClient != null && !base.isOwned && serverSnapshots.Count != 0)
			{
				global::Mirror.SnapshotInterpolation.StepInterpolation(serverSnapshots, base.connectionToClient.remoteTimeline, out var fromSnapshot, out var toSnapshot, out var t);
				global::Mirror.TransformSnapshot interpolated = global::Mirror.TransformSnapshot.Interpolate(fromSnapshot, toSnapshot, t);
				Apply(interpolated, toSnapshot);
			}
		}

		private void UpdateClientBroadcast()
		{
			if (!global::Mirror.NetworkClient.ready)
			{
				return;
			}
			CheckLastSendTime();
			if (sendIntervalCounter != sendIntervalMultiplier)
			{
				return;
			}
			global::Mirror.TransformSnapshot currentSnapshot = Construct();
			cachedSnapshotComparison = CompareSnapshots(currentSnapshot);
			if (!cachedSnapshotComparison || !hasSentUnchangedPosition || !onlySyncOnChange)
			{
				CmdClientToServerSync((syncPosition && positionChanged) ? new global::UnityEngine.Vector3?(currentSnapshot.position) : ((global::UnityEngine.Vector3?)null), (syncRotation && rotationChanged) ? new global::UnityEngine.Quaternion?(currentSnapshot.rotation) : ((global::UnityEngine.Quaternion?)null), (syncScale && scaleChanged) ? new global::UnityEngine.Vector3?(currentSnapshot.scale) : ((global::UnityEngine.Vector3?)null));
				if (cachedSnapshotComparison)
				{
					hasSentUnchangedPosition = true;
					return;
				}
				hasSentUnchangedPosition = false;
				lastSnapshot = currentSnapshot;
			}
		}

		private void UpdateClientInterpolation()
		{
			if (clientSnapshots.Count != 0)
			{
				global::Mirror.SnapshotInterpolation.StepInterpolation(clientSnapshots, global::Mirror.NetworkTime.time, out var fromSnapshot, out var toSnapshot, out var t);
				global::Mirror.TransformSnapshot interpolated = global::Mirror.TransformSnapshot.Interpolate(fromSnapshot, toSnapshot, t);
				Apply(interpolated, toSnapshot);
			}
		}

		public override void OnSerialize(global::Mirror.NetworkWriter writer, bool initialState)
		{
			if (initialState)
			{
				if (syncPosition)
				{
					writer.WriteVector3(GetPosition());
				}
				if (syncRotation)
				{
					writer.WriteQuaternion(GetRotation());
				}
				if (syncScale)
				{
					writer.WriteVector3(GetScale());
				}
			}
		}

		public override void OnDeserialize(global::Mirror.NetworkReader reader, bool initialState)
		{
			if (initialState)
			{
				if (syncPosition)
				{
					SetPosition(reader.ReadVector3());
				}
				if (syncRotation)
				{
					SetRotation(reader.ReadQuaternion());
				}
				if (syncScale)
				{
					SetScale(reader.ReadVector3());
				}
			}
		}

		protected virtual bool CompareSnapshots(global::Mirror.TransformSnapshot currentSnapshot)
		{
			positionChanged = global::UnityEngine.Vector3.SqrMagnitude(lastSnapshot.position - currentSnapshot.position) > positionSensitivity * positionSensitivity;
			rotationChanged = global::UnityEngine.Quaternion.Angle(lastSnapshot.rotation, currentSnapshot.rotation) > rotationSensitivity;
			scaleChanged = global::UnityEngine.Vector3.SqrMagnitude(lastSnapshot.scale - currentSnapshot.scale) > scaleSensitivity * scaleSensitivity;
			if (!positionChanged && !rotationChanged)
			{
				return !scaleChanged;
			}
			return false;
		}

		[global::Mirror.Command(channel = 1)]
		private void CmdClientToServerSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3Nullable(position);
			writer.WriteQuaternionNullable(rotation);
			writer.WriteVector3Nullable(scale);
			SendCommandInternal("System.Void Mirror.NetworkTransformUnreliable::CmdClientToServerSync(System.Nullable`1<UnityEngine.Vector3>,System.Nullable`1<UnityEngine.Quaternion>,System.Nullable`1<UnityEngine.Vector3>)", -1263136411, writer, 1);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		protected virtual void OnClientToServerSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			if (syncDirection != global::Mirror.SyncDirection.ClientToServer || serverSnapshots.Count >= base.connectionToClient.snapshotBufferSizeLimit)
			{
				return;
			}
			double remoteTimeStamp = base.connectionToClient.remoteTimeStamp;
			if (onlySyncOnChange)
			{
				double num = bufferResetMultiplier * (float)sendIntervalMultiplier * global::Mirror.NetworkClient.sendInterval;
				if (serverSnapshots.Count > 0 && serverSnapshots.Values[serverSnapshots.Count - 1].remoteTime + num < remoteTimeStamp)
				{
					Reset();
				}
			}
			AddSnapshot(serverSnapshots, base.connectionToClient.remoteTimeStamp + base.timeStampAdjustment + base.offset, position, rotation, scale);
		}

		[global::Mirror.ClientRpc(channel = 1)]
		private void RpcServerToClientSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteVector3Nullable(position);
			writer.WriteQuaternionNullable(rotation);
			writer.WriteVector3Nullable(scale);
			SendRPCInternal("System.Void Mirror.NetworkTransformUnreliable::RpcServerToClientSync(System.Nullable`1<UnityEngine.Vector3>,System.Nullable`1<UnityEngine.Quaternion>,System.Nullable`1<UnityEngine.Vector3>)", -1968965670, writer, 1, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		protected virtual void OnServerToClientSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			if (base.isServer || base.IsClientWithAuthority)
			{
				return;
			}
			double remoteTimeStamp = global::Mirror.NetworkClient.connection.remoteTimeStamp;
			if (onlySyncOnChange)
			{
				double num = bufferResetMultiplier * (float)sendIntervalMultiplier * global::Mirror.NetworkServer.sendInterval;
				if (clientSnapshots.Count > 0 && clientSnapshots.Values[clientSnapshots.Count - 1].remoteTime + num < remoteTimeStamp)
				{
					Reset();
				}
			}
			AddSnapshot(clientSnapshots, global::Mirror.NetworkClient.connection.remoteTimeStamp + base.timeStampAdjustment + base.offset, position, rotation, scale);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdClientToServerSync__Nullable_00601__Nullable_00601__Nullable_00601(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			OnClientToServerSync(position, rotation, scale);
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer)
			{
				RpcServerToClientSync(position, rotation, scale);
			}
		}

		protected static void InvokeUserCode_CmdClientToServerSync__Nullable_00601__Nullable_00601__Nullable_00601(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdClientToServerSync called on client.");
			}
			else
			{
				((global::Mirror.NetworkTransformUnreliable)obj).UserCode_CmdClientToServerSync__Nullable_00601__Nullable_00601__Nullable_00601(reader.ReadVector3Nullable(), reader.ReadQuaternionNullable(), reader.ReadVector3Nullable());
			}
		}

		protected void UserCode_RpcServerToClientSync__Nullable_00601__Nullable_00601__Nullable_00601(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			OnServerToClientSync(position, rotation, scale);
		}

		protected static void InvokeUserCode_RpcServerToClientSync__Nullable_00601__Nullable_00601__Nullable_00601(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcServerToClientSync called on server.");
			}
			else
			{
				((global::Mirror.NetworkTransformUnreliable)obj).UserCode_RpcServerToClientSync__Nullable_00601__Nullable_00601__Nullable_00601(reader.ReadVector3Nullable(), reader.ReadQuaternionNullable(), reader.ReadVector3Nullable());
			}
		}

		static NetworkTransformUnreliable()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkTransformUnreliable), "System.Void Mirror.NetworkTransformUnreliable::CmdClientToServerSync(System.Nullable`1<UnityEngine.Vector3>,System.Nullable`1<UnityEngine.Quaternion>,System.Nullable`1<UnityEngine.Vector3>)", InvokeUserCode_CmdClientToServerSync__Nullable_00601__Nullable_00601__Nullable_00601, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkTransformUnreliable), "System.Void Mirror.NetworkTransformUnreliable::RpcServerToClientSync(System.Nullable`1<UnityEngine.Vector3>,System.Nullable`1<UnityEngine.Quaternion>,System.Nullable`1<UnityEngine.Vector3>)", InvokeUserCode_RpcServerToClientSync__Nullable_00601__Nullable_00601__Nullable_00601);
		}
	}
}
