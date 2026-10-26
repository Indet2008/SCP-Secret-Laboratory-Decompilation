using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Net;
using LiteNetLib.Layers;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public class NetManager : LiteNetManager, IEnumerable<NetPeer>, IEnumerable
	{
		private readonly INetEventListener _netEventListener;

		private byte _channelsCount = 1;

		private readonly ConcurrentDictionary<IPEndPoint, NtpRequest> _ntpRequests = new ConcurrentDictionary<IPEndPoint, NtpRequest>();

		public byte ChannelsCount
		{
			get
			{
				return _channelsCount;
			}
			set
			{
				if (value < 1 || value > 64)
				{
					throw new ArgumentException("Channels count must be between 1 and 64");
				}
				_channelsCount = value;
			}
		}

		public new NetPeer FirstPeer => (NetPeer)_headPeer;

		public void GetPeers(List<NetPeer> peers, ConnectionState peerState)
		{
			peers.Clear();
			_peersLock.EnterReadLock();
			for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
			{
				if ((liteNetPeer.ConnectionState & peerState) != 0)
				{
					peers.Add((NetPeer)liteNetPeer);
				}
			}
			_peersLock.ExitReadLock();
		}

		public void GetConnectedPeers(List<NetPeer> peers)
		{
			GetPeers(peers, ConnectionState.Connected);
		}

		public NetManager(INetEventListener listener, PacketLayerBase extraPacketLayer = null)
			: base(null, extraPacketLayer)
		{
			_netEventListener = listener;
		}

		public void CreateNtpRequest(IPEndPoint endPoint)
		{
			_ntpRequests.TryAdd(endPoint, new NtpRequest(endPoint));
		}

		public void CreateNtpRequest(string ntpServerAddress, int port)
		{
			IPEndPoint iPEndPoint = NetUtils.MakeEndPoint(ntpServerAddress, port);
			_ntpRequests.TryAdd(iPEndPoint, new NtpRequest(iPEndPoint));
		}

		public void CreateNtpRequest(string ntpServerAddress)
		{
			IPEndPoint iPEndPoint = NetUtils.MakeEndPoint(ntpServerAddress, 123);
			_ntpRequests.TryAdd(iPEndPoint, new NtpRequest(iPEndPoint));
		}

		internal override bool CustomMessageHandle(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			if (_ntpRequests.Count > 0 && _ntpRequests.TryGetValue(remoteEndPoint, out var value))
			{
				if (packet.Size < 48)
				{
					return true;
				}
				byte[] array = new byte[packet.Size];
				Buffer.BlockCopy(packet.RawData, 0, array, 0, packet.Size);
				NtpPacket ntpPacket = NtpPacket.FromServerResponse(array, DateTime.UtcNow);
				try
				{
					ntpPacket.ValidateReply();
				}
				catch (InvalidOperationException)
				{
					ntpPacket = null;
				}
				if (ntpPacket != null)
				{
					_ntpRequests.TryRemove(remoteEndPoint, out value);
					_netEventListener.OnNtpResponse(ntpPacket);
				}
				return true;
			}
			return false;
		}

		protected override LiteNetPeer CreateOutgoingPeer(IPEndPoint remoteEndPoint, int id, byte connectNum, ReadOnlySpan<byte> connectData)
		{
			return new NetPeer(this, remoteEndPoint, id, connectNum, connectData);
		}

		protected override LiteNetPeer CreateIncomingPeer(ConnectionRequest request, int id)
		{
			return new NetPeer(this, request, id);
		}

		protected override LiteNetPeer CreateRejectPeer(IPEndPoint remoteEndPoint, int id)
		{
			return new NetPeer(this, remoteEndPoint, id);
		}

		protected override void ProcessEvent(NetEvent evt)
		{
			bool isNull = evt.DataReader.IsNull;
			NetPeer peer = evt.Peer as NetPeer;
			switch (evt.Type)
			{
			case NetEvent.EType.Connect:
				_netEventListener.OnPeerConnected(peer);
				break;
			case NetEvent.EType.Disconnect:
			{
				DisconnectInfo disconnectInfo = new DisconnectInfo
				{
					Reason = evt.DisconnectReason,
					AdditionalData = evt.DataReader,
					SocketErrorCode = evt.ErrorCode
				};
				_netEventListener.OnPeerDisconnected(peer, disconnectInfo);
				break;
			}
			case NetEvent.EType.Receive:
				_netEventListener.OnNetworkReceive(peer, evt.DataReader, evt.ChannelNumber, evt.DeliveryMethod);
				break;
			case NetEvent.EType.ReceiveUnconnected:
				_netEventListener.OnNetworkReceiveUnconnected(evt.RemoteEndPoint, evt.DataReader, UnconnectedMessageType.BasicMessage);
				break;
			case NetEvent.EType.Broadcast:
				_netEventListener.OnNetworkReceiveUnconnected(evt.RemoteEndPoint, evt.DataReader, UnconnectedMessageType.Broadcast);
				break;
			case NetEvent.EType.Error:
				_netEventListener.OnNetworkError(evt.RemoteEndPoint, evt.ErrorCode);
				break;
			case NetEvent.EType.ConnectionLatencyUpdated:
				_netEventListener.OnNetworkLatencyUpdate(peer, evt.Latency);
				break;
			case NetEvent.EType.ConnectionRequest:
				_netEventListener.OnConnectionRequest(evt.ConnectionRequest);
				break;
			case NetEvent.EType.MessageDelivered:
				_netEventListener.OnMessageDelivered(peer, evt.UserData);
				break;
			case NetEvent.EType.PeerAddressChanged:
			{
				_peersLock.EnterUpgradeableReadLock();
				IPEndPoint iPEndPoint = null;
				if (ContainsPeer(evt.Peer))
				{
					_peersLock.EnterWriteLock();
					RemovePeerFromSet(evt.Peer);
					iPEndPoint = new IPEndPoint(evt.Peer.Address, evt.Peer.Port);
					evt.Peer.FinishEndPointChange(evt.RemoteEndPoint);
					AddPeerToSet(evt.Peer);
					_peersLock.ExitWriteLock();
				}
				_peersLock.ExitUpgradeableReadLock();
				if (iPEndPoint != null)
				{
					_netEventListener.OnPeerAddressChanged(peer, iPEndPoint);
				}
				break;
			}
			}
			if (isNull)
			{
				RecycleEvent(evt);
			}
			else if (AutoRecycle)
			{
				evt.DataReader.RecycleInternal();
			}
		}

		protected override void ProcessNtpRequests(float elapsedMilliseconds)
		{
			if (_ntpRequests.IsEmpty)
			{
				return;
			}
			List<IPEndPoint> list = null;
			foreach (KeyValuePair<IPEndPoint, NtpRequest> ntpRequest in _ntpRequests)
			{
				ntpRequest.Value.Send(_udpSocketv4, elapsedMilliseconds);
				if (ntpRequest.Value.NeedToKill)
				{
					if (list == null)
					{
						list = new List<IPEndPoint>();
					}
					list.Add(ntpRequest.Key);
				}
			}
			if (list == null)
			{
				return;
			}
			foreach (IPEndPoint item in list)
			{
				_ntpRequests.TryRemove(item, out var _);
			}
		}

		public void SendToAll(NetDataWriter writer, byte channelNumber, DeliveryMethod options)
		{
			SendToAll(writer.Data, 0, writer.Length, channelNumber, options);
		}

		public void SendToAll(byte[] data, byte channelNumber, DeliveryMethod options)
		{
			SendToAll(data, 0, data.Length, channelNumber, options);
		}

		public void SendToAll(NetDataWriter writer, byte channelNumber, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			SendToAll(writer.Data, 0, writer.Length, channelNumber, options, excludePeer);
		}

		public void SendToAll(byte[] data, byte channelNumber, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			SendToAll(data, 0, data.Length, channelNumber, options, excludePeer);
		}

		public void SendToAll(byte[] data, int start, int length, byte channelNumber, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			try
			{
				_peersLock.EnterReadLock();
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					if (liteNetPeer != excludePeer)
					{
						((NetPeer)liteNetPeer).Send(data, start, length, channelNumber, options);
					}
				}
			}
			finally
			{
				_peersLock.ExitReadLock();
			}
		}

		public void SendToAll(byte[] data, int start, int length, byte channelNumber, DeliveryMethod options)
		{
			try
			{
				_peersLock.EnterReadLock();
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					((NetPeer)liteNetPeer).Send(data, start, length, channelNumber, options);
				}
			}
			finally
			{
				_peersLock.ExitReadLock();
			}
		}

		public new NetPeer Connect(string address, int port, string key)
		{
			return Connect(address, port, NetDataWriter.FromString(key));
		}

		public new NetPeer Connect(string address, int port, NetDataWriter connectionData)
		{
			return (NetPeer)base.Connect(address, port, connectionData);
		}

		public new NetPeer Connect(IPEndPoint target, string key)
		{
			return (NetPeer)base.Connect(target, key);
		}

		public new NetPeer Connect(IPEndPoint target, NetDataWriter connectionData)
		{
			return (NetPeer)base.Connect(target, connectionData);
		}

		public new NetPeer Connect(IPEndPoint target, ReadOnlySpan<byte> connectionData)
		{
			return (NetPeer)base.Connect(target, connectionData);
		}

		public new NetPeerEnumerator<NetPeer> GetEnumerator()
		{
			return new NetPeerEnumerator<NetPeer>((NetPeer)_headPeer);
		}

		IEnumerator<NetPeer> IEnumerable<NetPeer>.GetEnumerator()
		{
			return new NetPeerEnumerator<NetPeer>((NetPeer)_headPeer);
		}
	}
}
