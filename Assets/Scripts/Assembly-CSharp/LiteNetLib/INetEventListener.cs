using System.Net;
using System.Net.Sockets;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public interface INetEventListener
	{
		void OnPeerConnected(NetPeer peer);

		void OnPeerDisconnected(NetPeer peer, DisconnectInfo disconnectInfo);

		void OnNetworkError(IPEndPoint endPoint, SocketError socketError);

		void OnNetworkReceive(NetPeer peer, NetPacketReader reader, byte channelNumber, DeliveryMethod deliveryMethod);

		void OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType);

		void OnNetworkLatencyUpdate(NetPeer peer, int latency);

		void OnConnectionRequest(ConnectionRequest request);

		void OnMessageDelivered(NetPeer peer, object userData)
		{
		}

		void OnNtpResponse(NtpPacket packet)
		{
		}

		void OnPeerAddressChanged(NetPeer peer, IPEndPoint previousAddress)
		{
		}
	}
}
