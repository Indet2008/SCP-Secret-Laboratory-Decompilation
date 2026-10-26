using System;
using Utf8Json;

public readonly struct DiscordWebhook : IEquatable<DiscordWebhook>, IJsonSerializable
{
	public readonly string content;

	public readonly string username;

	public readonly string avatar_url;

	public readonly bool tts;

	public readonly DiscordEmbed[] embeds;

	[SerializationConstructor]
	public DiscordWebhook(string content, string username, string avatar_url, bool tts, DiscordEmbed[] embeds)
	{
		this.content = content;
		this.username = username;
		this.avatar_url = avatar_url;
		this.tts = tts;
		this.embeds = embeds;
	}

	public bool Equals(DiscordWebhook other)
	{
		if (content == other.content && username == other.username && avatar_url == other.avatar_url && tts == other.tts)
		{
			return object.Equals(embeds, other.embeds);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is DiscordWebhook other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		int num = ((((((content != null) ? content.GetHashCode() : 0) * 397) ^ ((username != null) ? username.GetHashCode() : 0)) * 397) ^ ((avatar_url != null) ? avatar_url.GetHashCode() : 0)) * 397;
		bool flag = tts;
		return ((num ^ flag.GetHashCode()) * 397) ^ ((embeds != null) ? embeds.GetHashCode() : 0);
	}

	public static bool operator ==(DiscordWebhook left, DiscordWebhook right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(DiscordWebhook left, DiscordWebhook right)
	{
		return !left.Equals(right);
	}
}
