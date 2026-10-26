namespace Discord.Basic
{
	[global::System.Serializable]
	public struct DiscordUser : global::System.IEquatable<global::Discord.Basic.DiscordUser>
	{
		public string userId;

		public string username;

		public string discriminator;

		public string avatar;

		public bool Equals(global::Discord.Basic.DiscordUser other)
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

		public static bool operator ==(global::Discord.Basic.DiscordUser left, global::Discord.Basic.DiscordUser right)
		{
			return default;
		}

		public static bool operator !=(global::Discord.Basic.DiscordUser left, global::Discord.Basic.DiscordUser right)
		{
			return default;
		}
	}
}
