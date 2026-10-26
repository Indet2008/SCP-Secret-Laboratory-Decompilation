namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/Network Transform (Reliable)")]
	public class NetworkTransformReliable : global::Mirror.NetworkTransformBase
	{
		[global::UnityEngine.Header("Sync Only If Changed")]
		[global::UnityEngine.Tooltip("When true, changes are not sent unless greater than sensitivity values below.")]
		public bool onlySyncOnChange = true;

		private uint sendIntervalCounter;

		private double lastSendIntervalTime = double.MinValue;

		[global::UnityEngine.Tooltip("If we only sync on change, then we need to correct old snapshots if more time than sendInterval * multiplier has elapsed.\n\nOtherwise the first move will always start interpolating from the last move sequence's time, which will make it stutter when starting every time.")]
		public float onlySyncOnChangeCorrectionMultiplier = 2f;

		[global::UnityEngine.Header("Rotation")]
		[global::UnityEngine.Tooltip("Sensitivity of changes needed before an updated state is sent over the network")]
		public float rotationSensitivity = 0.01f;

		[global::UnityEngine.Tooltip("Apply smallest-three quaternion compression. This is lossy, you can disable it if the small rotation inaccuracies are noticeable in your project.")]
		public bool compressRotation;

		[global::UnityEngine.Header("Precision")]
		[global::UnityEngine.Tooltip("Position is rounded in order to drastically minimize bandwidth.\n\nFor example, a precision of 0.01 rounds to a centimeter. In other words, sub-centimeter movements aren't synced until they eventually exceeded an actual centimeter.\n\nDepending on how important the object is, a precision of 0.01-0.10 (1-10 cm) is recommended.\n\nFor example, even a 1cm precision combined with delta compression cuts the Benchmark demo's bandwidth in half, compared to sending every tiny change.")]
		[global::UnityEngine.Range(0.0001f, 1f)]
		public float positionPrecision = 0.01f;

		[global::UnityEngine.Range(0.0001f, 1f)]
		public float scalePrecision = 0.01f;

		protected global::Mirror.Vector3Long lastSerializedPosition = global::Mirror.Vector3Long.zero;

		protected global::Mirror.Vector3Long lastDeserializedPosition = global::Mirror.Vector3Long.zero;

		protected global::Mirror.Vector3Long lastSerializedScale = global::Mirror.Vector3Long.zero;

		protected global::Mirror.Vector3Long lastDeserializedScale = global::Mirror.Vector3Long.zero;

		protected global::Mirror.TransformSnapshot last;

		protected int lastClientCount = 1;

		private void Update()
		{
			if (base.isServer)
			{
				UpdateServer();
			}
			else if (base.isClient)
			{
				UpdateClient();
			}
		}

		private void LateUpdate()
		{
			if (base.isServer || (base.IsClientWithAuthority && global::Mirror.NetworkClient.ready))
			{
				if (sendIntervalCounter == sendIntervalMultiplier && (!onlySyncOnChange || Changed(Construct())))
				{
					SetDirty();
				}
				CheckLastSendTime();
			}
		}

		protected virtual void UpdateServer()
		{
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer && base.connectionToClient != null && !base.isOwned && serverSnapshots.Count > 0)
			{
				global::Mirror.SnapshotInterpolation.StepInterpolation(serverSnapshots, base.connectionToClient.remoteTimeline, out var fromSnapshot, out var toSnapshot, out var t);
				global::Mirror.TransformSnapshot interpolated = global::Mirror.TransformSnapshot.Interpolate(fromSnapshot, toSnapshot, t);
				Apply(interpolated, toSnapshot);
			}
		}

		protected virtual void UpdateClient()
		{
			if (!base.IsClientWithAuthority)
			{
				if (clientSnapshots.Count > 0)
				{
					global::Mirror.SnapshotInterpolation.StepInterpolation(clientSnapshots, global::Mirror.NetworkTime.time, out var fromSnapshot, out var toSnapshot, out var t);
					global::Mirror.TransformSnapshot interpolated = global::Mirror.TransformSnapshot.Interpolate(fromSnapshot, toSnapshot, t);
					Apply(interpolated, toSnapshot);
				}
				lastClientCount = clientSnapshots.Count;
			}
		}

		protected virtual void CheckLastSendTime()
		{
			if (global::Mirror.AccurateInterval.Elapsed(global::Mirror.NetworkTime.localTime, global::Mirror.NetworkServer.sendInterval, ref lastSendIntervalTime))
			{
				if (sendIntervalCounter == sendIntervalMultiplier)
				{
					sendIntervalCounter = 0u;
				}
				sendIntervalCounter++;
			}
		}

		protected virtual bool Changed(global::Mirror.TransformSnapshot current)
		{
			if (!QuantizedChanged(last.position, current.position, positionPrecision) && !(global::UnityEngine.Quaternion.Angle(last.rotation, current.rotation) > rotationSensitivity))
			{
				return QuantizedChanged(last.scale, current.scale, scalePrecision);
			}
			return true;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		protected bool QuantizedChanged(global::UnityEngine.Vector3 u, global::UnityEngine.Vector3 v, float precision)
		{
			global::Mirror.Compression.ScaleToLong(u, precision, out var quantized);
			global::Mirror.Compression.ScaleToLong(v, precision, out var quantized2);
			return quantized != quantized2;
		}

		public override void OnSerialize(global::Mirror.NetworkWriter writer, bool initialState)
		{
			global::Mirror.TransformSnapshot transformSnapshot = Construct();
			if (initialState)
			{
				if (last.remoteTime > 0.0)
				{
					transformSnapshot = last;
				}
				if (syncPosition)
				{
					writer.WriteVector3(transformSnapshot.position);
				}
				if (syncRotation)
				{
					if (compressRotation)
					{
						writer.WriteUInt(global::Mirror.Compression.CompressQuaternion(transformSnapshot.rotation));
					}
					else
					{
						writer.WriteQuaternion(transformSnapshot.rotation);
					}
				}
				if (syncScale)
				{
					writer.WriteVector3(transformSnapshot.scale);
				}
			}
			else
			{
				if (syncPosition)
				{
					global::Mirror.Compression.ScaleToLong(transformSnapshot.position, positionPrecision, out var quantized);
					global::Mirror.DeltaCompression.Compress(writer, lastSerializedPosition, quantized);
				}
				if (syncRotation)
				{
					if (compressRotation)
					{
						writer.WriteUInt(global::Mirror.Compression.CompressQuaternion(transformSnapshot.rotation));
					}
					else
					{
						writer.WriteQuaternion(transformSnapshot.rotation);
					}
				}
				if (syncScale)
				{
					global::Mirror.Compression.ScaleToLong(transformSnapshot.scale, scalePrecision, out var quantized2);
					global::Mirror.DeltaCompression.Compress(writer, lastSerializedScale, quantized2);
				}
			}
			if (syncPosition)
			{
				global::Mirror.Compression.ScaleToLong(transformSnapshot.position, positionPrecision, out lastSerializedPosition);
			}
			if (syncScale)
			{
				global::Mirror.Compression.ScaleToLong(transformSnapshot.scale, scalePrecision, out lastSerializedScale);
			}
			last = transformSnapshot;
		}

		public override void OnDeserialize(global::Mirror.NetworkReader reader, bool initialState)
		{
			global::UnityEngine.Vector3? position = null;
			global::UnityEngine.Quaternion? rotation = null;
			global::UnityEngine.Vector3? scale = null;
			if (initialState)
			{
				if (syncPosition)
				{
					position = reader.ReadVector3();
				}
				if (syncRotation)
				{
					rotation = ((!compressRotation) ? new global::UnityEngine.Quaternion?(reader.ReadQuaternion()) : new global::UnityEngine.Quaternion?(global::Mirror.Compression.DecompressQuaternion(reader.ReadUInt())));
				}
				if (syncScale)
				{
					scale = reader.ReadVector3();
				}
			}
			else
			{
				if (syncPosition)
				{
					global::Mirror.Vector3Long value = global::Mirror.DeltaCompression.Decompress(reader, lastDeserializedPosition);
					position = global::Mirror.Compression.ScaleToFloat(value, positionPrecision);
				}
				if (syncRotation)
				{
					rotation = ((!compressRotation) ? new global::UnityEngine.Quaternion?(reader.ReadQuaternion()) : new global::UnityEngine.Quaternion?(global::Mirror.Compression.DecompressQuaternion(reader.ReadUInt())));
				}
				if (syncScale)
				{
					global::Mirror.Vector3Long value2 = global::Mirror.DeltaCompression.Decompress(reader, lastDeserializedScale);
					scale = global::Mirror.Compression.ScaleToFloat(value2, scalePrecision);
				}
			}
			if (base.isServer)
			{
				OnClientToServerSync(position, rotation, scale);
			}
			else if (base.isClient)
			{
				OnServerToClientSync(position, rotation, scale);
			}
			if (syncPosition)
			{
				global::Mirror.Compression.ScaleToLong(position.Value, positionPrecision, out lastDeserializedPosition);
			}
			if (syncScale)
			{
				global::Mirror.Compression.ScaleToLong(scale.Value, scalePrecision, out lastDeserializedScale);
			}
		}

		protected virtual void OnClientToServerSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			if (syncDirection == global::Mirror.SyncDirection.ClientToServer && serverSnapshots.Count < base.connectionToClient.snapshotBufferSizeLimit)
			{
				if (onlySyncOnChange && NeedsCorrection(serverSnapshots, base.connectionToClient.remoteTimeStamp, global::Mirror.NetworkServer.sendInterval * (float)sendIntervalMultiplier, onlySyncOnChangeCorrectionMultiplier))
				{
					RewriteHistory(serverSnapshots, base.connectionToClient.remoteTimeStamp, global::Mirror.NetworkTime.localTime, global::Mirror.NetworkServer.sendInterval * (float)sendIntervalMultiplier, GetPosition(), GetRotation(), GetScale());
				}
				AddSnapshot(serverSnapshots, base.connectionToClient.remoteTimeStamp + base.timeStampAdjustment + base.offset, position, rotation, scale);
			}
		}

		protected virtual void OnServerToClientSync(global::UnityEngine.Vector3? position, global::UnityEngine.Quaternion? rotation, global::UnityEngine.Vector3? scale)
		{
			if (!base.IsClientWithAuthority)
			{
				if (onlySyncOnChange && NeedsCorrection(clientSnapshots, global::Mirror.NetworkClient.connection.remoteTimeStamp, global::Mirror.NetworkClient.sendInterval * (float)sendIntervalMultiplier, onlySyncOnChangeCorrectionMultiplier))
				{
					RewriteHistory(clientSnapshots, global::Mirror.NetworkClient.connection.remoteTimeStamp, global::Mirror.NetworkTime.localTime, global::Mirror.NetworkClient.sendInterval * (float)sendIntervalMultiplier, GetPosition(), GetRotation(), GetScale());
				}
				AddSnapshot(clientSnapshots, global::Mirror.NetworkClient.connection.remoteTimeStamp + base.timeStampAdjustment + base.offset, position, rotation, scale);
			}
		}

		private static bool NeedsCorrection(global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot> snapshots, double remoteTimestamp, double bufferTime, double toleranceMultiplier)
		{
			if (snapshots.Count == 1)
			{
				return remoteTimestamp - snapshots.Keys[0] >= bufferTime * toleranceMultiplier;
			}
			return false;
		}

		private static void RewriteHistory(global::System.Collections.Generic.SortedList<double, global::Mirror.TransformSnapshot> snapshots, double remoteTimeStamp, double localTime, double sendInterval, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			snapshots.Clear();
			global::Mirror.SnapshotInterpolation.InsertIfNotExists(snapshots, global::Mirror.NetworkClient.snapshotSettings.bufferLimit, new global::Mirror.TransformSnapshot(remoteTimeStamp - sendInterval, localTime - sendInterval, position, rotation, scale));
		}

		public override void Reset()
		{
			base.Reset();
			lastSerializedPosition = global::Mirror.Vector3Long.zero;
			lastDeserializedPosition = global::Mirror.Vector3Long.zero;
			lastSerializedScale = global::Mirror.Vector3Long.zero;
			lastDeserializedScale = global::Mirror.Vector3Long.zero;
			last = new global::Mirror.TransformSnapshot(0.0, 0.0, global::UnityEngine.Vector3.zero, global::UnityEngine.Quaternion.identity, global::UnityEngine.Vector3.zero);
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
