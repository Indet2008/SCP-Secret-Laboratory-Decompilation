using System;
using System.Collections.Concurrent;
using System.Net;
using System.Threading;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public class NetPeer : LiteNetPeer
	{
		private readonly ConcurrentQueue<BaseChannel> _channelSendQueue = new ConcurrentQueue<BaseChannel>();

		private readonly BaseChannel[] _channels;

		protected override int ChannelsCount => ((NetManager)NetManager).ChannelsCount;

		internal NetPeer(NetManager netManager, IPEndPoint remoteEndPoint, int id)
			: base(netManager, remoteEndPoint, id)
		{
		}

		internal NetPeer(NetManager netManager, IPEndPoint remoteEndPoint, int id, byte connectNum, ReadOnlySpan<byte> connectData)
			: base(netManager, remoteEndPoint, id, connectNum, connectData)
		{
			_channels = new BaseChannel[netManager.ChannelsCount * 4];
		}

		internal NetPeer(NetManager netManager, ConnectionRequest request, int id)
			: base(netManager, request, id)
		{
			_channels = new BaseChannel[netManager.ChannelsCount * 4];
		}

		public void Send(NetDataWriter dataWriter, byte channelNumber, DeliveryMethod deliveryMethod)
		{
			SendInternal(dataWriter.AsReadOnlySpan(), channelNumber, deliveryMethod, null);
		}

		public void SendWithDeliveryEvent(byte[] data, byte channelNumber, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(new ReadOnlySpan<byte>(data, 0, data.Length), channelNumber, deliveryMethod, userData);
		}

		public void SendWithDeliveryEvent(byte[] data, int start, int length, byte channelNumber, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(new ReadOnlySpan<byte>(data, start, length), channelNumber, deliveryMethod, userData);
		}

		public void SendWithDeliveryEvent(NetDataWriter dataWriter, byte channelNumber, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(dataWriter.AsReadOnlySpan(), channelNumber, deliveryMethod, userData);
		}

		public void SendWithDeliveryEvent(ReadOnlySpan<byte> data, byte channelNumber, DeliveryMethod deliveryMethod, object userData)
		{
			if (deliveryMethod != DeliveryMethod.ReliableOrdered && deliveryMethod != DeliveryMethod.ReliableUnordered)
			{
				throw new ArgumentException("Delivery event will work only for ReliableOrdered/Unordered packets");
			}
			SendInternal(data, channelNumber, deliveryMethod, userData);
		}

		public PooledPacket CreatePacketFromPool(DeliveryMethod deliveryMethod, byte channelNumber)
		{
			int mtu = base.Mtu;
			NetPacket netPacket = NetManager.PoolGetPacket(mtu);
			if (deliveryMethod == DeliveryMethod.Unreliable)
			{
				netPacket.Property = PacketProperty.Unreliable;
				return new PooledPacket(netPacket, mtu, 0);
			}
			netPacket.Property = PacketProperty.Channeled;
			return new PooledPacket(netPacket, mtu, (byte)((uint)(channelNumber * 4) + (uint)deliveryMethod));
		}

		public void Send(byte[] data, byte channelNumber, DeliveryMethod deliveryMethod)
		{
			SendInternal(new ReadOnlySpan<byte>(data, 0, data.Length), channelNumber, deliveryMethod, null);
		}

		public void Send(ReadOnlySpan<byte> data, byte channelNumber, DeliveryMethod deliveryMethod)
		{
			SendInternal(data, channelNumber, deliveryMethod, null);
		}

		public void Send(byte[] data, int start, int length, byte channelNumber, DeliveryMethod deliveryMethod)
		{
			SendInternal(new ReadOnlySpan<byte>(data, start, length), channelNumber, deliveryMethod, null);
		}

		public int GetPacketsCountInReliableQueue(byte channelNumber, bool ordered)
		{
			int num = channelNumber * 4 + (ordered ? 2 : 0);
			return ((ReliableChannel)_channels[num])?.PacketsInQueue ?? 0;
		}

		protected override void UpdateChannels()
		{
			if (_channelSendQueue.IsEmpty)
			{
				return;
			}
			int count = _channelSendQueue.Count;
			BaseChannel result;
			while (count-- > 0 && _channelSendQueue.TryDequeue(out result))
			{
				if (result.SendAndCheckQueue())
				{
					_channelSendQueue.Enqueue(result);
				}
			}
		}

		internal override void ProcessChanneled(NetPacket packet)
		{
			if (packet.ChannelId >= _channels.Length)
			{
				NetManager.PoolRecycle(packet);
				return;
			}
			BaseChannel baseChannel = _channels[packet.ChannelId] ?? ((packet.Property == PacketProperty.Ack) ? null : CreateChannel(packet.ChannelId));
			if (baseChannel != null && !baseChannel.ProcessPacket(packet))
			{
				NetManager.PoolRecycle(packet);
			}
		}

		internal override void AddToReliableChannelSendQueue(BaseChannel channel)
		{
			_channelSendQueue.Enqueue(channel);
		}

		internal override BaseChannel CreateChannel(byte idx)
		{
			BaseChannel baseChannel = _channels[idx];
			if (baseChannel != null)
			{
				return baseChannel;
			}
			switch ((DeliveryMethod)(byte)(idx % 4))
			{
			case DeliveryMethod.ReliableUnordered:
				baseChannel = new ReliableChannel(this, ordered: false, idx);
				break;
			case DeliveryMethod.Sequenced:
				baseChannel = new SequencedChannel(this, reliable: false, idx);
				break;
			case DeliveryMethod.ReliableOrdered:
				baseChannel = new ReliableChannel(this, ordered: true, idx);
				break;
			case DeliveryMethod.ReliableSequenced:
				baseChannel = new SequencedChannel(this, reliable: true, idx);
				break;
			}
			BaseChannel baseChannel2 = Interlocked.CompareExchange(ref _channels[idx], baseChannel, null);
			if (baseChannel2 != null)
			{
				return baseChannel2;
			}
			return baseChannel;
		}
	}
}
