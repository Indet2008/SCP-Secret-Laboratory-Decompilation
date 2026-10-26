using System;
using Utf8Json;

public readonly struct DiscordEmbedField : IEquatable<DiscordEmbedField>, IJsonSerializable
{
	public readonly string name;

	public readonly string value;

	public readonly bool inline;

	[SerializationConstructor]
	public DiscordEmbedField(string name, string value, bool inline)
	{
		this.name = name;
		this.value = value;
		this.inline = inline;
	}

	public bool Equals(DiscordEmbedField other)
	{
		if (name == other.name && value == other.value)
		{
			return inline == other.inline;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is DiscordEmbedField other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		int num = ((((name != null) ? name.GetHashCode() : 0) * 397) ^ ((value != null) ? value.GetHashCode() : 0)) * 397;
		bool flag = inline;
		return num ^ flag.GetHashCode();
	}

	public static bool operator ==(DiscordEmbedField left, DiscordEmbedField right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(DiscordEmbedField left, DiscordEmbedField right)
	{
		return !left.Equals(right);
	}
}
