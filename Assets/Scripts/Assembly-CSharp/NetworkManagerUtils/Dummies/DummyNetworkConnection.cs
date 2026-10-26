using System;
using Mirror;

namespace NetworkManagerUtils.Dummies
{
	public class DummyNetworkConnection : NetworkConnectionToClient
	{
		private const string DummyAddress = "127.0.0.1";

		private static int _idGenerator = 65535;

		public override string address { get; } = "127.0.0.1";

		public DummyNetworkConnection()
			: base(_idGenerator--)
		{
		}

		public override void Send(ArraySegment<byte> segment, int channelId = 0)
		{
		}

		public override void Disconnect()
		{
		}

		protected override void SendToTransport(ArraySegment<byte> segment, int channelId = 0)
		{
		}

		protected override void UpdatePing()
		{
		}
	}
}
