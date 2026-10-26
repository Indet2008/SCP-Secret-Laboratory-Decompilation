using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public class LiteNetPeer : IPEndPoint
	{
		private class IncomingFragments
		{
			public NetPacket[] Fragments;

			public int ReceivedCount;

			public int TotalSize;

			public byte ChannelId;
		}

		private int _rtt;

		private int _avgRtt;

		private int _rttCount;

		private float _resendDelay = 27f;

		private float _pingSendTimer;

		private float _rttResetTimer;

		private readonly Stopwatch _pingTimer = new Stopwatch();

		private float _timeSinceLastPacket;

		private long _remoteDelta;

		private readonly object _shutdownLock = new object();

		internal volatile LiteNetPeer NextPeer;

		internal LiteNetPeer PrevPeer;

		private NetPacket[] _unreliableSecondQueue;

		private NetPacket[] _unreliableChannel;

		private int _unreliablePendingCount;

		private readonly object _unreliableChannelLock = new object();

		private int _mtu;

		private int _mtuIdx;

		private bool _finishMtu;

		private float _mtuCheckTimer;

		private int _mtuCheckAttempts;

		private const int MtuCheckDelay = 1000;

		private const int MaxMtuCheckAttempts = 4;

		private readonly object _mtuMutex = new object();

		private int _fragmentId;

		private readonly Dictionary<ushort, IncomingFragments> _holdedFragments;

		private readonly Dictionary<ushort, ushort> _deliveredFragments;

		private readonly NetPacket _mergeData;

		private int _mergePos;

		private int _mergeCount;

		private int _connectAttempts;

		private float _connectTimer;

		private long _connectTime;

		private byte _connectNum;

		private ConnectionState _connectionState;

		private NetPacket _shutdownPacket;

		private const int ShutdownDelay = 300;

		private float _shutdownTimer;

		private readonly NetPacket _pingPacket;

		private readonly NetPacket _pongPacket;

		private readonly NetPacket _connectRequestPacket;

		private readonly NetPacket _connectAcceptPacket;

		public readonly LiteNetManager NetManager;

		public readonly int Id;

		public float ResendFixedDelay = 25f;

		public float ResendRttMultiplier = 2.1f;

		public object Tag;

		public readonly NetStatistics Statistics;

		public readonly IPEndPoint EndPoint;

		private SocketAddress _cachedSocketAddr;

		private int _cachedHashCode;

		private ReliableChannel _reliableChannel;

		private ReliableChannel _reliableUnorderedChannel;

		private SequencedChannel _sequencedChannel;

		internal byte[] NativeAddress;

		internal byte ConnectionNum
		{
			get
			{
				return _connectNum;
			}
			private set
			{
				_connectNum = value;
				_mergeData.ConnectionNumber = value;
				_pingPacket.ConnectionNumber = value;
				_pongPacket.ConnectionNumber = value;
			}
		}

		public ConnectionState ConnectionState => _connectionState;

		internal long ConnectTime => _connectTime;

		public int RemoteId { get; private set; }

		public int Ping => _avgRtt / 2;

		public int RoundTripTime => _avgRtt;

		public int Mtu => _mtu;

		public long RemoteTimeDelta => _remoteDelta;

		public DateTime RemoteUtcTime => new DateTime(DateTime.UtcNow.Ticks + _remoteDelta);

		public float TimeSinceLastPacket => _timeSinceLastPacket;

		internal float ResendDelay => _resendDelay;

		protected virtual int ChannelsCount => 1;

		public override SocketAddress Serialize()
		{
			return _cachedSocketAddr;
		}

		public override int GetHashCode()
		{
			return _cachedHashCode;
		}

		internal LiteNetPeer(LiteNetManager netManager, IPEndPoint remoteEndPoint, int id)
			: base(remoteEndPoint.Address, remoteEndPoint.Port)
		{
			Id = id;
			Statistics = new NetStatistics();
			NetManager = netManager;
			_cachedSocketAddr = base.Serialize();
			if (NetManager.UseNativeSockets)
			{
				NativeAddress = new byte[_cachedSocketAddr.Size];
				for (int i = 0; i < _cachedSocketAddr.Size; i++)
				{
					NativeAddress[i] = _cachedSocketAddr[i];
				}
			}
			_cachedHashCode = base.GetHashCode();
			ResetMtu();
			_connectionState = ConnectionState.Connected;
			_mergeData = new NetPacket(PacketProperty.Merged, NetConstants.MaxPacketSize);
			_pongPacket = new NetPacket(PacketProperty.Pong, 0);
			_pingPacket = new NetPacket(PacketProperty.Ping, 0)
			{
				Sequence = 1
			};
			_unreliableSecondQueue = new NetPacket[8];
			_unreliableChannel = new NetPacket[8];
			_holdedFragments = new Dictionary<ushort, IncomingFragments>();
			_deliveredFragments = new Dictionary<ushort, ushort>();
			EndPoint = remoteEndPoint;
		}

		internal void InitiateEndPointChange()
		{
			ResetMtu();
			_connectionState = ConnectionState.EndPointChange;
		}

		internal void FinishEndPointChange(IPEndPoint newEndPoint)
		{
			if (_connectionState != ConnectionState.EndPointChange)
			{
				return;
			}
			_connectionState = ConnectionState.Connected;
			base.Address = newEndPoint.Address;
			base.Port = newEndPoint.Port;
			_cachedSocketAddr = base.Serialize();
			if (NetManager.UseNativeSockets)
			{
				NativeAddress = new byte[_cachedSocketAddr.Size];
				for (int i = 0; i < _cachedSocketAddr.Size; i++)
				{
					NativeAddress[i] = _cachedSocketAddr[i];
				}
			}
			_cachedHashCode = base.GetHashCode();
		}

		internal void ResetMtu()
		{
			_finishMtu = !NetManager.MtuDiscovery;
			if (NetManager.MtuOverride > 0)
			{
				OverrideMtu(NetManager.MtuOverride);
			}
			else
			{
				SetMtu(0);
			}
		}

		private void SetMtu(int mtuIdx)
		{
			_mtuIdx = mtuIdx;
			_mtu = NetConstants.PossibleMtu[mtuIdx] - NetManager.ExtraPacketSizeForLayer;
		}

		private void OverrideMtu(int mtuValue)
		{
			_mtu = mtuValue;
			_finishMtu = true;
		}

		public int GetPacketsCountInReliableQueue(bool ordered)
		{
			return _reliableChannel?.PacketsInQueue ?? 0;
		}

		public PooledPacket CreatePacketFromPool(DeliveryMethod deliveryMethod)
		{
			int mtu = _mtu;
			NetPacket netPacket = NetManager.PoolGetPacket(mtu);
			if (deliveryMethod == DeliveryMethod.Unreliable)
			{
				netPacket.Property = PacketProperty.Unreliable;
				return new PooledPacket(netPacket, mtu, 0);
			}
			netPacket.Property = PacketProperty.Channeled;
			return new PooledPacket(netPacket, mtu, (byte)deliveryMethod);
		}

		public void SendPooledPacket(PooledPacket packet, int userDataSize)
		{
			if (_connectionState != ConnectionState.Connected)
			{
				return;
			}
			packet._packet.Size = packet.UserDataOffset + userDataSize;
			if (packet._packet.Property == PacketProperty.Channeled)
			{
				CreateChannel(packet._channelNumber).AddToQueue(packet._packet);
				return;
			}
			lock (_unreliableChannelLock)
			{
				if (_unreliablePendingCount == _unreliableChannel.Length)
				{
					Array.Resize(ref _unreliableChannel, _unreliablePendingCount * 2);
				}
				_unreliableChannel[_unreliablePendingCount++] = packet._packet;
			}
		}

		internal virtual BaseChannel CreateChannel(byte channelNumber)
		{
			switch ((DeliveryMethod)channelNumber)
			{
			case DeliveryMethod.ReliableOrdered:
			case DeliveryMethod.ReliableSequenced:
				return _reliableChannel ?? (_reliableChannel = new ReliableChannel(this, ordered: true, 2));
			case DeliveryMethod.ReliableUnordered:
				return _reliableUnorderedChannel ?? (_reliableUnorderedChannel = new ReliableChannel(this, ordered: false, channelNumber));
			case DeliveryMethod.Sequenced:
				return _sequencedChannel ?? (_sequencedChannel = new SequencedChannel(this, reliable: true, channelNumber));
			default:
				throw new Exception("Invalid channel type");
			}
		}

		internal LiteNetPeer(LiteNetManager netManager, IPEndPoint remoteEndPoint, int id, byte connectNum, ReadOnlySpan<byte> connectData)
			: this(netManager, remoteEndPoint, id)
		{
			_connectTime = DateTime.UtcNow.Ticks;
			_connectionState = ConnectionState.Outgoing;
			ConnectionNum = connectNum;
			_connectRequestPacket = NetConnectRequestPacket.Make(connectData, remoteEndPoint.Serialize(), _connectTime, id);
			_connectRequestPacket.ConnectionNumber = connectNum;
			NetManager.SendRaw(_connectRequestPacket, this);
		}

		internal LiteNetPeer(LiteNetManager netManager, ConnectionRequest request, int id)
			: this(netManager, request.RemoteEndPoint, id)
		{
			_connectTime = request.InternalPacket.ConnectionTime;
			ConnectionNum = request.InternalPacket.ConnectionNumber;
			RemoteId = request.InternalPacket.PeerId;
			_connectAcceptPacket = NetConnectAcceptPacket.Make(_connectTime, ConnectionNum, id);
			_connectionState = ConnectionState.Connected;
			NetManager.SendRaw(_connectAcceptPacket, this);
		}

		internal void Reject(NetConnectRequestPacket requestData, byte[] data, int start, int length)
		{
			_connectTime = requestData.ConnectionTime;
			_connectNum = requestData.ConnectionNumber;
			Shutdown(data, start, length, force: false);
		}

		internal bool ProcessConnectAccept(NetConnectAcceptPacket packet)
		{
			if (_connectionState != ConnectionState.Outgoing)
			{
				return false;
			}
			if (packet.ConnectionTime != _connectTime)
			{
				return false;
			}
			ConnectionNum = packet.ConnectionNumber;
			RemoteId = packet.PeerId;
			Interlocked.Exchange(ref _timeSinceLastPacket, 0f);
			_connectionState = ConnectionState.Connected;
			return true;
		}

		public int GetMaxSinglePacketSize(DeliveryMethod options)
		{
			return _mtu - NetPacket.GetHeaderSize((options != DeliveryMethod.Unreliable) ? PacketProperty.Channeled : PacketProperty.Unreliable);
		}

		public void SendWithDeliveryEvent(byte[] data, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(new ReadOnlySpan<byte>(data, 0, data.Length), 0, deliveryMethod, userData);
		}

		public void SendWithDeliveryEvent(byte[] data, int start, int length, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(new ReadOnlySpan<byte>(data, start, length), 0, deliveryMethod, userData);
		}

		public void SendWithDeliveryEvent(NetDataWriter dataWriter, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(dataWriter.AsReadOnlySpan(), 0, deliveryMethod, userData);
		}

		public void Send(byte[] data, DeliveryMethod deliveryMethod)
		{
			SendInternal(new ReadOnlySpan<byte>(data, 0, data.Length), 0, deliveryMethod, null);
		}

		public void Send(NetDataWriter dataWriter, DeliveryMethod deliveryMethod)
		{
			SendInternal(dataWriter.AsReadOnlySpan(), 0, deliveryMethod, null);
		}

		public void Send(byte[] data, int start, int length, DeliveryMethod options)
		{
			SendInternal(new ReadOnlySpan<byte>(data, start, length), 0, options, null);
		}

		public void SendWithDeliveryEvent(ReadOnlySpan<byte> data, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(data, 0, deliveryMethod, userData);
		}

		public void Send(ReadOnlySpan<byte> data, DeliveryMethod deliveryMethod)
		{
			SendInternal(data, 0, deliveryMethod, null);
		}

		protected void SendInternal(ReadOnlySpan<byte> data, byte channelNumber, DeliveryMethod deliveryMethod, object userData)
		{
			if (_connectionState != ConnectionState.Connected || channelNumber >= ChannelsCount)
			{
				return;
			}
			BaseChannel baseChannel = null;
			PacketProperty property;
			if (deliveryMethod == DeliveryMethod.Unreliable)
			{
				property = PacketProperty.Unreliable;
			}
			else
			{
				property = PacketProperty.Channeled;
				baseChannel = CreateChannel((byte)((uint)(channelNumber * 4) + (uint)deliveryMethod));
			}
			int headerSize = NetPacket.GetHeaderSize(property);
			int mtu = _mtu;
			int num = data.Length;
			if (num + headerSize > mtu)
			{
				if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
				{
					throw new TooBigPacketException("Unreliable or ReliableSequenced packet size exceeded maximum of " + (mtu - headerSize) + " bytes, Check allowed size by GetMaxSinglePacketSize()");
				}
				int num2 = mtu - headerSize - 6;
				int num3 = num / num2 + ((num % num2 != 0) ? 1 : 0);
				if (num3 > NetManager.MaxFragmentsCount)
				{
					throw new TooBigPacketException("Data was split in " + num3 + " fragments, which exceeds " + NetManager.MaxFragmentsCount);
				}
				ushort fragmentId = (ushort)Interlocked.Increment(ref _fragmentId);
				for (ushort num4 = 0; num4 < num3; num4++)
				{
					int num5 = ((num > num2) ? num2 : num);
					NetPacket netPacket = NetManager.PoolGetPacket(headerSize + num5 + 6);
					netPacket.Property = property;
					netPacket.UserData = userData;
					netPacket.FragmentId = fragmentId;
					netPacket.FragmentPart = num4;
					netPacket.FragmentsTotal = (ushort)num3;
					netPacket.MarkFragmented();
					data.Slice(num4 * num2, num5).CopyTo(new Span<byte>(netPacket.RawData, 10, num5));
					baseChannel.AddToQueue(netPacket);
					num -= num5;
				}
				return;
			}
			NetPacket netPacket2 = NetManager.PoolGetPacket(headerSize + num);
			netPacket2.Property = property;
			data.CopyTo(new Span<byte>(netPacket2.RawData, headerSize, num));
			netPacket2.UserData = userData;
			if (baseChannel == null)
			{
				lock (_unreliableChannelLock)
				{
					if (_unreliablePendingCount == _unreliableChannel.Length)
					{
						Array.Resize(ref _unreliableChannel, _unreliablePendingCount * 2);
					}
					_unreliableChannel[_unreliablePendingCount++] = netPacket2;
					return;
				}
			}
			baseChannel.AddToQueue(netPacket2);
		}

		public void Disconnect(byte[] data)
		{
			NetManager.DisconnectPeer(this, data);
		}

		public void Disconnect(NetDataWriter writer)
		{
			NetManager.DisconnectPeer(this, writer);
		}

		public void Disconnect(byte[] data, int start, int count)
		{
			NetManager.DisconnectPeer(this, data, start, count);
		}

		public void Disconnect()
		{
			NetManager.DisconnectPeer(this);
		}

		internal DisconnectResult ProcessDisconnect(NetPacket packet)
		{
			if ((_connectionState == ConnectionState.Connected || _connectionState == ConnectionState.Outgoing) && packet.Size >= 9 && BitConverter.ToInt64(packet.RawData, 1) == _connectTime && packet.ConnectionNumber == _connectNum)
			{
				if (_connectionState != ConnectionState.Connected)
				{
					return DisconnectResult.Reject;
				}
				return DisconnectResult.Disconnect;
			}
			return DisconnectResult.None;
		}

		internal virtual void AddToReliableChannelSendQueue(BaseChannel channel)
		{
		}

		internal ShutdownResult Shutdown(byte[] data, int start, int length, bool force)
		{
			lock (_shutdownLock)
			{
				if (_connectionState == ConnectionState.Disconnected || _connectionState == ConnectionState.ShutdownRequested)
				{
					return ShutdownResult.None;
				}
				ShutdownResult result = ((_connectionState != ConnectionState.Connected) ? ShutdownResult.Success : ShutdownResult.WasConnected);
				if (force)
				{
					_connectionState = ConnectionState.Disconnected;
					return result;
				}
				Interlocked.Exchange(ref _timeSinceLastPacket, 0f);
				_shutdownPacket = new NetPacket(PacketProperty.Disconnect, length)
				{
					ConnectionNumber = _connectNum
				};
				FastBitConverter.GetBytes(_shutdownPacket.RawData, 1, _connectTime);
				if (_shutdownPacket.Size >= _mtu)
				{
					NetDebug.WriteError("[Peer] Disconnect additional data size more than MTU - 8!");
				}
				else if (data != null && length > 0)
				{
					Buffer.BlockCopy(data, start, _shutdownPacket.RawData, 9, length);
				}
				_connectionState = ConnectionState.ShutdownRequested;
				NetManager.SendRaw(_shutdownPacket, this);
				return result;
			}
		}

		private void UpdateRoundTripTime(int roundTripTime)
		{
			_rtt += roundTripTime;
			_rttCount++;
			_avgRtt = _rtt / _rttCount;
			_resendDelay = ResendFixedDelay + (float)_avgRtt * ResendRttMultiplier;
		}

		internal void AddReliablePacket(DeliveryMethod method, NetPacket p)
		{
			if (p.IsFragmented)
			{
				if (p.FragmentsTotal > NetManager.MaxFragmentsCount)
				{
					NetManager.PoolRecycle(p);
					return;
				}
				ushort fragmentId = p.FragmentId;
				byte channelId = p.ChannelId;
				if (!_holdedFragments.TryGetValue(fragmentId, out var value))
				{
					if (_holdedFragments.Count >= 32 * ChannelsCount * 2)
					{
						NetManager.PoolRecycle(p);
						return;
					}
					value = new IncomingFragments
					{
						Fragments = new NetPacket[p.FragmentsTotal],
						ChannelId = p.ChannelId
					};
					_holdedFragments.Add(fragmentId, value);
				}
				NetPacket[] fragments = value.Fragments;
				if (p.FragmentPart >= fragments.Length || fragments[p.FragmentPart] != null || p.ChannelId != value.ChannelId)
				{
					NetManager.PoolRecycle(p);
					NetDebug.WriteError("Invalid fragment packet");
					return;
				}
				fragments[p.FragmentPart] = p;
				value.ReceivedCount++;
				value.TotalSize += p.Size - 10;
				if (value.ReceivedCount != fragments.Length)
				{
					return;
				}
				NetPacket netPacket = NetManager.PoolGetPacket(value.TotalSize);
				int num = 0;
				for (int i = 0; i < value.ReceivedCount; i++)
				{
					NetPacket netPacket2 = fragments[i];
					int num2 = netPacket2.Size - 10;
					if (num + num2 > netPacket.RawData.Length)
					{
						_holdedFragments.Remove(fragmentId);
						NetDebug.WriteError($"Fragment error pos: {num + num2} >= resultPacketSize: {netPacket.RawData.Length} , totalSize: {value.TotalSize}");
						return;
					}
					if (netPacket2.Size > netPacket2.RawData.Length)
					{
						_holdedFragments.Remove(fragmentId);
						NetDebug.WriteError($"Fragment error size: {netPacket2.Size} > fragment.RawData.Length: {netPacket2.RawData.Length}");
						return;
					}
					Buffer.BlockCopy(netPacket2.RawData, 10, netPacket.RawData, num, num2);
					num += num2;
					NetManager.PoolRecycle(netPacket2);
					fragments[i] = null;
				}
				_holdedFragments.Remove(fragmentId);
				NetManager.CreateReceiveEvent(netPacket, method, (byte)(channelId / 4), 0, this);
			}
			else
			{
				NetManager.CreateReceiveEvent(p, method, (byte)(p.ChannelId / 4), 4, this);
			}
		}

		private void ProcessMtuPacket(NetPacket packet)
		{
			if (packet.Size < NetConstants.PossibleMtu[0])
			{
				return;
			}
			int num = BitConverter.ToInt32(packet.RawData, 1);
			int num2 = BitConverter.ToInt32(packet.RawData, packet.Size - 4);
			if (num != packet.Size || num != num2 || num > NetConstants.MaxPacketSize)
			{
				NetDebug.WriteError($"[MTU] Broken packet. RMTU {num}, EMTU {num2}, PSIZE {packet.Size}");
			}
			else if (packet.Property == PacketProperty.MtuCheck)
			{
				_mtuCheckAttempts = 0;
				packet.Property = PacketProperty.MtuOk;
				NetManager.SendRawAndRecycle(packet, this);
			}
			else if (num > _mtu && !_finishMtu && num == NetConstants.PossibleMtu[_mtuIdx + 1] - NetManager.ExtraPacketSizeForLayer)
			{
				lock (_mtuMutex)
				{
					SetMtu(_mtuIdx + 1);
				}
				if (_mtuIdx == NetConstants.PossibleMtu.Length - 1)
				{
					_finishMtu = true;
				}
				NetManager.PoolRecycle(packet);
			}
		}

		private void UpdateMtuLogic(float deltaTime)
		{
			if (_finishMtu)
			{
				return;
			}
			_mtuCheckTimer += deltaTime;
			if (_mtuCheckTimer < 1000f)
			{
				return;
			}
			_mtuCheckTimer = 0f;
			_mtuCheckAttempts++;
			if (_mtuCheckAttempts >= 4)
			{
				_finishMtu = true;
				return;
			}
			lock (_mtuMutex)
			{
				if (_mtuIdx < NetConstants.PossibleMtu.Length - 1)
				{
					int num = NetConstants.PossibleMtu[_mtuIdx + 1] - NetManager.ExtraPacketSizeForLayer;
					NetPacket netPacket = NetManager.PoolGetPacket(num);
					netPacket.Property = PacketProperty.MtuCheck;
					FastBitConverter.GetBytes(netPacket.RawData, 1, num);
					FastBitConverter.GetBytes(netPacket.RawData, netPacket.Size - 4, num);
					if (NetManager.SendRawAndRecycle(netPacket, this) <= 0)
					{
						_finishMtu = true;
					}
				}
			}
		}

		internal ConnectRequestResult ProcessConnectRequest(NetConnectRequestPacket connRequest)
		{
			switch (_connectionState)
			{
			case ConnectionState.Outgoing:
			{
				if (connRequest.ConnectionTime < _connectTime)
				{
					return ConnectRequestResult.P2PLose;
				}
				if (connRequest.ConnectionTime != _connectTime)
				{
					break;
				}
				byte[] targetAddress = connRequest.TargetAddress;
				for (int num = _cachedSocketAddr.Size - 1; num >= 0; num--)
				{
					byte b = _cachedSocketAddr[num];
					if (b != targetAddress[num] && b < targetAddress[num])
					{
						return ConnectRequestResult.P2PLose;
					}
				}
				break;
			}
			case ConnectionState.Connected:
				if (connRequest.ConnectionTime == _connectTime)
				{
					NetManager.SendRaw(_connectAcceptPacket, this);
				}
				else if (connRequest.ConnectionTime > _connectTime)
				{
					return ConnectRequestResult.Reconnection;
				}
				break;
			case ConnectionState.ShutdownRequested:
			case ConnectionState.Disconnected:
				if (connRequest.ConnectionTime >= _connectTime)
				{
					return ConnectRequestResult.NewConnection;
				}
				break;
			}
			return ConnectRequestResult.None;
		}

		internal virtual void ProcessChanneled(NetPacket packet)
		{
			if (packet.ChannelId >= 4 || packet.ChannelId == 3)
			{
				NetManager.PoolRecycle(packet);
			}
			else if (!CreateChannel(packet.ChannelId).ProcessPacket(packet))
			{
				NetManager.PoolRecycle(packet);
			}
		}

		internal void ProcessPacket(NetPacket packet)
		{
			if (_connectionState == ConnectionState.Outgoing || _connectionState == ConnectionState.Disconnected)
			{
				NetManager.PoolRecycle(packet);
				return;
			}
			if (packet.Property == PacketProperty.ShutdownOk)
			{
				if (_connectionState == ConnectionState.ShutdownRequested)
				{
					_connectionState = ConnectionState.Disconnected;
				}
				NetManager.PoolRecycle(packet);
				return;
			}
			if (packet.ConnectionNumber != _connectNum)
			{
				NetManager.PoolRecycle(packet);
				return;
			}
			Interlocked.Exchange(ref _timeSinceLastPacket, 0f);
			switch (packet.Property)
			{
			case PacketProperty.Merged:
			{
				int num2 = 1;
				while (num2 < packet.Size)
				{
					ushort num3 = BitConverter.ToUInt16(packet.RawData, num2);
					if (num3 == 0)
					{
						break;
					}
					num2 += 2;
					if (packet.RawData.Length - num2 < num3)
					{
						break;
					}
					NetPacket netPacket = NetManager.PoolGetPacket(num3);
					Buffer.BlockCopy(packet.RawData, num2, netPacket.RawData, 0, num3);
					netPacket.Size = num3;
					if (!netPacket.Verify())
					{
						break;
					}
					num2 += num3;
					ProcessPacket(netPacket);
				}
				NetManager.PoolRecycle(packet);
				break;
			}
			case PacketProperty.Ping:
				if (NetUtils.RelativeSequenceNumber(packet.Sequence, _pongPacket.Sequence) > 0)
				{
					FastBitConverter.GetBytes(_pongPacket.RawData, 3, DateTime.UtcNow.Ticks);
					_pongPacket.Sequence = packet.Sequence;
					NetManager.SendRaw(_pongPacket, this);
				}
				NetManager.PoolRecycle(packet);
				break;
			case PacketProperty.Pong:
				if (packet.Sequence == _pingPacket.Sequence)
				{
					_pingTimer.Stop();
					int num = (int)_pingTimer.ElapsedMilliseconds;
					_remoteDelta = BitConverter.ToInt64(packet.RawData, 3) + (long)num * 10000L / 2 - DateTime.UtcNow.Ticks;
					UpdateRoundTripTime(num);
					NetManager.ConnectionLatencyUpdated(this, num / 2);
				}
				NetManager.PoolRecycle(packet);
				break;
			case PacketProperty.Channeled:
			case PacketProperty.Ack:
			case PacketProperty.ReliableMerged:
				ProcessChanneled(packet);
				break;
			case PacketProperty.Unreliable:
				NetManager.CreateReceiveEvent(packet, DeliveryMethod.Unreliable, 0, 1, this);
				break;
			case PacketProperty.MtuCheck:
			case PacketProperty.MtuOk:
				ProcessMtuPacket(packet);
				break;
			default:
				NetDebug.WriteError("Error! Unexpected packet type: " + packet.Property);
				break;
			}
		}

		private void SendMerged()
		{
			if (_mergeCount != 0)
			{
				int num = ((_mergeCount <= 1) ? NetManager.SendRaw(_mergeData.RawData, 3, _mergePos - 2, this) : NetManager.SendRaw(_mergeData.RawData, 0, 1 + _mergePos, this));
				if (NetManager.EnableStatistics)
				{
					Statistics.IncrementPacketsSent();
					Statistics.AddBytesSent(num);
				}
				_mergePos = 0;
				_mergeCount = 0;
			}
		}

		internal void SendUserData(NetPacket packet)
		{
			packet.ConnectionNumber = _connectNum;
			int num = 1 + packet.Size + 2;
			if (num + 20 >= _mtu)
			{
				int num2 = NetManager.SendRaw(packet, this);
				if (NetManager.EnableStatistics)
				{
					Statistics.IncrementPacketsSent();
					Statistics.AddBytesSent(num2);
				}
				return;
			}
			if (_mergePos + num > _mtu)
			{
				SendMerged();
			}
			FastBitConverter.GetBytes(_mergeData.RawData, _mergePos + 1, (ushort)packet.Size);
			Buffer.BlockCopy(packet.RawData, 0, _mergeData.RawData, _mergePos + 1 + 2, packet.Size);
			_mergePos += packet.Size + 2;
			_mergeCount++;
		}

		protected virtual void UpdateChannels()
		{
			_reliableChannel?.SendNextPackets();
			_reliableUnorderedChannel?.SendNextPackets();
			_sequencedChannel?.SendNextPackets();
		}

		internal void Update(float deltaTime)
		{
			Interlocked.Exchange(ref _timeSinceLastPacket, _timeSinceLastPacket + deltaTime);
			switch (_connectionState)
			{
			case ConnectionState.Connected:
				if (_timeSinceLastPacket > (float)NetManager.DisconnectTimeout)
				{
					NetManager.DisconnectPeerForce(this, DisconnectReason.Timeout, SocketError.Success, null);
					return;
				}
				break;
			case ConnectionState.ShutdownRequested:
				if (_timeSinceLastPacket > (float)NetManager.DisconnectTimeout)
				{
					_connectionState = ConnectionState.Disconnected;
					return;
				}
				_shutdownTimer += deltaTime;
				if (_shutdownTimer >= 300f)
				{
					_shutdownTimer = 0f;
					NetManager.SendRaw(_shutdownPacket, this);
				}
				return;
			case ConnectionState.Outgoing:
				_connectTimer += deltaTime;
				if (_connectTimer > (float)NetManager.ReconnectDelay)
				{
					_connectTimer = 0f;
					_connectAttempts++;
					if (_connectAttempts > NetManager.MaxConnectAttempts)
					{
						NetManager.DisconnectPeerForce(this, DisconnectReason.ConnectionFailed, SocketError.Success, null);
					}
					else
					{
						NetManager.SendRaw(_connectRequestPacket, this);
					}
				}
				return;
			case ConnectionState.Disconnected:
				return;
			}
			_pingSendTimer += deltaTime;
			if (_pingSendTimer >= (float)NetManager.PingInterval)
			{
				_pingSendTimer = 0f;
				_pingPacket.Sequence++;
				if (_pingTimer.IsRunning)
				{
					UpdateRoundTripTime((int)_pingTimer.ElapsedMilliseconds);
				}
				_pingTimer.Restart();
				NetManager.SendRaw(_pingPacket, this);
			}
			_rttResetTimer += deltaTime;
			if (_rttResetTimer >= (float)(NetManager.PingInterval * 3))
			{
				_rttResetTimer = 0f;
				_rtt = _avgRtt;
				_rttCount = 1;
			}
			UpdateMtuLogic(deltaTime);
			UpdateChannels();
			if (_unreliablePendingCount > 0)
			{
				int unreliablePendingCount;
				lock (_unreliableChannelLock)
				{
					NetPacket[] unreliableSecondQueue = _unreliableSecondQueue;
					NetPacket[] unreliableChannel = _unreliableChannel;
					_unreliableChannel = unreliableSecondQueue;
					_unreliableSecondQueue = unreliableChannel;
					unreliablePendingCount = _unreliablePendingCount;
					_unreliablePendingCount = 0;
				}
				for (int i = 0; i < unreliablePendingCount; i++)
				{
					NetPacket packet = _unreliableSecondQueue[i];
					SendUserData(packet);
					NetManager.PoolRecycle(packet);
				}
			}
			SendMerged();
		}

		internal void RecycleAndDeliver(NetPacket packet)
		{
			if (packet.UserData is MergedPacketUserData mergedPacketUserData)
			{
				for (int i = 0; i < mergedPacketUserData.Items.Length; i++)
				{
					NetManager.MessageDelivered(this, mergedPacketUserData.Items[i]);
				}
				packet.UserData = null;
			}
			else if (packet.UserData != null)
			{
				if (packet.IsFragmented)
				{
					_deliveredFragments.TryGetValue(packet.FragmentId, out var value);
					value++;
					if (value == packet.FragmentsTotal)
					{
						NetManager.MessageDelivered(this, packet.UserData);
						_deliveredFragments.Remove(packet.FragmentId);
					}
					else
					{
						_deliveredFragments[packet.FragmentId] = value;
					}
				}
				else
				{
					NetManager.MessageDelivered(this, packet.UserData);
				}
				packet.UserData = null;
			}
			NetManager.PoolRecycle(packet);
		}
	}
}
