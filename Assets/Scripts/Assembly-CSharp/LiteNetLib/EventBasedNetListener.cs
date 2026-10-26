using System.Net;
using System.Net.Sockets;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public class EventBasedNetListener : INetEventListener
	{
		public delegate void OnPeerConnected(NetPeer peer);

		public delegate void OnPeerDisconnected(NetPeer peer, DisconnectInfo disconnectInfo);

		public delegate void OnNetworkError(IPEndPoint endPoint, SocketError socketError);

		public delegate void OnNetworkReceive(NetPeer peer, NetPacketReader reader, byte channel, DeliveryMethod deliveryMethod);

		public delegate void OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType);

		public delegate void OnNetworkLatencyUpdate(NetPeer peer, int latency);

		public delegate void OnConnectionRequest(ConnectionRequest request);

		public delegate void OnDeliveryEvent(NetPeer peer, object userData);

		public delegate void OnNtpResponseEvent(NtpPacket packet);

		public delegate void OnPeerAddressChangedEvent(NetPeer peer, IPEndPoint previousAddress);

		public event OnPeerConnected PeerConnectedEvent;

		public event OnPeerDisconnected PeerDisconnectedEvent;

		public event OnNetworkError NetworkErrorEvent;

		public event OnNetworkReceive NetworkReceiveEvent;

		public event OnNetworkReceiveUnconnected NetworkReceiveUnconnectedEvent;

		public event OnNetworkLatencyUpdate NetworkLatencyUpdateEvent;

		public event OnConnectionRequest ConnectionRequestEvent;

		public event OnDeliveryEvent DeliveryEvent;

		public event OnNtpResponseEvent NtpResponseEvent;

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

		public void ClearNtpResponseEvent()
		{
			NtpResponseEvent = null;
		}

		public void ClearPeerAddressChangedEvent()
		{
			PeerAddressChangedEvent = null;
		}

		void INetEventListener.OnPeerConnected(NetPeer peer)
		{
			PeerConnectedEvent?.Invoke(peer);
		}

		void INetEventListener.OnPeerDisconnected(NetPeer peer, DisconnectInfo disconnectInfo)
		{
			PeerDisconnectedEvent?.Invoke(peer, disconnectInfo);
		}

		void INetEventListener.OnNetworkError(IPEndPoint endPoint, SocketError socketErrorCode)
		{
			NetworkErrorEvent?.Invoke(endPoint, socketErrorCode);
		}

		void INetEventListener.OnNetworkReceive(NetPeer peer, NetPacketReader reader, byte channelNumber, DeliveryMethod deliveryMethod)
		{
			NetworkReceiveEvent?.Invoke(peer, reader, channelNumber, deliveryMethod);
		}

		void INetEventListener.OnNetworkReceiveUnconnected(IPEndPoint remoteEndPoint, NetPacketReader reader, UnconnectedMessageType messageType)
		{
			NetworkReceiveUnconnectedEvent?.Invoke(remoteEndPoint, reader, messageType);
		}

		void INetEventListener.OnNetworkLatencyUpdate(NetPeer peer, int latency)
		{
			NetworkLatencyUpdateEvent?.Invoke(peer, latency);
		}

		void INetEventListener.OnConnectionRequest(ConnectionRequest request)
		{
			ConnectionRequestEvent?.Invoke(request);
		}

		void INetEventListener.OnMessageDelivered(NetPeer peer, object userData)
		{
			DeliveryEvent?.Invoke(peer, userData);
		}

		void INetEventListener.OnNtpResponse(NtpPacket packet)
		{
			NtpResponseEvent?.Invoke(packet);
		}

		void INetEventListener.OnPeerAddressChanged(NetPeer peer, IPEndPoint previousAddress)
		{
			PeerAddressChangedEvent?.Invoke(peer, previousAddress);
		}
	}
}
