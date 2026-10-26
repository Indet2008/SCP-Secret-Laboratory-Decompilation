using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Threading;
using LiteNetLib.Layers;
using LiteNetLib.Utils;
using Org.BouncyCastle.Security;
using Steam;

namespace LiteNetLib
{
	public class LiteNetManager : IEnumerable<LiteNetPeer>, IEnumerable
	{
		public struct NetPeerEnumerator<T> : IEnumerator<T>, IEnumerator, IDisposable where T : LiteNetPeer
		{
			private readonly T _initialPeer;

			private T _p;

			public T Current => _p;

			object IEnumerator.Current => _p;

			public NetPeerEnumerator(T p)
			{
				_initialPeer = p;
				_p = null;
			}

			public void Dispose()
			{
			}

			public bool MoveNext()
			{
				_p = ((_p == null) ? _initialPeer : ((T)_p.NextPeer));
				return _p != null;
			}

			public void Reset()
			{
				throw new NotSupportedException();
			}
		}

		private struct IncomingData
		{
			public NetPacket Data;

			public IPEndPoint EndPoint;

			public DateTime TimeWhenGet;
		}

		private struct ChallengeInfo
		{
			public uint Challenge;

			public long Timestamp;
		}

		private struct Slot
		{
			internal int HashCode;

			internal int Next;

			internal LiteNetPeer Value;
		}

		private readonly List<IncomingData> _pingSimulationList = new List<IncomingData>();

		private readonly Random _randomGenerator = new Random();

		private const int MinLatencyThreshold = 5;

		private Thread _logicThread;

		private bool _manualMode;

		private readonly AutoResetEvent _updateTriggerEvent = new AutoResetEvent(initialState: true);

		private NetEvent _pendingEventHead;

		private NetEvent _pendingEventTail;

		private NetEvent _netEventPoolHead;

		private readonly ILiteNetEventListener _netEventListener;

		private readonly Dictionary<IPEndPoint, ConnectionRequest> _requestsDict = new Dictionary<IPEndPoint, ConnectionRequest>();

		private long _connectedPeersCount;

		private readonly PacketLayerBase _extraPacketLayer;

		private int _lastPeerId;

		private ConcurrentQueue<int> _peerIds = new ConcurrentQueue<int>();

		private readonly object _eventLock = new object();

		private volatile bool _isRunning;

		private readonly SecureRandom _random = new SecureRandom();

		private readonly Dictionary<IPEndPoint, ChallengeInfo> _challenges = new Dictionary<IPEndPoint, ChallengeInfo>();

		private const byte A2SInfoHeader = 84;

		private const byte S2CChallengePacket = 65;

		private bool _dropPacket;

		public bool UnconnectedMessagesEnabled;

		public bool NatPunchEnabled;

		public int UpdateTime = 15;

		public int PingInterval = 1000;

		public int DisconnectTimeout = 5000;

		public bool SimulatePacketLoss;

		public bool SimulateLatency;

		public int SimulationPacketLossChance = 10;

		public int SimulationMinLatency = 30;

		public int SimulationMaxLatency = 100;

		public bool UnsyncedEvents;

		public bool UnsyncedReceiveEvent;

		public bool UnsyncedDeliveryEvent;

		public bool BroadcastReceiveEnabled;

		public int ReconnectDelay = 500;

		public int MaxConnectAttempts = 10;

		public bool ReuseAddress;

		public bool DontRoute;

		public readonly NetStatistics Statistics = new NetStatistics();

		public bool EnableStatistics;

		public ushort MaxFragmentsCount = ushort.MaxValue;

		private readonly Lazy<NatPunchModule> _natPunchModule;

		public bool AutoRecycle;

		public bool IPv6Enabled = true;

		public int MtuOverride;

		public bool MtuDiscovery;

		public bool UseNativeSockets;

		public bool DisconnectOnUnreachable;

		public bool AllowPeerAddressChange;

		private const int MaxPrimeArrayLength = 2147483587;

		private const int HashPrime = 101;

		private const int Lower31BitMask = int.MaxValue;

		private static readonly int[] Primes;

		private int[] _buckets;

		private Slot[] _slots;

		private int _count;

		private int _lastIndex;

		private int _freeList = -1;

		private LiteNetPeer[] _peersArray = new LiteNetPeer[32];

		protected readonly ReaderWriterLockSlim _peersLock = new ReaderWriterLockSlim(LockRecursionPolicy.NoRecursion);

		protected volatile LiteNetPeer _headPeer;

		private NetPacket _poolHead;

		private int _poolCount;

		private readonly object _poolLock = new object();

		public int PacketPoolSize = 1000;

		protected Socket _udpSocketv4;

		private Socket _udpSocketv6;

		private Thread _receiveThread;

		private IPEndPoint _bufferEndPointv4;

		private IPEndPoint _bufferEndPointv6;

		private PausedSocketFix _pausedSocketFix;

		private bool _useSocketFix;

		private const int SioUdpConnreset = -1744830452;

		private static readonly IPAddress MulticastAddressV6;

		public static readonly bool IPv6Support;

		internal bool NotConnected;

		public int ReceivePollingTime = 50000;

		public NatPunchModule NatPunchModule => _natPunchModule.Value;

		public bool IsRunning => _isRunning;

		public int LocalPort { get; private set; }

		public LiteNetPeer FirstPeer => _headPeer;

		public int ConnectedPeersCount => (int)Interlocked.Read(ref _connectedPeersCount);

		public int ExtraPacketSizeForLayer => _extraPacketLayer?.ExtraPacketSizeForLayer ?? 0;

		public int PoolCount => _poolCount;

		public short Ttl
		{
			get
			{
				return _udpSocketv4.Ttl;
			}
			internal set
			{
				_udpSocketv4.Ttl = value;
			}
		}

		public LiteNetManager(ILiteNetEventListener listener, PacketLayerBase extraPacketLayer = null, bool useSocketFix = true)
		{
			_useSocketFix = useSocketFix;
			_netEventListener = listener;
			_natPunchModule = new Lazy<NatPunchModule>(() => new NatPunchModule(this));
			_extraPacketLayer = extraPacketLayer;
		}

