using System.Net;
using System.Net.Sockets;

namespace LiteNetLib
{
	public interface ILiteNetEventListener
	{
		void OnPeerConnected(LiteNetPeer peer);

		void OnPeerDisconnected(LiteNetPeer peer, DisconnectInfo disconnectInfo);

		void OnNetworkError(IPEndPoint endPoint, SocketError socketError)
		{
		}

		void OnNetworkReceive(LiteNetPeer peer, NetPacketReader reader, DeliveryMethod deliveryMethod);

		void OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType)
		{
		}

		void OnNetworkLatencyUpdate(LiteNetPeer peer, int latency)
		{
		}

		void OnConnectionRequest(ConnectionRequest request);

		void OnPeerAddressChanged(LiteNetPeer peer, IPEndPoint previousAddress)
		{
		}

		void OnMessageDelivered(LiteNetPeer peer, object userData)
		{
		}
	}
}
