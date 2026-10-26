namespace Discord.Basic
{
	public class RichPresence
	{
		private readonly global::System.Collections.Generic.List<global::System.IntPtr> _buffers;

		private global::Discord.Basic.RichPresenceStruct _presence;

		public string details;

		public long endTimestamp;

		public bool instance;

		public string joinSecret;

		public string largeImageKey;

		public string largeImageText;

		public string matchSecret;

		public string partyId;

		public int partyMax;

		public int partySize;

		public string smallImageKey;

		public string smallImageText;

		public string spectateSecret;

		public long startTimestamp;

		public string state;

		internal global::Discord.Basic.RichPresenceStruct GetStruct()
		{
			return default;
		}

		private global::System.IntPtr StrToPtr(string input)
		{
			return default;
		}

		internal void FreeMem()
		{
		}

		public RichPresence()
		{
		}
	}
}
