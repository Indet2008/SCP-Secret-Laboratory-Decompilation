namespace LiteNetLib
{
	public readonly ref struct PooledPacket
	{
		internal readonly NetPacket _packet;

		internal readonly byte _channelNumber;

		public readonly int MaxUserDataSize;

		public readonly int UserDataOffset;

		public byte[] Data => _packet.RawData;

		internal PooledPacket(NetPacket packet, int maxDataSize, byte channelNumber)
		{
			_packet = packet;
			UserDataOffset = _packet.HeaderSize;
			_packet.Size = UserDataOffset;
			MaxUserDataSize = maxDataSize - UserDataOffset;
			_channelNumber = channelNumber;
		}
	}
}
