using System;
using Utf8Json;

public readonly struct DiscordEmbed : IEquatable<DiscordEmbed>, IJsonSerializable
{
	public readonly string title;

	public readonly string type;

	public readonly string description;

	public readonly int color;

	public readonly DiscordEmbedField[] fields;

	[SerializationConstructor]
	public DiscordEmbed(string title, string type, string description, int color, DiscordEmbedField[] fields)
	{
		this.title = title;
		this.type = type;
		this.description = description;
		this.color = color;
		this.fields = fields;
	}

	public bool Equals(DiscordEmbed other)
	{
		if (title == other.title && type == other.type && description == other.description && color == other.color)
		{
			return object.Equals(fields, other.fields);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is DiscordEmbed other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((((((((title != null) ? title.GetHashCode() : 0) * 397) ^ ((type != null) ? type.GetHashCode() : 0)) * 397) ^ ((description != null) ? description.GetHashCode() : 0)) * 397) ^ color) * 397) ^ ((fields != null) ? fields.GetHashCode() : 0);
	}

	public static bool operator ==(DiscordEmbed left, DiscordEmbed right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(DiscordEmbed left, DiscordEmbed right)
	{
		return !left.Equals(right);
	}
}
