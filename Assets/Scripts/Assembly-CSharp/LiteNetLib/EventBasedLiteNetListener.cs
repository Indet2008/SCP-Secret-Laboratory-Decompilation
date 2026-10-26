using System.Net;
using System.Net.Sockets;

namespace LiteNetLib
{
	public class EventBasedLiteNetListener : ILiteNetEventListener
	{
		public delegate void OnPeerConnected(LiteNetPeer peer);

		public delegate void OnPeerDisconnected(LiteNetPeer peer, DisconnectInfo disconnectInfo);

		public delegate void OnNetworkError(IPEndPoint endPoint, SocketError socketError);

		public delegate void OnNetworkReceive(LiteNetPeer peer, NetPacketReader reader, DeliveryMethod deliveryMethod);

		public delegate void OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType);

		public delegate void OnNetworkLatencyUpdate(LiteNetPeer peer, int latency);

		public delegate void OnConnectionRequest(ConnectionRequest request);

		public delegate void OnDeliveryEvent(LiteNetPeer peer, object userData);

		public delegate void OnPeerAddressChangedEvent(LiteNetPeer peer, IPEndPoint previousAddress);

		public event OnPeerConnected PeerConnectedEvent;

		public event OnPeerDisconnected PeerDisconnectedEvent;

		public event OnNetworkError NetworkErrorEvent;

		public event OnNetworkReceive NetworkReceiveEvent;

		public event OnNetworkReceiveUnconnected NetworkReceiveUnconnectedEvent;

		public event OnNetworkLatencyUpdate NetworkLatencyUpdateEvent;

		public event OnConnectionRequest ConnectionRequestEvent;

		public event OnDeliveryEvent DeliveryEvent;

		public event OnPeerAddressChangedEvent PeerAddressChangedEvent;

		public void ClearPeerConnectedEvent()
		{
			PeerConnectedEvent = null;
		}

		public void ClearPeerDisconnectedEvent()
		{
			PeerDisconnectedEvent = null;
		}

		public void ClearNetworkErrorEvent()
		{
			NetworkErrorEvent = null;
		}

		public void ClearNetworkReceiveEvent()
		{
			NetworkReceiveEvent = null;
		}

		public void ClearNetworkReceiveUnconnectedEvent()
		{
			NetworkReceiveUnconnectedEvent = null;
		}

		public void ClearNetworkLatencyUpdateEvent()
		{
			NetworkLatencyUpdateEvent = null;
		}

		public void ClearConnectionRequestEvent()
		{
			ConnectionRequestEvent = null;
		}

		public void ClearDeliveryEvent()
		{
			DeliveryEvent = null;
		}

		public void ClearPeerAddressChangedEvent()
		{
			PeerAddressChangedEvent = null;
		}

		void ILiteNetEventListener.OnPeerConnected(LiteNetPeer peer)
		{
			PeerConnectedEvent?.Invoke(peer);
		}

		void ILiteNetEventListener.OnPeerDisconnected(LiteNetPeer peer, DisconnectInfo disconnectInfo)
		{
			PeerDisconnectedEvent?.Invoke(peer, disconnectInfo);
		}

		void ILiteNetEventListener.OnNetworkError(IPEndPoint endPoint, SocketError socketErrorCode)
		{
			NetworkErrorEvent?.Invoke(endPoint, socketErrorCode);
		}

		void ILiteNetEventListener.OnNetworkReceive(LiteNetPeer peer, NetPacketReader reader, DeliveryMethod deliveryMethod)
		{
			NetworkReceiveEvent?.Invoke(peer, reader, deliveryMethod);
		}

		void ILiteNetEventListener.OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType)
		{
			NetworkReceiveUnconnectedEvent?.Invoke(remoteEndPoint, reader, messageType);
		}

		void ILiteNetEventListener.OnNetworkLatencyUpdate(LiteNetPeer peer, int latency)
		{
			NetworkLatencyUpdateEvent?.Invoke(peer, latency);
		}

		void ILiteNetEventListener.OnConnectionRequest(ConnectionRequest request)
		{
			ConnectionRequestEvent?.Invoke(request);
		}

		void ILiteNetEventListener.OnMessageDelivered(LiteNetPeer peer, object userData)
		{
			DeliveryEvent?.Invoke(peer, userData);
		}

		void ILiteNetEventListener.OnPeerAddressChanged(LiteNetPeer peer, IPEndPoint previousAddress)
		{
			PeerAddressChangedEvent?.Invoke(peer, previousAddress);
		}
	}
}
