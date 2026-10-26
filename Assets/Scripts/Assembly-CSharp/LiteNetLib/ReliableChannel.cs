using System;
using System.Collections.Generic;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	internal sealed class ReliableChannel : BaseChannel
	{
		private struct PendingPacket
		{
			private NetPacket _packet;

			private long _timeStamp;

			private bool _isSent;

			public bool IsEmpty => _packet == null;

			public override string ToString()
			{
				if (_packet != null)
				{
					return _packet.Sequence.ToString();
				}
				return "Empty";
			}

			public void Init(NetPacket packet)
			{
				_packet = packet;
				_isSent = false;
			}

			public bool TrySend(long currentTime, LiteNetPeer peer)
			{
				if (_packet == null)
				{
					return false;
				}
				if (_isSent)
				{
					double num = peer.ResendDelay * 10000f;
					if ((double)(currentTime - _timeStamp) < num)
					{
						return true;
					}
				}
				_timeStamp = currentTime;
				_isSent = true;
				peer.SendUserData(_packet);
				return true;
			}

			public bool Clear(LiteNetPeer peer)
			{
				if (_packet != null)
				{
					peer.RecycleAndDeliver(_packet);
					_packet = null;
					return true;
				}
				return false;
			}
		}

		[ThreadStatic]
		private static List<object> _mergedPacketUserDataList;

		private const int MergeHeaderSize = 2;

		private const int MergeSizeThreshold = 20;

		private readonly NetPacket _outgoingAcks;

		private readonly PendingPacket[] _pendingPackets;

		private readonly NetPacket[] _receivedPackets;

		private readonly bool[] _earlyReceived;

		private int _localSeqence;

		private int _remoteSequence;

		private int _localWindowStart;

		private int _remoteWindowStart;

		private bool _mustSendAcks;

		private readonly DeliveryMethod _deliveryMethod;

		private readonly bool _ordered;

		private readonly int _windowSize;

		private const int BitsInByte = 8;

		private readonly byte _id;

		public ReliableChannel(LiteNetPeer peer, bool ordered, byte id)
			: base(peer)
		{
			_id = id;
			_windowSize = 64;
			_ordered = ordered;
			_pendingPackets = new PendingPacket[_windowSize];
			for (int i = 0; i < _pendingPackets.Length; i++)
			{
				_pendingPackets[i] = default;
			}
			if (_ordered)
			{
				_deliveryMethod = DeliveryMethod.ReliableOrdered;
				_receivedPackets = new NetPacket[_windowSize];
			}
			else
			{
				_deliveryMethod = DeliveryMethod.ReliableUnordered;
				_earlyReceived = new bool[_windowSize];
			}
			_localWindowStart = 0;
			_localSeqence = 0;
			_remoteSequence = 0;
			_remoteWindowStart = 0;
			_outgoingAcks = new NetPacket(PacketProperty.Ack, (_windowSize - 1) / 8 + 2)
			{
				ChannelId = id
			};
		}

		private NetPacket GetNextOutgoingPacket()
		{
			int num = Peer.Mtu - 4;
			NetPacket netPacket = null;
			int num2 = 0;
			List<object> list = null;
			while (OutgoingQueue.Count > 0)
			{
				NetPacket netPacket2 = OutgoingQueue.Peek();
				if (netPacket2.IsFragmented)
				{
					break;
				}
				int num3 = netPacket2.Size - 4;
				int num4 = num2 + 2 + num3;
				if ((num4 + 20 > num && num2 > 0) || num4 > num)
				{
					break;
				}
				if (netPacket == null)
				{
					netPacket = Peer.NetManager.PoolGetPacket(Peer.Mtu);
					netPacket.Property = PacketProperty.ReliableMerged;
					list = _mergedPacketUserDataList;
					if (list == null)
					{
						list = (_mergedPacketUserDataList = new List<object>());
					}
					else
					{
						list.Clear();
					}
				}
				FastBitConverter.GetBytes(netPacket.RawData, 4 + num2, (ushort)num3);
				Buffer.BlockCopy(netPacket2.RawData, 4, netPacket.RawData, 4 + num2 + 2, num3);
				num2 += num3 + 2;
				if (netPacket2.UserData != null)
				{
					list.Add(netPacket2.UserData);
					netPacket2.UserData = null;
				}
				Peer.NetManager.PoolRecycle(OutgoingQueue.Dequeue());
			}
			if (netPacket == null)
			{
				return OutgoingQueue.Dequeue();
			}
			netPacket.Size = 4 + num2;
			if (list.Count > 0)
			{
				netPacket.UserData = new MergedPacketUserData(list.ToArray());
			}
			return netPacket;
		}

		private void ProcessIncomingPacket(NetPacket packet)
		{
			if (packet.Property == PacketProperty.ReliableMerged)
			{
				int num = 4;
				while (num + 2 <= packet.Size)
				{
					ushort num2 = BitConverter.ToUInt16(packet.RawData, num);
					num += 2;
					if (num2 == 0 || num + num2 > packet.Size)
					{
						break;
					}
					NetPacket netPacket = Peer.NetManager.PoolGetPacket(4 + num2);
					netPacket.Property = PacketProperty.Channeled;
					netPacket.ChannelId = packet.ChannelId;
					Buffer.BlockCopy(packet.RawData, num, netPacket.RawData, 4, num2);
					num += num2;
					Peer.AddReliablePacket(_deliveryMethod, netPacket);
				}
				Peer.NetManager.PoolRecycle(packet);
			}
			else
			{
				Peer.AddReliablePacket(_deliveryMethod, packet);
			}
		}

		private void ProcessAck(NetPacket packet)
		{
			if (packet.Size != _outgoingAcks.Size)
			{
				return;
			}
			ushort sequence = packet.Sequence;
			int num = NetUtils.RelativeSequenceNumber(_localWindowStart, sequence);
			if (sequence >= 32768 || num < 0 || num >= _windowSize)
			{
				return;
			}
			byte[] rawData = packet.RawData;
			lock (_pendingPackets)
			{
				int num2 = _localWindowStart;
				while (num2 != _localSeqence && NetUtils.RelativeSequenceNumber(num2, sequence) < _windowSize)
				{
					int num3 = num2 % _windowSize;
					int num4 = 4 + num3 / 8;
					int num5 = num3 % 8;
					if ((rawData[num4] & (1 << num5)) == 0)
					{
						if (Peer.NetManager.EnableStatistics && !_pendingPackets[num3].IsEmpty)
						{
							Peer.Statistics.IncrementPacketLoss();
							Peer.NetManager.Statistics.IncrementPacketLoss();
						}
					}
					else
					{
						if (num2 == _localWindowStart)
						{
							_localWindowStart = (_localWindowStart + 1) % 32768;
						}
						_pendingPackets[num3].Clear(Peer);
					}
					num2 = (num2 + 1) % 32768;
				}
			}
		}

		public override bool SendNextPackets()
		{
			if (_mustSendAcks)
			{
				_mustSendAcks = false;
				lock (_outgoingAcks)
				{
					Peer.SendUserData(_outgoingAcks);
				}
			}
			long ticks = DateTime.UtcNow.Ticks;
			bool flag = false;
			lock (_pendingPackets)
			{
				lock (OutgoingQueue)
				{
					while (OutgoingQueue.Count > 0 && NetUtils.RelativeSequenceNumber(_localSeqence, _localWindowStart) < _windowSize)
					{
						NetPacket nextOutgoingPacket = GetNextOutgoingPacket();
						nextOutgoingPacket.Sequence = (ushort)_localSeqence;
						nextOutgoingPacket.ChannelId = _id;
						_pendingPackets[_localSeqence % _windowSize].Init(nextOutgoingPacket);
						_localSeqence = (_localSeqence + 1) % 32768;
					}
				}
				for (int num = _localWindowStart; num != _localSeqence; num = (num + 1) % 32768)
				{
					if (_pendingPackets[num % _windowSize].TrySend(ticks, Peer))
					{
						flag = true;
					}
				}
			}
			if (!flag && !_mustSendAcks)
			{
				return OutgoingQueue.Count > 0;
			}
			return true;
		}

		public override bool ProcessPacket(NetPacket packet)
		{
			if (packet.Property == PacketProperty.Ack)
			{
				ProcessAck(packet);
				return false;
			}
			int sequence = packet.Sequence;
			if (sequence >= 32768)
			{
				return false;
			}
			int num = NetUtils.RelativeSequenceNumber(sequence, _remoteWindowStart);
			if (NetUtils.RelativeSequenceNumber(sequence, _remoteSequence) > _windowSize)
			{
				return false;
			}
			if (num < 0)
			{
				return false;
			}
			if (num >= _windowSize * 2)
			{
				return false;
			}
			int num3;
			lock (_outgoingAcks)
			{
				int num4;
				int num5;
				if (num >= _windowSize)
				{
					int num2 = (_remoteWindowStart + num - _windowSize + 1) % 32768;
					_outgoingAcks.Sequence = (ushort)num2;
					while (_remoteWindowStart != num2)
					{
						num3 = _remoteWindowStart % _windowSize;
						num4 = 4 + num3 / 8;
						num5 = num3 % 8;
						_outgoingAcks.RawData[num4] &= (byte)(~(1 << num5));
						_remoteWindowStart = (_remoteWindowStart + 1) % 32768;
					}
				}
				_mustSendAcks = true;
				num3 = sequence % _windowSize;
				num4 = 4 + num3 / 8;
				num5 = num3 % 8;
				if ((_outgoingAcks.RawData[num4] & (1 << num5)) != 0)
				{
					AddToPeerChannelSendQueue();
					return false;
				}
				_outgoingAcks.RawData[num4] |= (byte)(1 << num5);
			}
			AddToPeerChannelSendQueue();
			if (sequence == _remoteSequence)
			{
				ProcessIncomingPacket(packet);
				_remoteSequence = (_remoteSequence + 1) % 32768;
				if (_ordered)
				{
					NetPacket packet2;
					while ((packet2 = _receivedPackets[_remoteSequence % _windowSize]) != null)
					{
						_receivedPackets[_remoteSequence % _windowSize] = null;
						ProcessIncomingPacket(packet2);
						_remoteSequence = (_remoteSequence + 1) % 32768;
					}
				}
				else
				{
					while (_earlyReceived[_remoteSequence % _windowSize])
					{
						_earlyReceived[_remoteSequence % _windowSize] = false;
						_remoteSequence = (_remoteSequence + 1) % 32768;
					}
				}
				return true;
			}
			if (_ordered)
			{
				_receivedPackets[num3] = packet;
			}
			else
			{
				_earlyReceived[num3] = true;
				ProcessIncomingPacket(packet);
			}
			return true;
		}
	}
}
