namespace Discord.Basic
{
	[global::System.Serializable]
	public struct RichPresenceStruct : global::System.IEquatable<global::Discord.Basic.RichPresenceStruct>
	{
		public global::System.IntPtr state;

		public global::System.IntPtr details;

		public long startTimestamp;

		public long endTimestamp;

		public global::System.IntPtr largeImageKey;

		public global::System.IntPtr largeImageText;

		public global::System.IntPtr smallImageKey;

		public global::System.IntPtr smallImageText;

		public global::System.IntPtr partyId;

		public int partySize;

		public int partyMax;

		public global::System.IntPtr matchSecret;

		public global::System.IntPtr joinSecret;

		public global::System.IntPtr spectateSecret;

		public bool instance;

		public bool Equals(global::Discord.Basic.RichPresenceStruct other)
		{
			return default;
		}

		public override bool Equals(object obj)
		{
			return default;
		}

		public override int GetHashCode()
		{
			return default;
		}

		public static bool operator ==(global::Discord.Basic.RichPresenceStruct left, global::Discord.Basic.RichPresenceStruct right)
		{
			return default;
		}

		public static bool operator !=(global::Discord.Basic.RichPresenceStruct left, global::Discord.Basic.RichPresenceStruct right)
		{
			return default;
		}
	}
}
