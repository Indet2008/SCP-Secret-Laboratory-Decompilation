namespace Mirror
{
	public class LocalConnectionToServer : global::Mirror.NetworkConnectionToServer
	{
		internal global::Mirror.LocalConnectionToClient connectionToClient;

		internal readonly global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled> queue = new global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled>();

		private bool connectedEventPending;

		private bool disconnectedEventPending;

		[global::System.Obsolete("Use LocalConnectionToClient.address instead.")]
		public string address => "localhost";

		internal void QueueConnectedEvent()
		{
			connectedEventPending = true;
		}

		internal void QueueDisconnectedEvent()
		{
			disconnectedEventPending = true;
		}

		public override void Send(global::System.ArraySegment<byte> segment, int channelId = 0)
		{
			if (segment.Count == 0)
			{
				global::UnityEngine.Debug.LogError("LocalConnection.SendBytes cannot send zero bytes");
				return;
			}
			global::Mirror.Batcher batchForChannelId = GetBatchForChannelId(channelId);
			batchForChannelId.AddMessage(segment, global::Mirror.NetworkTime.localTime);
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			if (batchForChannelId.GetBatch(networkWriterPooled))
			{
				global::Mirror.NetworkServer.OnTransportData(connectionId, networkWriterPooled.ToArraySegment(), channelId);
			}
			else
			{
				global::UnityEngine.Debug.LogError("Local connection failed to make batch. This should never happen.");
			}
		}

		internal override void Update()
		{
			base.Update();
			if (connectedEventPending)
			{
				connectedEventPending = false;
				global::Mirror.NetworkClient.OnConnectedEvent?.Invoke();
			}
			while (queue.Count > 0)
			{
				global::Mirror.NetworkWriterPooled networkWriterPooled = queue.Dequeue();
				global::System.ArraySegment<byte> message = networkWriterPooled.ToArraySegment();
				global::Mirror.Batcher batchForChannelId = GetBatchForChannelId(0);
				batchForChannelId.AddMessage(message, global::Mirror.NetworkTime.localTime);
				using (global::Mirror.NetworkWriterPooled networkWriterPooled2 = global::Mirror.NetworkWriterPool.Get())
				{
					if (batchForChannelId.GetBatch(networkWriterPooled2))
					{
						global::Mirror.NetworkClient.OnTransportData(networkWriterPooled2.ToArraySegment(), 0);
					}
				}
				global::Mirror.NetworkWriterPool.Return(networkWriterPooled);
			}
			if (disconnectedEventPending)
			{
				disconnectedEventPending = false;
				global::Mirror.NetworkClient.OnDisconnectedEvent?.Invoke();
			}
		}

		internal void DisconnectInternal()
		{
			isReady = false;
			global::Mirror.NetworkClient.ready = false;
		}

		public override void Disconnect()
		{
			connectionToClient.DisconnectInternal();
			DisconnectInternal();
			global::Mirror.NetworkServer.RemoveLocalConnection();
			global::Mirror.NetworkClient.OnTransportDisconnected();
		}

		internal override bool IsAlive(float timeout)
		{
			return true;
		}
	}
}
