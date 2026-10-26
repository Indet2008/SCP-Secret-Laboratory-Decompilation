namespace Mirror
{
	public class LocalConnectionToClient : global::Mirror.NetworkConnectionToClient
	{
		internal global::Mirror.LocalConnectionToServer connectionToServer;

		public override string address => "localhost";

		public LocalConnectionToClient()
			: base(0)
		{
		}

		public override void Send(global::System.ArraySegment<byte> segment, int channelId = 0)
		{
			global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			networkWriterPooled.WriteBytes(segment.Array, segment.Offset, segment.Count);
			connectionToServer.queue.Enqueue(networkWriterPooled);
		}

		internal override bool IsAlive(float timeout)
		{
			return true;
		}

		protected override void UpdatePing()
		{
		}

		internal void DisconnectInternal()
		{
			isReady = false;
			RemoveFromObservingsObservers();
		}

		public override void Disconnect()
		{
			DisconnectInternal();
			connectionToServer.DisconnectInternal();
		}
	}
}
