using System;

namespace LiteNetLib
{
	internal sealed class SequencedChannel : BaseChannel
	{
		private int _localSequence;

		private ushort _remoteSequence;

		private readonly bool _reliable;

		private NetPacket _lastPacket;

		private readonly NetPacket _ackPacket;

		private bool _mustSendAck;

		private readonly byte _id;

		private long _lastPacketSendTime;

		public SequencedChannel(LiteNetPeer peer, bool reliable, byte id)
			: base(peer)
		{
			_id = id;
			_reliable = reliable;
			if (_reliable)
			{
				_ackPacket = new NetPacket(PacketProperty.Ack, 0)
				{
					ChannelId = id
				};
			}
		}

		public override bool SendNextPackets()
		{
			if (_reliable && OutgoingQueue.Count == 0)
			{
				long ticks = DateTime.UtcNow.Ticks;
				if ((float)(ticks - _lastPacketSendTime) >= Peer.ResendDelay * 10000f)
				{
					NetPacket lastPacket = _lastPacket;
					if (lastPacket != null)
					{
						_lastPacketSendTime = ticks;
						Peer.SendUserData(lastPacket);
					}
				}
			}
			else
			{
				lock (OutgoingQueue)
				{
					while (OutgoingQueue.Count > 0)
					{
						NetPacket netPacket = OutgoingQueue.Dequeue();
						_localSequence = (_localSequence + 1) % 32768;
						netPacket.Sequence = (ushort)_localSequence;
						netPacket.ChannelId = _id;
						Peer.SendUserData(netPacket);
						if (_reliable && OutgoingQueue.Count == 0)
						{
							_lastPacketSendTime = DateTime.UtcNow.Ticks;
							_lastPacket = netPacket;
						}
						else
						{
							Peer.NetManager.PoolRecycle(netPacket);
						}
					}
				}
			}
			if (_reliable && _mustSendAck)
			{
				_mustSendAck = false;
				_ackPacket.Sequence = _remoteSequence;
				Peer.SendUserData(_ackPacket);
			}
			return _lastPacket != null;
		}

		public override bool ProcessPacket(NetPacket packet)
		{
			if (packet.IsFragmented)
			{
				return false;
			}
			if (packet.Property == PacketProperty.Ack)
			{
				if (_reliable && _lastPacket != null && packet.Sequence == _lastPacket.Sequence)
				{
					_lastPacket = null;
				}
				return false;
			}
			int num = NetUtils.RelativeSequenceNumber(packet.Sequence, _remoteSequence);
			bool result = false;
			if (packet.Sequence < 32768 && num > 0)
			{
				if (Peer.NetManager.EnableStatistics)
				{
					Peer.Statistics.AddPacketLoss(num - 1);
					Peer.NetManager.Statistics.AddPacketLoss(num - 1);
				}
				_remoteSequence = packet.Sequence;
				Peer.NetManager.CreateReceiveEvent(packet, (!_reliable) ? DeliveryMethod.Sequenced : DeliveryMethod.ReliableSequenced, (byte)(packet.ChannelId / 4), 4, Peer);
				result = true;
			}
			if (_reliable)
			{
				_mustSendAck = true;
				AddToPeerChannelSendQueue();
			}
			return result;
		}
	}
}
