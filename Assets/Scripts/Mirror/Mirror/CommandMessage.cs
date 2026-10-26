namespace Mirror
{
	public struct CommandMessage : global::Mirror.NetworkMessage
	{
		public uint netId;

		public byte componentIndex;

		public ushort functionHash;

		public global::System.ArraySegment<byte> payload;
	}
}
