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
			if (userId == other.userId && username == other.username && discriminator == other.discriminator)
			{
				return avatar == other.avatar;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is global::Discord.Basic.DiscordUser other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return global::System.HashCode.Combine(userId, username, discriminator, avatar);
		}

		public static bool operator ==(global::Discord.Basic.DiscordUser left, global::Discord.Basic.DiscordUser right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(global::Discord.Basic.DiscordUser left, global::Discord.Basic.DiscordUser right)
		{
			return !left.Equals(right);
		}
	}
}
