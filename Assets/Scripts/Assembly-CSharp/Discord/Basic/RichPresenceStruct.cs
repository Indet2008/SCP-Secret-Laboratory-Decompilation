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
			if (state == other.state && details == other.details && startTimestamp == other.startTimestamp && endTimestamp == other.endTimestamp && largeImageKey == other.largeImageKey && largeImageText == other.largeImageText && smallImageKey == other.smallImageKey && smallImageText == other.smallImageText && partyId == other.partyId && partySize == other.partySize && partyMax == other.partyMax && matchSecret == other.matchSecret && joinSecret == other.joinSecret && spectateSecret == other.spectateSecret)
			{
				return instance == other.instance;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is global::Discord.Basic.RichPresenceStruct other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((state.GetHashCode() * 397) ^ details.GetHashCode()) * 397) ^ startTimestamp.GetHashCode()) * 397) ^ endTimestamp.GetHashCode();
		}

		public static bool operator ==(global::Discord.Basic.RichPresenceStruct left, global::Discord.Basic.RichPresenceStruct right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(global::Discord.Basic.RichPresenceStruct left, global::Discord.Basic.RichPresenceStruct right)
		{
			return !left.Equals(right);
		}
	}
}
