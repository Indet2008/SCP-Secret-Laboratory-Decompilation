namespace Mirror
{
	public abstract class NetworkConnection
	{
		public const int LocalConnectionId = 0;

		public readonly int connectionId;

		public bool isAuthenticated;

		public object authenticationData;

		public bool isReady;

		public float lastMessageTime;

		public readonly global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity> owned = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>();

		protected global::System.Collections.Generic.Dictionary<int, global::Mirror.Batcher> batches = new global::System.Collections.Generic.Dictionary<int, global::Mirror.Batcher>();

		public global::Mirror.NetworkIdentity identity { get; internal set; }

		public double remoteTimeStamp { get; internal set; }

		internal NetworkConnection()
		{
			lastMessageTime = global::UnityEngine.Time.time;
		}

		internal NetworkConnection(int networkConnectionId)
			: this()
		{
			connectionId = networkConnectionId;
		}

		protected global::Mirror.Batcher GetBatchForChannelId(int channelId)
		{
			if (!batches.TryGetValue(channelId, out var value))
			{
				value = new global::Mirror.Batcher(global::Mirror.Transport.active.GetBatchThreshold(channelId));
				batches[channelId] = value;
			}
			return value;
		}

		public void Send<T>(T message, int channelId = 0) where T : struct, global::Mirror.NetworkMessage
		{
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			global::Mirror.NetworkMessages.Pack(message, networkWriterPooled);
			int num = global::Mirror.NetworkMessages.MaxMessageSize(channelId);
			if (networkWriterPooled.Position > num)
			{
				global::UnityEngine.Debug.LogError($"NetworkConnection.Send: message of type {typeof(T)} with a size of {networkWriterPooled.Position} bytes is larger than the max allowed message size in one batch: {num}.\nThe message was dropped, please make it smaller.");
				return;
			}
			global::Mirror.NetworkDiagnostics.OnSend(message, channelId, networkWriterPooled.Position, 1);
			Send(networkWriterPooled.ToArraySegment(), channelId);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public virtual void Send(global::System.ArraySegment<byte> segment, int channelId = 0)
		{
			GetBatchForChannelId(channelId).AddMessage(segment, global::Mirror.NetworkTime.localTime);
		}

		protected abstract void SendToTransport(global::System.ArraySegment<byte> segment, int channelId = 0);

		internal virtual void Update()
		{
			foreach (global::System.Collections.Generic.KeyValuePair<int, global::Mirror.Batcher> batch in batches)
			{
				using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
				while (batch.Value.GetBatch(networkWriterPooled))
				{
					global::System.ArraySegment<byte> segment = networkWriterPooled.ToArraySegment();
					SendToTransport(segment, batch.Key);
					networkWriterPooled.Position = 0;
				}
			}
		}

		internal virtual bool IsAlive(float timeout)
		{
			return global::UnityEngine.Time.time - lastMessageTime < timeout;
		}

		public abstract void Disconnect();

		public override string ToString()
		{
			return $"connection({connectionId})";
		}
	}
}
