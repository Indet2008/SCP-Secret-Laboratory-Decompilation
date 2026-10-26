namespace Mirror
{
	public struct RpcMessage : global::Mirror.NetworkMessage
	{
		public uint netId;

		public byte componentIndex;

		public ushort functionHash;

		public global::System.ArraySegment<byte> payload;
	}
}
