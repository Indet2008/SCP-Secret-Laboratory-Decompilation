namespace LiteNetLib
{
	public static class NetConstants
	{
		public const int DefaultWindowSize = 64;

		public const int SocketBufferSize = 1048576;

		public const int SocketTTL = 255;

		public const int HeaderSize = 1;

		public const int ChanneledHeaderSize = 4;

		public const int FragmentHeaderSize = 6;

		public const int FragmentedHeaderTotalSize = 10;

		public const ushort MaxSequence = 32768;

		public const ushort HalfMaxSequence = 16384;

		internal const int ProtocolId = 13;

		internal const int MaxUdpHeaderSize = 68;

		internal const int ChannelTypeCount = 4;

		internal const int FragmentedChannelsCount = 2;

		internal const int MaxFragmentsInWindow = 32;

		internal static readonly int[] PossibleMtu = new int[6] { 1024, 1164, 1392, 1404, 1424, 1432 };

		public static readonly int InitialMtu = PossibleMtu[0];

		public static readonly int MaxPacketSize = PossibleMtu[PossibleMtu.Length - 1];

		public static readonly int MaxUnreliableDataSize = MaxPacketSize - 1;

		public const byte MaxConnectionNumber = 4;
	}
}
