namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPreAuthenticatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool CanJoin { get; set; }

		public string UserId { get; }

		public string IpAddress { get; }

		public long Expiration { get; }

		public CentralAuthPreauthFlags Flags { get; }

		public string Region { get; }

		public byte[]? Signature { get; }

		public global::LiteNetLib.ConnectionRequest ConnectionRequest { get; }

		public int ReaderStartPosition { get; }

		public bool IsAllowed { get; set; }

		public bool ForceReject { get; set; }

		public global::LiteNetLib.Utils.NetDataWriter? CustomReject { get; set; }

		public PlayerPreAuthenticatingEventArgs(bool canJoin, string userId, string ipAddress, long expiration, CentralAuthPreauthFlags flags, string region, byte[]? signature, global::LiteNetLib.ConnectionRequest connectionRequest, int readerStartPosition)
		{
			IsAllowed = true;
			CanJoin = canJoin;
			UserId = userId;
			IpAddress = ipAddress;
			Expiration = expiration;
			Flags = flags;
			Region = region;
			Signature = signature;
			ConnectionRequest = connectionRequest;
			ReaderStartPosition = readerStartPosition;
		}

		public void Reject(global::LiteNetLib.Utils.NetDataWriter writer, bool isForce)
		{
			CustomReject = writer;
			ForceReject = isForce;
		}

		public void RejectBanned(string reason, long expires)
		{
			CustomReject = new global::LiteNetLib.Utils.NetDataWriter();
			CustomReject.Put((byte)6);
			CustomReject.Put(expires);
			CustomReject.Put(reason ?? string.Empty);
			IsAllowed = false;
		}

		public void RejectCustom(string reason)
		{
			CustomReject = new global::LiteNetLib.Utils.NetDataWriter();
			CustomReject.Put((byte)10);
			CustomReject.Put(reason ?? string.Empty);
			IsAllowed = false;
		}

		public void RejectDelay(byte seconds)
		{
			CustomReject = new global::LiteNetLib.Utils.NetDataWriter();
			CustomReject.Put((byte)17);
			CustomReject.Put(seconds);
			IsAllowed = false;
		}

		public void RejectRedirect(ushort port)
		{
			CustomReject = new global::LiteNetLib.Utils.NetDataWriter();
			CustomReject.Put((byte)16);
			CustomReject.Put(port);
			IsAllowed = false;
		}
	}
}