		internal void ConnectionLatencyUpdated(LiteNetPeer fromPeer, int latency)
		{
			CreateEvent(NetEvent.EType.ConnectionLatencyUpdated, fromPeer, null, SocketError.Success, latency, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
		}

		internal void MessageDelivered(LiteNetPeer fromPeer, object userData)
		{
			CreateEvent(NetEvent.EType.MessageDelivered, fromPeer, null, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0, null, userData);
		}

		internal void DisconnectPeerForce(LiteNetPeer peer, DisconnectReason reason, SocketError socketErrorCode, NetPacket eventData)
		{
			DisconnectPeer(peer, reason, socketErrorCode, force: true, null, 0, 0, eventData);
		}

		private void DisconnectPeer(LiteNetPeer peer, DisconnectReason reason, SocketError socketErrorCode, bool force, byte[] data, int start, int count, NetPacket eventData)
		{
			switch (peer.Shutdown(data, start, count, force))
			{
			case ShutdownResult.None:
				return;
			case ShutdownResult.WasConnected:
				Interlocked.Decrement(ref _connectedPeersCount);
				break;
			}
			CreateEvent(NetEvent.EType.Disconnect, peer, null, socketErrorCode, 0, reason, null, DeliveryMethod.Unreliable, 0, eventData);
		}

		private void CreateEvent(NetEvent.EType type, LiteNetPeer peer = null, IPEndPoint remoteEndPoint = null, SocketError errorCode = SocketError.Success, int latency = 0, DisconnectReason disconnectReason = DisconnectReason.ConnectionFailed, ConnectionRequest connectionRequest = null, DeliveryMethod deliveryMethod = DeliveryMethod.Unreliable, byte channelNumber = 0, NetPacket readerSource = null, object userData = null)
		{
			bool flag = UnsyncedEvents;
			switch (type)
			{
			case NetEvent.EType.Connect:
				Interlocked.Increment(ref _connectedPeersCount);
				break;
			case NetEvent.EType.MessageDelivered:
				flag = UnsyncedDeliveryEvent;
				break;
			}
			NetEvent netEvent;
			lock (_eventLock)
			{
				netEvent = _netEventPoolHead;
				if (netEvent == null)
				{
					netEvent = new NetEvent(this);
				}
				else
				{
					_netEventPoolHead = netEvent.Next;
				}
			}
			netEvent.Next = null;
			netEvent.Type = type;
			netEvent.DataReader.SetSource(readerSource, readerSource?.HeaderSize ?? 0);
			netEvent.Peer = peer;
			netEvent.RemoteEndPoint = remoteEndPoint;
			netEvent.Latency = latency;
			netEvent.ErrorCode = errorCode;
			netEvent.DisconnectReason = disconnectReason;
			netEvent.ConnectionRequest = connectionRequest;
			netEvent.DeliveryMethod = deliveryMethod;
			netEvent.ChannelNumber = channelNumber;
			netEvent.UserData = userData;
			if (flag || _manualMode)
			{
				ProcessEvent(netEvent);
				return;
			}
			lock (_eventLock)
			{
				if (_pendingEventTail == null)
				{
					_pendingEventHead = netEvent;
				}
				else
				{
					_pendingEventTail.Next = netEvent;
				}
				_pendingEventTail = netEvent;
			}
		}

		protected virtual void ProcessEvent(NetEvent evt)
		{
			bool isNull = evt.DataReader.IsNull;
			switch (evt.Type)
			{
			case NetEvent.EType.Connect:
				_netEventListener.OnPeerConnected(evt.Peer);
				break;
			case NetEvent.EType.Disconnect:
			{
				DisconnectInfo disconnectInfo = new DisconnectInfo
				{
					Reason = evt.DisconnectReason,
					AdditionalData = evt.DataReader,
					SocketErrorCode = evt.ErrorCode
				};
				_netEventListener.OnPeerDisconnected(evt.Peer, disconnectInfo);
				break;
			}
			case NetEvent.EType.Receive:
				_netEventListener.OnNetworkReceive(evt.Peer, evt.DataReader, evt.DeliveryMethod);
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
				_netEventListener.OnNetworkLatencyUpdate(evt.Peer, evt.Latency);
				break;
			case NetEvent.EType.ConnectionRequest:
				_netEventListener.OnConnectionRequest(evt.ConnectionRequest);
				break;
			case NetEvent.EType.MessageDelivered:
				_netEventListener.OnMessageDelivered(evt.Peer, evt.UserData);
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
					_netEventListener.OnPeerAddressChanged(evt.Peer, iPEndPoint);
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

		internal void RecycleEvent(NetEvent evt)
		{
			evt.Peer = null;
			evt.ErrorCode = SocketError.Success;
			evt.RemoteEndPoint = null;
			evt.ConnectionRequest = null;
			lock (_eventLock)
			{
				evt.Next = _netEventPoolHead;
				_netEventPoolHead = evt;
			}
		}

		protected virtual void ProcessNtpRequests(float elapsedMilliseconds)
		{
		}

		private void UpdateLogic()
		{
			List<LiteNetPeer> list = new List<LiteNetPeer>();
			Stopwatch stopwatch = new Stopwatch();
			stopwatch.Start();
			while (_isRunning)
			{
				try
				{
					float num = (float)((double)stopwatch.ElapsedTicks / (double)Stopwatch.Frequency * 1000.0);
					num = ((num <= 0f) ? 0.001f : num);
					stopwatch.Restart();
					for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
					{
						if (liteNetPeer.ConnectionState == ConnectionState.Disconnected && liteNetPeer.TimeSinceLastPacket > (float)DisconnectTimeout)
						{
							list.Add(liteNetPeer);
						}
						else
						{
							liteNetPeer.Update(num);
						}
					}
					if (list.Count > 0)
					{
						_peersLock.EnterWriteLock();
						for (int i = 0; i < list.Count; i++)
						{
							RemovePeer(list[i], enableWriteLock: false);
						}
						_peersLock.ExitWriteLock();
						list.Clear();
					}
					ProcessNtpRequests(num);
					int num2 = UpdateTime - (int)stopwatch.ElapsedMilliseconds;
					if (num2 > 0)
					{
						_updateTriggerEvent.WaitOne(num2);
					}
				}
				catch (ThreadAbortException)
				{
					return;
				}
				catch (Exception ex2)
				{
					NetDebug.WriteError("[NM] LogicThread error: " + ex2);
				}
			}
			stopwatch.Stop();
		}

		[Conditional("DEBUG")]
		[Conditional("SIMULATE_NETWORK")]
		private void ProcessDelayedPackets()
		{
			if (!SimulateLatency)
			{
				return;
			}
			DateTime utcNow = DateTime.UtcNow;
			lock (_pingSimulationList)
			{
				for (int i = 0; i < _pingSimulationList.Count; i++)
				{
					IncomingData incomingData = _pingSimulationList[i];
					if (incomingData.TimeWhenGet <= utcNow)
					{
						HandleMessageReceived(incomingData.Data, incomingData.EndPoint);
						_pingSimulationList.RemoveAt(i);
						i--;
					}
				}
			}
		}

		public void ManualUpdate(float elapsedMilliseconds)
		{
			if (!_manualMode)
			{
				return;
			}
			for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
			{
				if (liteNetPeer.ConnectionState == ConnectionState.Disconnected && liteNetPeer.TimeSinceLastPacket > (float)DisconnectTimeout)
				{
					RemovePeer(liteNetPeer, enableWriteLock: false);
				}
				else
				{
					liteNetPeer.Update(elapsedMilliseconds);
				}
			}
			ProcessNtpRequests(elapsedMilliseconds);
		}

		protected virtual LiteNetPeer CreateOutgoingPeer(IPEndPoint remoteEndPoint, int id, byte connectNum, ReadOnlySpan<byte> connectData)
		{
			return new LiteNetPeer(this, remoteEndPoint, id, connectNum, connectData);
		}

		protected virtual LiteNetPeer CreateIncomingPeer(ConnectionRequest request, int id)
		{
			return new LiteNetPeer(this, request, id);
		}

		protected virtual LiteNetPeer CreateRejectPeer(IPEndPoint remoteEndPoint, int id)
		{
			return new LiteNetPeer(this, remoteEndPoint, id);
		}

		internal LiteNetPeer OnConnectionSolved(ConnectionRequest request, byte[] rejectData, int start, int length)
		{
			LiteNetPeer actualValue = null;
			if (request.Result == ConnectionRequestResult.RejectForce)
			{
				if (rejectData != null && length > 0)
				{
					NetPacket netPacket = PoolGetWithProperty(PacketProperty.Disconnect, length);
					netPacket.ConnectionNumber = request.InternalPacket.ConnectionNumber;
					FastBitConverter.GetBytes(netPacket.RawData, 1, request.InternalPacket.ConnectionTime);
					if (netPacket.Size >= NetConstants.PossibleMtu[0])
					{
						NetDebug.WriteError("[Peer] Disconnect additional data size more than MTU!");
					}
					else
					{
						Buffer.BlockCopy(rejectData, start, netPacket.RawData, 9, length);
					}
					SendRawAndRecycle(netPacket, request.RemoteEndPoint);
				}
				lock (_requestsDict)
				{
					_requestsDict.Remove(request.RemoteEndPoint);
				}
			}
			else
			{
				lock (_requestsDict)
				{
					if (!TryGetPeer(request.RemoteEndPoint, out actualValue))
					{
						if (request.Result == ConnectionRequestResult.Reject)
						{
							actualValue = CreateRejectPeer(request.RemoteEndPoint, GetNextPeerId());
							actualValue.Reject(request.InternalPacket, rejectData, start, length);
							AddPeer(actualValue);
						}
						else
						{
							actualValue = CreateIncomingPeer(request, GetNextPeerId());
							AddPeer(actualValue);
							CreateEvent(NetEvent.EType.Connect, actualValue, null, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
						}
					}
					_requestsDict.Remove(request.RemoteEndPoint);
				}
			}
			return actualValue;
		}

		private int GetNextPeerId()
		{
			if (!_peerIds.TryDequeue(out var result))
			{
				return _lastPeerId++;
			}
			return result;
		}

		private void ProcessConnectRequest(IPEndPoint remoteEndPoint, LiteNetPeer netPeer, NetConnectRequestPacket connRequest)
		{
			if (netPeer != null)
			{
				ConnectRequestResult connectRequestResult = netPeer.ProcessConnectRequest(connRequest);
				switch (connectRequestResult)
				{
				default:
					return;
				case ConnectRequestResult.Reconnection:
					DisconnectPeerForce(netPeer, DisconnectReason.Reconnect, SocketError.Success, null);
					RemovePeer(netPeer, enableWriteLock: true);
					break;
				case ConnectRequestResult.NewConnection:
					RemovePeer(netPeer, enableWriteLock: true);
					break;
				case ConnectRequestResult.P2PLose:
					DisconnectPeerForce(netPeer, DisconnectReason.PeerToPeerConnection, SocketError.Success, null);
					RemovePeer(netPeer, enableWriteLock: true);
					break;
				}
				if (connectRequestResult != ConnectRequestResult.P2PLose)
				{
					connRequest.ConnectionNumber = (byte)((netPeer.ConnectionNum + 1) % 4);
				}
			}
			ConnectionRequest value;
			lock (_requestsDict)
			{
				if (_requestsDict.TryGetValue(remoteEndPoint, out value))
				{
					value.UpdateRequest(connRequest);
					return;
				}
				value = new ConnectionRequest(remoteEndPoint, connRequest, this);
				_requestsDict.Add(remoteEndPoint, value);
			}
			CreateEvent(NetEvent.EType.ConnectionRequest, null, null, SocketError.Success, 0, DisconnectReason.ConnectionFailed, value, DeliveryMethod.Unreliable, 0);
		}

		private void OnMessageReceived(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			if (packet.Size == 0)
			{
				PoolRecycle(packet);
				return;
			}
			_dropPacket = false;
			if (!_dropPacket)
			{
				HandleMessageReceived(packet, remoteEndPoint);
			}
		}

		[Conditional("DEBUG")]
		[Conditional("SIMULATE_NETWORK")]
		private void HandleSimulateLatency(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			if (!SimulateLatency)
			{
				return;
			}
			int num = _randomGenerator.Next(SimulationMinLatency, SimulationMaxLatency) / 2;
			if (num > 5)
			{
				lock (_pingSimulationList)
				{
					_pingSimulationList.Add(new IncomingData
					{
						Data = packet,
						EndPoint = remoteEndPoint,
						TimeWhenGet = DateTime.UtcNow.AddMilliseconds(num)
					});
				}
				_dropPacket = true;
			}
		}

		[Conditional("DEBUG")]
		[Conditional("SIMULATE_NETWORK")]
		private void HandleSimulatePacketLoss()
		{
			if (SimulatePacketLoss && _randomGenerator.NextDouble() * 100.0 < (double)SimulationPacketLossChance)
			{
				_dropPacket = true;
			}
		}

		internal virtual bool CustomMessageHandle(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			return false;
		}

		private void HandleMessageReceived(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			int size = packet.Size;
			if (EnableStatistics)
			{
				Statistics.IncrementPacketsReceived();
				Statistics.AddBytesReceived(size);
			}
			if (CustomMessageHandle(packet, remoteEndPoint))
			{
				return;
			}
			if (_extraPacketLayer != null)
			{
				_extraPacketLayer.ProcessInboundPacket(ref remoteEndPoint, ref packet.RawData, ref packet.Size);
				if (packet.Size == 0)
				{
					return;
				}
			}
			if (!packet.Verify())
			{
				NetDebug.WriteError("[NM] DataReceived: bad!");
				if (packet.RawData.Length < 5 || packet.RawData[4] != 84)
				{
					NetDebug.WriteError("[NM] DataReceived: bad!");
					PoolRecycle(packet);
					return;
				}
				long num = Stopwatch.GetTimestamp() - 40000000;
				List<IPEndPoint> list = new List<IPEndPoint>();
				foreach (KeyValuePair<IPEndPoint, ChallengeInfo> challenge in _challenges)
				{
					if (challenge.Value.Timestamp < num)
					{
						list.Add(challenge.Key);
					}
				}
				foreach (IPEndPoint item in list)
				{
					_challenges.Remove(item);
				}
				if (_challenges.TryGetValue(remoteEndPoint, out var value))
				{
					int num2 = Array.IndexOf(packet.RawData, (byte)0) + 1;
					if (num2 != 0 && packet.RawData.Length >= num2 + 4 && BitConverter.ToUInt32(packet.RawData, num2) == value.Challenge)
					{
						_challenges.Remove(remoteEndPoint);
						_udpSocketv4.SendTo(SteamServerInfo.Serialize(), SocketFlags.None, remoteEndPoint);
						PoolRecycle(packet);
					}
					else
					{
						NetDebug.WriteError("[NM] DataReceived: bad! Expected Challenge was not received.");
						PoolRecycle(packet);
					}
					return;
				}
				uint num3 = (uint)_random.Next();
				_challenges[remoteEndPoint] = new ChallengeInfo
				{
					Challenge = num3,
					Timestamp = Stopwatch.GetTimestamp()
				};
				byte[] array = new byte[9];
				for (int i = 0; i < 4; i++)
				{
					array[i] = byte.MaxValue;
				}
				array[4] = 65;
				Buffer.BlockCopy(BitConverter.GetBytes(num3), 0, array, 5, 4);
				_udpSocketv4.SendTo(array, SocketFlags.None, remoteEndPoint);
				PoolRecycle(packet);
				return;
			}
			switch (packet.Property)
			{
			case PacketProperty.ConnectRequest:
				if (NetConnectRequestPacket.GetProtocolId(packet) != 13)
				{
					SendRawAndRecycle(PoolGetWithProperty(PacketProperty.InvalidProtocol), remoteEndPoint);
					return;
				}
				break;
			case PacketProperty.Broadcast:
				if (BroadcastReceiveEnabled)
				{
					CreateEvent(NetEvent.EType.Broadcast, null, remoteEndPoint, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0, packet);
				}
				return;
			case PacketProperty.UnconnectedMessage:
				if (UnconnectedMessagesEnabled)
				{
					CreateEvent(NetEvent.EType.ReceiveUnconnected, null, remoteEndPoint, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0, packet);
				}
				return;
			case PacketProperty.NatMessage:
				if (NatPunchEnabled)
				{
					NatPunchModule.ProcessMessage(remoteEndPoint, packet);
				}
				return;
			}
			LiteNetPeer actualValue = remoteEndPoint as LiteNetPeer;
			bool flag = actualValue != null || TryGetPeer(remoteEndPoint, out actualValue);
			if (flag && EnableStatistics)
			{
				actualValue.Statistics.IncrementPacketsReceived();
				actualValue.Statistics.AddBytesReceived(size);
			}
			switch (packet.Property)
			{
			case PacketProperty.ConnectRequest:
			{
				NetConnectRequestPacket netConnectRequestPacket = NetConnectRequestPacket.FromData(packet);
				if (netConnectRequestPacket != null)
				{
					ProcessConnectRequest(remoteEndPoint, actualValue, netConnectRequestPacket);
				}
				break;
			}
			case PacketProperty.PeerNotFound:
				if (flag)
				{
					if (actualValue.ConnectionState == ConnectionState.Connected)
					{
						if (packet.Size == 1)
						{
							actualValue.ResetMtu();
							SendRaw(NetConnectAcceptPacket.MakeNetworkChanged(actualValue), remoteEndPoint);
						}
						else if (packet.Size == 2 && packet.RawData[1] == 1)
						{
							DisconnectPeerForce(actualValue, DisconnectReason.PeerNotFound, SocketError.Success, null);
						}
					}
				}
				else
				{
					if (packet.Size <= 1)
					{
						break;
					}
					bool flag2 = false;
					if (AllowPeerAddressChange)
					{
						NetConnectAcceptPacket netConnectAcceptPacket = NetConnectAcceptPacket.FromData(packet);
						if (netConnectAcceptPacket != null && netConnectAcceptPacket.PeerNetworkChanged && netConnectAcceptPacket.PeerId < _peersArray.Length)
						{
							_peersLock.EnterUpgradeableReadLock();
							LiteNetPeer liteNetPeer = _peersArray[netConnectAcceptPacket.PeerId];
							_peersLock.ExitUpgradeableReadLock();
							if (liteNetPeer != null && liteNetPeer.ConnectTime == netConnectAcceptPacket.ConnectionTime && liteNetPeer.ConnectionNum == netConnectAcceptPacket.ConnectionNumber)
							{
								if (liteNetPeer.ConnectionState == ConnectionState.Connected)
								{
									liteNetPeer.InitiateEndPointChange();
									CreateEvent(NetEvent.EType.PeerAddressChanged, liteNetPeer, remoteEndPoint, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
								}
								flag2 = true;
							}
						}
					}
					PoolRecycle(packet);
					if (!flag2)
					{
						NetPacket netPacket = PoolGetWithProperty(PacketProperty.PeerNotFound, 1);
						netPacket.RawData[1] = 1;
						SendRawAndRecycle(netPacket, remoteEndPoint);
					}
				}
				break;
			case PacketProperty.InvalidProtocol:
				if (flag && actualValue.ConnectionState == ConnectionState.Outgoing)
				{
					DisconnectPeerForce(actualValue, DisconnectReason.InvalidProtocol, SocketError.Success, null);
				}
				break;
			case PacketProperty.Disconnect:
				if (flag)
				{
					DisconnectResult disconnectResult = actualValue.ProcessDisconnect(packet);
					if (disconnectResult == DisconnectResult.None)
					{
						PoolRecycle(packet);
						break;
					}
					DisconnectPeerForce(actualValue, (disconnectResult == DisconnectResult.Disconnect) ? DisconnectReason.RemoteConnectionClose : DisconnectReason.ConnectionRejected, SocketError.Success, packet);
				}
				else
				{
					PoolRecycle(packet);
				}
				SendRawAndRecycle(PoolGetWithProperty(PacketProperty.ShutdownOk), remoteEndPoint);
				break;
			case PacketProperty.ConnectAccept:
				if (flag)
				{
					NetConnectAcceptPacket netConnectAcceptPacket2 = NetConnectAcceptPacket.FromData(packet);
					if (netConnectAcceptPacket2 != null && actualValue.ProcessConnectAccept(netConnectAcceptPacket2))
					{
						CreateEvent(NetEvent.EType.Connect, actualValue, null, SocketError.Success, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
					}
				}
				break;
			default:
				if (flag)
				{
					actualValue.ProcessPacket(packet);
				}
				else
				{
					SendRawAndRecycle(PoolGetWithProperty(PacketProperty.PeerNotFound), remoteEndPoint);
				}
				break;
			}
		}

		internal void CreateReceiveEvent(NetPacket packet, DeliveryMethod method, byte channelNumber, int headerSize, LiteNetPeer fromPeer)
		{
			if (UnsyncedEvents || UnsyncedReceiveEvent || _manualMode)
			{
				NetEvent netEvent;
				lock (_eventLock)
				{
					netEvent = _netEventPoolHead;
					if (netEvent == null)
					{
						netEvent = new NetEvent(this);
					}
					else
					{
						_netEventPoolHead = netEvent.Next;
					}
				}
				netEvent.Next = null;
				netEvent.Type = NetEvent.EType.Receive;
				netEvent.DataReader.SetSource(packet, headerSize);
				netEvent.Peer = fromPeer;
				netEvent.DeliveryMethod = method;
				netEvent.ChannelNumber = channelNumber;
				ProcessEvent(netEvent);
				return;
			}
			lock (_eventLock)
			{
				NetEvent netEvent = _netEventPoolHead;
				if (netEvent == null)
				{
					netEvent = new NetEvent(this);
				}
				else
				{
					_netEventPoolHead = netEvent.Next;
				}
				netEvent.Next = null;
				netEvent.Type = NetEvent.EType.Receive;
				netEvent.DataReader.SetSource(packet, headerSize);
				netEvent.Peer = fromPeer;
				netEvent.DeliveryMethod = method;
				netEvent.ChannelNumber = channelNumber;
				if (_pendingEventTail == null)
				{
					_pendingEventHead = netEvent;
				}
				else
				{
					_pendingEventTail.Next = netEvent;
				}
				_pendingEventTail = netEvent;
			}
		}

		public void SendToAll(NetDataWriter writer, DeliveryMethod options)
		{
			SendToAll(writer.Data, 0, writer.Length, options);
		}

		public void SendToAll(byte[] data, DeliveryMethod options)
		{
			SendToAll(data, 0, data.Length, options);
		}

		public void SendToAll(byte[] data, int start, int length, DeliveryMethod options)
		{
			try
			{
				_peersLock.EnterReadLock();
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					liteNetPeer.Send(data, start, length, options);
				}
			}
			finally
			{
				_peersLock.ExitReadLock();
			}
		}

		public void SendToAll(NetDataWriter writer, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			SendToAll(writer.Data, 0, writer.Length, options, excludePeer);
		}

		public void SendToAll(byte[] data, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			SendToAll(data, 0, data.Length, options, excludePeer);
		}

		public void SendToAll(byte[] data, int start, int length, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			try
			{
				_peersLock.EnterReadLock();
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					if (liteNetPeer != excludePeer)
					{
						liteNetPeer.Send(data, start, length, options);
					}
				}
			}
			finally
			{
				_peersLock.ExitReadLock();
			}
		}

		public void SendToAll(ReadOnlySpan<byte> data, DeliveryMethod options)
		{
			SendToAll(data, options, null);
		}

		public void SendToAll(ReadOnlySpan<byte> data, DeliveryMethod options, LiteNetPeer excludePeer)
		{
			try
			{
				_peersLock.EnterReadLock();
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					if (liteNetPeer != excludePeer)
					{
						liteNetPeer.Send(data, options);
					}
				}
			}
			finally
			{
				_peersLock.ExitReadLock();
			}
		}

		public bool SendUnconnectedMessage(ReadOnlySpan<byte> message, IPEndPoint remoteEndPoint)
		{
			int headerSize = NetPacket.GetHeaderSize(PacketProperty.UnconnectedMessage);
			NetPacket netPacket = PoolGetPacket(message.Length + headerSize);
			netPacket.Property = PacketProperty.UnconnectedMessage;
			message.CopyTo(new Span<byte>(netPacket.RawData, headerSize, message.Length));
			return SendRawAndRecycle(netPacket, remoteEndPoint) > 0;
		}

		public bool Start()
		{
			return Start(0);
		}

		public bool Start(IPAddress addressIPv4, IPAddress addressIPv6, int port)
		{
			return Start(addressIPv4, addressIPv6, port, manualMode: false);
		}

		public bool Start(string addressIPv4, string addressIPv6, int port)
		{
			IPAddress addressIPv7 = NetUtils.ResolveAddress(addressIPv4);
			IPAddress addressIPv8 = NetUtils.ResolveAddress(addressIPv6);
			return Start(addressIPv7, addressIPv8, port);
		}

		public bool Start(int port)
		{
			return Start(IPAddress.Any, IPAddress.IPv6Any, port);
		}

		public bool StartInManualMode(IPAddress addressIPv4, IPAddress addressIPv6, int port)
		{
			return Start(addressIPv4, addressIPv6, port, manualMode: true);
		}

		public bool StartInManualMode(string addressIPv4, string addressIPv6, int port)
		{
			IPAddress addressIPv7 = NetUtils.ResolveAddress(addressIPv4);
			IPAddress addressIPv8 = NetUtils.ResolveAddress(addressIPv6);
			return StartInManualMode(addressIPv7, addressIPv8, port);
		}

		public bool StartInManualMode(int port)
		{
			return StartInManualMode(IPAddress.Any, IPAddress.IPv6Any, port);
		}

		public bool SendUnconnectedMessage(byte[] message, IPEndPoint remoteEndPoint)
		{
			return SendUnconnectedMessage(message, 0, message.Length, remoteEndPoint);
		}

		public bool SendUnconnectedMessage(NetDataWriter writer, string address, int port)
		{
			return SendUnconnectedMessage(writer.Data, 0, writer.Length, NetUtils.MakeEndPoint(address, port));
		}

		public bool SendUnconnectedMessage(NetDataWriter writer, IPEndPoint remoteEndPoint)
		{
			return SendUnconnectedMessage(writer.Data, 0, writer.Length, remoteEndPoint);
		}

		public bool SendUnconnectedMessage(byte[] message, int start, int length, IPEndPoint remoteEndPoint)
		{
			NetPacket packet = PoolGetWithData(PacketProperty.UnconnectedMessage, message, start, length);
			return SendRawAndRecycle(packet, remoteEndPoint) > 0;
		}

		public void TriggerUpdate()
		{
			_updateTriggerEvent.Set();
		}

		public void PollEvents()
		{
			if (_manualMode)
			{
				if (_udpSocketv4 != null)
				{
					ManualReceive(_udpSocketv4, _bufferEndPointv4);
				}
				if (_udpSocketv6 != null && _udpSocketv6 != _udpSocketv4)
				{
					ManualReceive(_udpSocketv6, _bufferEndPointv6);
				}
			}
			else if (!UnsyncedEvents)
			{
				NetEvent netEvent;
				lock (_eventLock)
				{
					netEvent = _pendingEventHead;
					_pendingEventHead = null;
					_pendingEventTail = null;
				}
				while (netEvent != null)
				{
					NetEvent next = netEvent.Next;
					ProcessEvent(netEvent);
					netEvent = next;
				}
			}
		}

		public LiteNetPeer Connect(string address, int port, string key)
		{
			return Connect(address, port, NetDataWriter.FromString(key));
		}

		public LiteNetPeer Connect(string address, int port, NetDataWriter connectionData)
		{
			IPEndPoint target;
			try
			{
				target = NetUtils.MakeEndPoint(address, port);
			}
			catch
			{
				CreateEvent(NetEvent.EType.Disconnect, null, null, SocketError.Success, 0, DisconnectReason.UnknownHost, null, DeliveryMethod.Unreliable, 0);
				return null;
			}
			return Connect(target, connectionData);
		}

		public LiteNetPeer Connect(IPEndPoint target, string key)
		{
			return Connect(target, NetDataWriter.FromString(key));
		}

		public LiteNetPeer Connect(IPEndPoint target, NetDataWriter connectionData)
		{
			if (!_isRunning)
			{
				throw new InvalidOperationException("Client is not running");
			}
			lock (_requestsDict)
			{
				if (_requestsDict.ContainsKey(target))
				{
					return null;
				}
				byte connectNum = 0;
				if (TryGetPeer(target, out var actualValue))
				{
					ConnectionState connectionState = actualValue.ConnectionState;
					if (connectionState == ConnectionState.Outgoing || connectionState == ConnectionState.Connected)
					{
						return actualValue;
					}
					connectNum = (byte)((actualValue.ConnectionNum + 1) % 4);
					RemovePeer(actualValue, enableWriteLock: true);
				}
				actualValue = CreateOutgoingPeer(target, GetNextPeerId(), connectNum, connectionData.AsReadOnlySpan());
				AddPeer(actualValue);
				return actualValue;
			}
		}

		public LiteNetPeer Connect(IPEndPoint target, ReadOnlySpan<byte> connectionData)
		{
			if (!_isRunning)
			{
				throw new InvalidOperationException("Client is not running");
			}
			lock (_requestsDict)
			{
				if (_requestsDict.ContainsKey(target))
				{
					return null;
				}
				byte connectNum = 0;
				if (TryGetPeer(target, out var actualValue))
				{
					ConnectionState connectionState = actualValue.ConnectionState;
					if (connectionState == ConnectionState.Outgoing || connectionState == ConnectionState.Connected)
					{
						return actualValue;
					}
					connectNum = (byte)((actualValue.ConnectionNum + 1) % 4);
					RemovePeer(actualValue, enableWriteLock: true);
				}
				actualValue = CreateOutgoingPeer(target, GetNextPeerId(), connectNum, connectionData);
				AddPeer(actualValue);
				return actualValue;
			}
		}

		public void Stop()
		{
			Stop(sendDisconnectMessages: true);
		}

		public void Stop(bool sendDisconnectMessages)
		{
			if (_isRunning)
			{
				for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
				{
					liteNetPeer.Shutdown(null, 0, 0, !sendDisconnectMessages);
				}
				CloseSocket();
				if (_useSocketFix)
				{
					_pausedSocketFix.Deinitialize();
					_pausedSocketFix = null;
				}
				_updateTriggerEvent.Set();
				if (!_manualMode)
				{
					_logicThread.Join();
					_logicThread = null;
				}
				ClearPeerSet();
				_peerIds = new ConcurrentQueue<int>();
				_lastPeerId = 0;
				_connectedPeersCount = 0L;
				_pendingEventHead = null;
				_pendingEventTail = null;
			}
		}

		[Conditional("DEBUG")]
		[Conditional("SIMULATE_NETWORK")]
		private void ClearPingSimulationList()
		{
			lock (_pingSimulationList)
			{
				_pingSimulationList.Clear();
			}
		}

		[Conditional("DEBUG")]
		[Conditional("SIMULATE_NETWORK")]
		private void ClearOutboundSimulationList()
		{
		}

		public int GetPeersCount(ConnectionState peerState)
		{
			int num = 0;
			_peersLock.EnterReadLock();
			for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
			{
				if ((liteNetPeer.ConnectionState & peerState) != 0)
				{
					num++;
				}
			}
			_peersLock.ExitReadLock();
			return num;
		}

		public void GetPeers(List<LiteNetPeer> peers, ConnectionState peerState)
		{
			peers.Clear();
			_peersLock.EnterReadLock();
			for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
			{
				if ((liteNetPeer.ConnectionState & peerState) != 0)
				{
					peers.Add(liteNetPeer);
				}
			}
			_peersLock.ExitReadLock();
		}

		public void GetConnectedPeers(List<LiteNetPeer> peers)
		{
			GetPeers(peers, ConnectionState.Connected);
		}

		public void DisconnectAll()
		{
			DisconnectAll(null, 0, 0);
		}

		public void DisconnectAll(byte[] data, int start, int count)
		{
			_peersLock.EnterReadLock();
			for (LiteNetPeer liteNetPeer = _headPeer; liteNetPeer != null; liteNetPeer = liteNetPeer.NextPeer)
			{
				DisconnectPeer(liteNetPeer, DisconnectReason.DisconnectPeerCalled, SocketError.Success, force: false, data, start, count, null);
			}
			_peersLock.ExitReadLock();
		}

		public void DisconnectPeerForce(LiteNetPeer peer)
		{
			DisconnectPeerForce(peer, DisconnectReason.DisconnectPeerCalled, SocketError.Success, null);
		}

		public void DisconnectPeer(LiteNetPeer peer)
		{
			DisconnectPeer(peer, null, 0, 0);
		}

		public void DisconnectPeer(LiteNetPeer peer, byte[] data)
		{
			DisconnectPeer(peer, data, 0, data.Length);
		}

		public void DisconnectPeer(LiteNetPeer peer, NetDataWriter writer)
		{
			DisconnectPeer(peer, writer.Data, 0, writer.Length);
		}

		public void DisconnectPeer(LiteNetPeer peer, byte[] data, int start, int count)
		{
			DisconnectPeer(peer, DisconnectReason.DisconnectPeerCalled, SocketError.Success, force: false, data, start, count, null);
		}

		public NetPeerEnumerator<LiteNetPeer> GetEnumerator()
		{
			return new NetPeerEnumerator<LiteNetPeer>(_headPeer);
		}

		IEnumerator<LiteNetPeer> IEnumerable<LiteNetPeer>.GetEnumerator()
		{
			return new NetPeerEnumerator<LiteNetPeer>(_headPeer);
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return new NetPeerEnumerator<LiteNetPeer>(_headPeer);
		}

		private static int HashSetGetPrime(int min)
		{
			int[] primes = Primes;
			foreach (int num in primes)
			{
				if (num >= min)
				{
					return num;
				}
			}
			for (int j = min | 1; j < int.MaxValue; j += 2)
			{
				if (IsPrime(j) && (j - 1) % 101 != 0)
				{
					return j;
				}
			}
			return min;
			static bool IsPrime(int candidate)
			{
				if ((candidate & 1) != 0)
				{
					int num2 = (int)Math.Sqrt(candidate);
					for (int k = 3; k <= num2; k += 2)
					{
						if (candidate % k == 0)
						{
							return false;
						}
					}
					return true;
				}
				return candidate == 2;
			}
		}

		private void ClearPeerSet()
		{
			_peersLock.EnterWriteLock();
			_headPeer = null;
			if (_lastIndex > 0)
			{
				Array.Clear(_slots, 0, _lastIndex);
				Array.Clear(_buckets, 0, _buckets.Length);
				_lastIndex = 0;
				_count = 0;
				_freeList = -1;
			}
			_peersArray = new LiteNetPeer[32];
			_peersLock.ExitWriteLock();
		}

		protected bool ContainsPeer(LiteNetPeer item)
		{
			if (item == null)
			{
				NetDebug.WriteError($"Contains peer null: {item}");
				return false;
			}
			if (_buckets != null)
			{
				int num = item.GetHashCode() & 0x7FFFFFFF;
				for (int num2 = _buckets[num % _buckets.Length] - 1; num2 >= 0; num2 = _slots[num2].Next)
				{
					if (_slots[num2].HashCode == num && _slots[num2].Value.Equals(item))
					{
						return true;
					}
				}
			}
			return false;
		}

		public LiteNetPeer GetPeerById(int id)
		{
			if (id < 0 || id >= _peersArray.Length)
			{
				return null;
			}
			return _peersArray[id];
		}

		public bool TryGetPeerById(int id, out LiteNetPeer peer)
		{
			peer = GetPeerById(id);
			return peer != null;
		}

		private void AddPeer(LiteNetPeer peer)
		{
			if (peer == null)
			{
				NetDebug.WriteError($"Add peer null: {peer}");
				return;
			}
			_peersLock.EnterWriteLock();
			if (_headPeer != null)
			{
				peer.NextPeer = _headPeer;
				_headPeer.PrevPeer = peer;
			}
			_headPeer = peer;
			AddPeerToSet(peer);
			if (peer.Id >= _peersArray.Length)
			{
				int num = _peersArray.Length * 2;
				while (peer.Id >= num)
				{
					num *= 2;
				}
				Array.Resize(ref _peersArray, num);
			}
			_peersArray[peer.Id] = peer;
			_peersLock.ExitWriteLock();
		}

		private void RemovePeer(LiteNetPeer peer, bool enableWriteLock)
		{
			if (enableWriteLock)
			{
				_peersLock.EnterWriteLock();
			}
			if (!RemovePeerFromSet(peer))
			{
				if (enableWriteLock)
				{
					_peersLock.ExitWriteLock();
				}
				return;
			}
			if (peer == _headPeer)
			{
				_headPeer = peer.NextPeer;
			}
			if (peer.PrevPeer != null)
			{
				peer.PrevPeer.NextPeer = peer.NextPeer;
			}
			if (peer.NextPeer != null)
			{
				peer.NextPeer.PrevPeer = peer.PrevPeer;
			}
			peer.PrevPeer = null;
			_peersArray[peer.Id] = null;
			_peerIds.Enqueue(peer.Id);
			if (enableWriteLock)
			{
				_peersLock.ExitWriteLock();
			}
		}

		protected bool RemovePeerFromSet(LiteNetPeer peer)
		{
			if (_buckets == null || peer == null)
			{
				return false;
			}
			int num = peer.GetHashCode() & 0x7FFFFFFF;
			int num2 = num % _buckets.Length;
			int num3 = -1;
			for (int num4 = _buckets[num2] - 1; num4 >= 0; num4 = _slots[num4].Next)
			{
				if (_slots[num4].HashCode == num && _slots[num4].Value.Equals(peer))
				{
					if (num3 < 0)
					{
						_buckets[num2] = _slots[num4].Next + 1;
					}
					else
					{
						_slots[num3].Next = _slots[num4].Next;
					}
					_slots[num4].HashCode = -1;
					_slots[num4].Value = null;
					_slots[num4].Next = _freeList;
					_count--;
					if (_count == 0)
					{
						_lastIndex = 0;
						_freeList = -1;
					}
					else
					{
						_freeList = num4;
					}
					return true;
				}
				num3 = num4;
			}
			return false;
		}

		private bool TryGetPeer(IPEndPoint endPoint, out LiteNetPeer actualValue)
		{
			if (_buckets != null)
			{
				int num = endPoint.GetHashCode() & 0x7FFFFFFF;
				_peersLock.EnterReadLock();
				for (int num2 = _buckets[num % _buckets.Length] - 1; num2 >= 0; num2 = _slots[num2].Next)
				{
					if (_slots[num2].HashCode == num && _slots[num2].Value.Equals(endPoint))
					{
						actualValue = _slots[num2].Value;
						_peersLock.ExitReadLock();
						return true;
					}
				}
				_peersLock.ExitReadLock();
			}
			actualValue = null;
			return false;
		}

		private bool TryGetPeer(SocketAddress saddr, out LiteNetPeer actualValue)
		{
			if (_buckets != null)
			{
				int num = saddr.GetHashCode() & 0x7FFFFFFF;
				_peersLock.EnterReadLock();
				for (int num2 = _buckets[num % _buckets.Length] - 1; num2 >= 0; num2 = _slots[num2].Next)
				{
					if (_slots[num2].HashCode == num && _slots[num2].Value.Serialize().Equals(saddr))
					{
						actualValue = _slots[num2].Value;
						_peersLock.ExitReadLock();
						return true;
					}
				}
				_peersLock.ExitReadLock();
			}
			actualValue = null;
			return false;
		}

		protected bool AddPeerToSet(LiteNetPeer value)
		{
			if (_buckets == null)
			{
				int num = HashSetGetPrime(0);
				_buckets = new int[num];
				_slots = new Slot[num];
			}
			int num2 = value.GetHashCode() & 0x7FFFFFFF;
			int num3 = num2 % _buckets.Length;
			for (int num4 = _buckets[num2 % _buckets.Length] - 1; num4 >= 0; num4 = _slots[num4].Next)
			{
				if (_slots[num4].HashCode == num2 && _slots[num4].Value.Equals(value))
				{
					return false;
				}
			}
			int num5;
			if (_freeList >= 0)
			{
				num5 = _freeList;
				_freeList = _slots[num5].Next;
			}
			else
			{
				if (_lastIndex == _slots.Length)
				{
					int num6 = 2 * _count;
					num6 = (((uint)num6 > 2147483587u && 2147483587 > _count) ? 2147483587 : HashSetGetPrime(num6));
					Slot[] array = new Slot[num6];
					Array.Copy(_slots, 0, array, 0, _lastIndex);
					_buckets = new int[num6];
					for (int i = 0; i < _lastIndex; i++)
					{
						int num7 = array[i].HashCode % num6;
						array[i].Next = _buckets[num7] - 1;
						_buckets[num7] = i + 1;
					}
					_slots = array;
					num3 = num2 % _buckets.Length;
				}
				num5 = _lastIndex;
				_lastIndex++;
			}
			_slots[num5].HashCode = num2;
			_slots[num5].Value = value;
			_slots[num5].Next = _buckets[num3] - 1;
			_buckets[num3] = num5 + 1;
			_count++;
			return true;
		}

		private NetPacket PoolGetWithData(PacketProperty property, byte[] data, int start, int length)
		{
			int headerSize = NetPacket.GetHeaderSize(property);
			NetPacket netPacket = PoolGetPacket(length + headerSize);
			netPacket.Property = property;
			Buffer.BlockCopy(data, start, netPacket.RawData, headerSize, length);
			return netPacket;
		}

		private NetPacket PoolGetWithProperty(PacketProperty property, int size)
		{
			NetPacket netPacket = PoolGetPacket(size + NetPacket.GetHeaderSize(property));
			netPacket.Property = property;
			return netPacket;
		}

		private NetPacket PoolGetWithProperty(PacketProperty property)
		{
			NetPacket netPacket = PoolGetPacket(NetPacket.GetHeaderSize(property));
			netPacket.Property = property;
			return netPacket;
		}

		internal NetPacket PoolGetPacket(int size)
		{
			if (size > NetConstants.MaxPacketSize)
			{
				return new NetPacket(size);
			}
			NetPacket poolHead;
			lock (_poolLock)
			{
				poolHead = _poolHead;
				if (poolHead == null)
				{
					return new NetPacket(size);
				}
				_poolHead = _poolHead.Next;
				_poolCount--;
			}
			poolHead.Size = size;
			if (poolHead.RawData.Length < size)
			{
				poolHead.RawData = new byte[size];
			}
			return poolHead;
		}

		internal void PoolRecycle(NetPacket packet)
		{
			if (packet.RawData.Length > NetConstants.MaxPacketSize || _poolCount >= PacketPoolSize)
			{
				return;
			}
			packet.RawData[0] = 0;
			lock (_poolLock)
			{
				packet.Next = _poolHead;
				_poolHead = packet;
				_poolCount++;
			}
		}

		static LiteNetManager()
		{
			Primes = new int[72]
			{
				3, 7, 11, 17, 23, 29, 37, 47, 59, 71,
				89, 107, 131, 163, 197, 239, 293, 353, 431, 521,
				631, 761, 919, 1103, 1327, 1597, 1931, 2333, 2801, 3371,
				4049, 4861, 5839, 7013, 8419, 10103, 12143, 14591, 17519, 21023,
				25229, 30293, 36353, 43627, 52361, 62851, 75431, 90523, 108631, 130363,
				156437, 187751, 225307, 270371, 324449, 389357, 467237, 560689, 672827, 807403,
				968897, 1162687, 1395263, 1674319, 2009191, 2411033, 2893249, 3471899, 4166287, 4999559,
				5999471, 7199369
			};
			MulticastAddressV6 = IPAddress.Parse("ff02::1");
			IPv6Support = Socket.OSSupportsIPv6;
		}

		private bool ProcessError(SocketException ex)
		{
			switch (ex.SocketErrorCode)
			{
			case SocketError.NotConnected:
				NotConnected = true;
				return true;
			case SocketError.OperationAborted:
			case SocketError.Interrupted:
			case SocketError.NotSocket:
				return true;
			default:
				NetDebug.WriteError($"[R]Error code: {(int)ex.SocketErrorCode} - {ex}");
				CreateEvent(NetEvent.EType.Error, null, null, ex.SocketErrorCode, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
				break;
			case SocketError.WouldBlock:
			case SocketError.MessageSize:
			case SocketError.NetworkReset:
			case SocketError.ConnectionReset:
			case SocketError.TimedOut:
				break;
			}
			return false;
		}

		private void ManualReceive(Socket socket, EndPoint bufferEndPoint)
		{
			try
			{
				for (int num = socket.Available; num > 0; num -= ReceiveFrom(socket, ref bufferEndPoint))
				{
				}
			}
			catch (SocketException ex)
			{
				ProcessError(ex);
			}
			catch (ObjectDisposedException)
			{
			}
			catch (Exception ex3)
			{
				NetDebug.WriteError("[NM] SocketReceiveThread error: " + ex3);
			}
		}

		private void NativeReceiveLogic()
		{
			IntPtr handle = _udpSocketv4.Handle;
			IntPtr s = _udpSocketv6?.Handle ?? IntPtr.Zero;
			byte[] address = new byte[16];
			byte[] address2 = new byte[28];
			IPEndPoint tempEndPoint = new IPEndPoint(IPAddress.Any, 0);
			List<Socket> list = new List<Socket>(2);
			Socket udpSocketv = _udpSocketv4;
			Socket udpSocketv2 = _udpSocketv6;
			NetPacket packet = PoolGetPacket(NetConstants.MaxPacketSize);
			while (_isRunning)
			{
				try
				{
					if (udpSocketv2 == null)
					{
						if (!NativeReceiveFrom(handle, address))
						{
							break;
						}
						continue;
					}
					bool flag = false;
					if (udpSocketv.Available != 0 || list.Contains(udpSocketv))
					{
						if (!NativeReceiveFrom(handle, address))
						{
							break;
						}
						flag = true;
					}
					if (udpSocketv2.Available != 0 || list.Contains(udpSocketv2))
					{
						if (!NativeReceiveFrom(s, address2))
						{
							break;
						}
						flag = true;
					}
					list.Clear();
					if (!flag)
					{
						list.Add(udpSocketv);
						list.Add(udpSocketv2);
						Socket.Select(list, null, null, ReceivePollingTime);
					}
				}
				catch (SocketException ex)
				{
					if (ProcessError(ex))
					{
						break;
					}
				}
				catch (ObjectDisposedException)
				{
					break;
				}
				catch (ThreadAbortException)
				{
					break;
				}
				catch (Exception ex4)
				{
					NetDebug.WriteError("[NM] SocketReceiveThread error: " + ex4);
				}
			}
			bool NativeReceiveFrom(IntPtr socketHandle, byte[] array)
			{
				int socketAddressSize = array.Length;
				packet.Size = NativeSocket.RecvFrom(socketHandle, packet.RawData, NetConstants.MaxPacketSize, array, ref socketAddressSize);
				if (packet.Size == 0)
				{
					return true;
				}
				if (packet.Size == -1)
				{
					return !ProcessError(new SocketException((int)NativeSocket.GetSocketError()));
				}
				short num = (short)((array[1] << 8) | array[0]);
				tempEndPoint.Port = (ushort)((array[2] << 8) | array[3]);
				if ((NativeSocket.UnixMode && num == 10) || (!NativeSocket.UnixMode && num == 23))
				{
					uint num2 = (uint)((array[27] << 24) + (array[26] << 16) + (array[25] << 8) + array[24]);
					tempEndPoint.Address = new IPAddress(new ReadOnlySpan<byte>(array, 8, 16), num2);
				}
				else
				{
					long newAddress = (uint)((array[4] & 0xFF) | ((array[5] << 8) & 0xFF00) | ((array[6] << 16) & 0xFF0000) | (array[7] << 24));
					tempEndPoint.Address = new IPAddress(newAddress);
				}
				if (TryGetPeer(tempEndPoint, out var actualValue))
				{
					OnMessageReceived(packet, actualValue);
				}
				else
				{
					OnMessageReceived(packet, tempEndPoint);
					tempEndPoint = new IPEndPoint(IPAddress.Any, 0);
				}
				packet = PoolGetPacket(NetConstants.MaxPacketSize);
				return true;
			}
		}

		private int ReceiveFrom(Socket s, ref EndPoint bufferEndPoint)
		{
			NetPacket netPacket = PoolGetPacket(NetConstants.MaxPacketSize);
			netPacket.Size = s.ReceiveFrom(netPacket.RawData, 0, NetConstants.MaxPacketSize, SocketFlags.None, ref bufferEndPoint);
			OnMessageReceived(netPacket, (IPEndPoint)bufferEndPoint);
			return netPacket.Size;
		}

		private void ReceiveLogic()
		{
			EndPoint bufferEndPoint = new IPEndPoint(IPAddress.Any, 0);
			EndPoint bufferEndPoint2 = new IPEndPoint(IPAddress.IPv6Any, 0);
			List<Socket> list = new List<Socket>(2);
			Socket udpSocketv = _udpSocketv4;
			Socket udpSocketv2 = _udpSocketv6;
			while (_isRunning)
			{
				try
				{
					if (udpSocketv2 == null)
					{
						if (udpSocketv.Available != 0 || udpSocketv.Poll(ReceivePollingTime, SelectMode.SelectRead))
						{
							ReceiveFrom(udpSocketv, ref bufferEndPoint);
						}
						continue;
					}
					bool flag = false;
					if (udpSocketv.Available != 0 || list.Contains(udpSocketv))
					{
						ReceiveFrom(udpSocketv, ref bufferEndPoint);
						flag = true;
					}
					if (udpSocketv2.Available != 0 || list.Contains(udpSocketv2))
					{
						ReceiveFrom(udpSocketv2, ref bufferEndPoint2);
						flag = true;
					}
					list.Clear();
					if (!flag)
					{
						list.Add(udpSocketv);
						list.Add(udpSocketv2);
						Socket.Select(list, null, null, ReceivePollingTime);
					}
				}
				catch (SocketException ex)
				{
					if (ProcessError(ex))
					{
						break;
					}
				}
				catch (ObjectDisposedException)
				{
					break;
				}
				catch (ThreadAbortException)
				{
					break;
				}
				catch (Exception ex4)
				{
					NetDebug.WriteError("[NM] SocketReceiveThread error: " + ex4);
				}
			}
		}

		public bool Start(IPAddress addressIPv4, IPAddress addressIPv6, int port, bool manualMode)
		{
			if (IsRunning && !NotConnected)
			{
				return false;
			}
			NotConnected = false;
			_manualMode = manualMode;
			UseNativeSockets = UseNativeSockets && NativeSocket.IsSupported;
			_udpSocketv4 = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
			if (!BindSocket(_udpSocketv4, new IPEndPoint(addressIPv4, port)))
			{
				return false;
			}
			LocalPort = ((IPEndPoint)_udpSocketv4.LocalEndPoint).Port;
			if (_useSocketFix && _pausedSocketFix == null)
			{
				_pausedSocketFix = new PausedSocketFix(this, addressIPv4, addressIPv6, port, manualMode);
			}
			_isRunning = true;
			if (_manualMode)
			{
				_bufferEndPointv4 = new IPEndPoint(IPAddress.Any, 0);
			}
			if (IPv6Support && IPv6Enabled)
			{
				_udpSocketv6 = new Socket(AddressFamily.InterNetworkV6, SocketType.Dgram, ProtocolType.Udp);
				if (BindSocket(_udpSocketv6, new IPEndPoint(addressIPv6, LocalPort)))
				{
					if (_manualMode)
					{
						_bufferEndPointv6 = new IPEndPoint(IPAddress.IPv6Any, 0);
					}
				}
				else
				{
					_udpSocketv6 = null;
				}
			}
			if (!manualMode)
			{
				ThreadStart start = ReceiveLogic;
				if (UseNativeSockets)
				{
					start = NativeReceiveLogic;
				}
				_receiveThread = new Thread(start)
				{
					Name = $"ReceiveThread({LocalPort})",
					IsBackground = true
				};
				_receiveThread.Start();
				if (_logicThread == null)
				{
					_logicThread = new Thread(UpdateLogic)
					{
						Name = "LogicThread",
						IsBackground = true
					};
					_logicThread.Start();
				}
			}
			return true;
		}

		private bool BindSocket(Socket socket, IPEndPoint ep)
		{
			socket.ReceiveTimeout = 500;
			socket.SendTimeout = 500;
			socket.ReceiveBufferSize = 1048576;
			socket.SendBufferSize = 1048576;
			socket.Blocking = true;
			if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
			{
				try
				{
					socket.IOControl(-1744830452, new byte[1], null);
				}
				catch
				{
				}
			}
			try
			{
				socket.ExclusiveAddressUse = !ReuseAddress;
				socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, ReuseAddress);
				socket.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.DontRoute, DontRoute);
			}
			catch
			{
			}
			if (ep.AddressFamily == AddressFamily.InterNetwork)
			{
				Ttl = 255;
				try
				{
					socket.EnableBroadcast = true;
				}
				catch (SocketException ex)
				{
					NetDebug.WriteError($"[B]Broadcast error: {ex.SocketErrorCode}");
				}
				if (!RuntimeInformation.IsOSPlatform(OSPlatform.OSX))
				{
					try
					{
						socket.DontFragment = true;
					}
					catch (SocketException ex2)
					{
						NetDebug.WriteError($"[B]DontFragment error: {ex2.SocketErrorCode}");
					}
				}
			}
			try
			{
				socket.Bind(ep);
				_ = ep.AddressFamily;
				_ = 23;
			}
			catch (SocketException ex3)
			{
				switch (ex3.SocketErrorCode)
				{
				case SocketError.AddressAlreadyInUse:
					if (socket.AddressFamily == AddressFamily.InterNetworkV6)
					{
						try
						{
							socket.DualMode = false;
							socket.Bind(ep);
						}
						catch (SocketException ex4)
						{
							NetDebug.WriteError($"[B]Bind exception: {ex4}, errorCode: {ex4.SocketErrorCode}");
							return false;
						}
						return true;
					}
					break;
				case SocketError.AddressFamilyNotSupported:
					return true;
				}
				NetDebug.WriteError($"[B]Bind exception: {ex3}, errorCode: {ex3.SocketErrorCode}");
				return false;
			}
			return true;
		}

		internal int SendRawAndRecycle(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			int result = SendRaw(packet.RawData, 0, packet.Size, remoteEndPoint);
			PoolRecycle(packet);
			return result;
		}

		internal int SendRaw(NetPacket packet, IPEndPoint remoteEndPoint)
		{
			return SendRaw(packet.RawData, 0, packet.Size, remoteEndPoint);
		}

		internal int SendRaw(byte[] message, int start, int length, IPEndPoint remoteEndPoint)
		{
			if (!_isRunning)
			{
				return 0;
			}
			NetPacket netPacket = null;
			if (_extraPacketLayer != null)
			{
				netPacket = PoolGetPacket(length + _extraPacketLayer.ExtraPacketSizeForLayer);
				Buffer.BlockCopy(message, start, netPacket.RawData, 0, length);
				start = 0;
				_extraPacketLayer.ProcessOutBoundPacket(ref remoteEndPoint, ref netPacket.RawData, ref start, ref length);
				message = netPacket.RawData;
			}
			return SendRawCoreWithCleanup(message, start, length, remoteEndPoint, netPacket);
		}

		private int SendRawCoreWithCleanup(byte[] message, int start, int length, IPEndPoint remoteEndPoint, NetPacket expandedPacket)
		{
			try
			{
				return SendRawCore(message, start, length, remoteEndPoint);
			}
			finally
			{
				if (expandedPacket != null)
				{
					PoolRecycle(expandedPacket);
				}
			}
		}

		internal unsafe int SendRawCore(byte[] message, int start, int length, IPEndPoint remoteEndPoint)
		{
			if (!_isRunning)
			{
				return 0;
			}
			Socket socket = _udpSocketv4;
			if (remoteEndPoint.AddressFamily == AddressFamily.InterNetworkV6 && IPv6Support)
			{
				socket = _udpSocketv6;
				if (socket == null)
				{
					return 0;
				}
			}
			int num;
			try
			{
				if (UseNativeSockets && remoteEndPoint is LiteNetPeer liteNetPeer)
				{
					fixed (byte* pinnedBuffer = &message[start])
					{
						num = NativeSocket.SendTo(socket.Handle, pinnedBuffer, length, liteNetPeer.NativeAddress, liteNetPeer.NativeAddress.Length);
					}
					if (num == -1)
					{
						throw NativeSocket.GetSocketException();
					}
				}
				else
				{
					num = socket.SendTo(message, start, length, SocketFlags.None, remoteEndPoint);
				}
			}
			catch (SocketException ex)
			{
				switch (ex.SocketErrorCode)
				{
				case SocketError.Interrupted:
				case SocketError.NoBufferSpaceAvailable:
					return 0;
				case SocketError.MessageSize:
					return 0;
				case SocketError.NetworkUnreachable:
				case SocketError.HostUnreachable:
					if (DisconnectOnUnreachable && remoteEndPoint is LiteNetPeer peer)
					{
						DisconnectPeerForce(peer, (ex.SocketErrorCode == SocketError.HostUnreachable) ? DisconnectReason.HostUnreachable : DisconnectReason.NetworkUnreachable, ex.SocketErrorCode, null);
					}
					CreateEvent(NetEvent.EType.Error, null, remoteEndPoint, ex.SocketErrorCode, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
					return -1;
				case SocketError.Shutdown:
					CreateEvent(NetEvent.EType.Error, null, remoteEndPoint, ex.SocketErrorCode, 0, DisconnectReason.ConnectionFailed, null, DeliveryMethod.Unreliable, 0);
					return -1;
				default:
					NetDebug.WriteError($"[S] {ex}");
					return -1;
				}
			}
			catch (Exception arg)
			{
				NetDebug.WriteError($"[S] {arg}");
				return 0;
			}
			if (num <= 0)
			{
				return 0;
			}
			if (EnableStatistics)
			{
				Statistics.IncrementPacketsSent();
				Statistics.AddBytesSent(length);
			}
			return num;
		}

		public bool SendBroadcast(NetDataWriter writer, int port)
		{
			return SendBroadcast(writer.Data, 0, writer.Length, port);
		}

		public bool SendBroadcast(byte[] data, int port)
		{
			return SendBroadcast(data, 0, data.Length, port);
		}

		public bool SendBroadcast(byte[] data, int start, int length, int port)
		{
			if (!IsRunning)
			{
				return false;
			}
			NetPacket netPacket;
			if (_extraPacketLayer != null)
			{
				int headerSize = NetPacket.GetHeaderSize(PacketProperty.Broadcast);
				netPacket = PoolGetPacket(headerSize + length + _extraPacketLayer.ExtraPacketSizeForLayer);
				netPacket.Property = PacketProperty.Broadcast;
				Buffer.BlockCopy(data, start, netPacket.RawData, headerSize, length);
				int offset = 0;
				int length2 = length + headerSize;
				IPEndPoint endPoint = null;
				_extraPacketLayer.ProcessOutBoundPacket(ref endPoint, ref netPacket.RawData, ref offset, ref length2);
			}
			else
			{
				netPacket = PoolGetWithData(PacketProperty.Broadcast, data, start, length);
			}
			bool flag = false;
			bool flag2 = false;
			try
			{
				flag = _udpSocketv4.SendTo(netPacket.RawData, 0, netPacket.Size, SocketFlags.None, new IPEndPoint(IPAddress.Broadcast, port)) > 0;
				if (_udpSocketv6 != null)
				{
					flag2 = _udpSocketv6.SendTo(netPacket.RawData, 0, netPacket.Size, SocketFlags.None, new IPEndPoint(MulticastAddressV6, port)) > 0;
				}
			}
			catch (SocketException ex)
			{
				if (ex.SocketErrorCode == SocketError.HostUnreachable)
				{
					return flag;
				}
				NetDebug.WriteError($"[S][MCAST] {ex}");
				return flag;
			}
			catch (Exception arg)
			{
				NetDebug.WriteError($"[S][MCAST] {arg}");
				return flag;
			}
			finally
			{
				PoolRecycle(netPacket);
			}
			return flag | flag2;
		}

		private void CloseSocket()
		{
			_isRunning = false;
			if (_receiveThread != null && _receiveThread != Thread.CurrentThread)
			{
				_receiveThread.Join();
			}
			_receiveThread = null;
			_udpSocketv4?.Close();
			_udpSocketv6?.Close();
			_udpSocketv4 = null;
			_udpSocketv6 = null;
		}
	}
}
