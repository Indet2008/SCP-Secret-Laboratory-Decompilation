namespace Mirror
{
	public struct ChangeOwnerMessage : global::Mirror.NetworkMessage
	{
		public uint netId;

		public bool isOwner;

		public bool isLocalPlayer;
	}
}
