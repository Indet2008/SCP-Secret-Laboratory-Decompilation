namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPreAuthenticatedEventArgs : global::System.EventArgs
	{
		public string UserId { get; }

		public string IpAddress { get; }

		public long Expiration { get; }

		public CentralAuthPreauthFlags Flags { get; }

		public string Region { get; }

		public byte[]? Signature { get; }

		public global::LiteNetLib.ConnectionRequest ConnectionRequest { get; }

		public int ReaderStartPosition { get; }

		public PlayerPreAuthenticatedEventArgs(string userId, string ipAddress, long expiration, CentralAuthPreauthFlags flags, string region, byte[]? signature, global::LiteNetLib.ConnectionRequest connectionRequest, int readerStartPosition)
		{
			UserId = userId;
			IpAddress = ipAddress;
			Expiration = expiration;
			Flags = flags;
			Region = region;
			Signature = signature;
			ConnectionRequest = connectionRequest;
			ReaderStartPosition = readerStartPosition;
		}
	}
}
