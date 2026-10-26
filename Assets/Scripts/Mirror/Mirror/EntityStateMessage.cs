namespace Mirror
{
	public struct EntityStateMessage : global::Mirror.NetworkMessage
	{
		public uint netId;

		public global::System.ArraySegment<byte> payload;
	}
}
