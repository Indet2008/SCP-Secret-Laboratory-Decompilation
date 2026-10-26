namespace Mirror
{
	public class NetworkConnectionToServer : global::Mirror.NetworkConnection
	{
		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		protected override void SendToTransport(global::System.ArraySegment<byte> segment, int channelId = 0)
		{
			global::Mirror.Transport.active.ClientSend(segment, channelId);
		}

		public override void Disconnect()
		{
			isReady = false;
			global::Mirror.NetworkClient.ready = false;
			global::Mirror.Transport.active.ClientDisconnect();
		}
	}
}
