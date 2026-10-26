using System;
using Utf8Json;

public readonly struct CreditsListMember : IEquatable<CreditsListMember>, IJsonSerializable
{
	public readonly string name;

	public readonly string title;

	public readonly string color;

	[SerializationConstructor]
	public CreditsListMember(string name, string title, string color)
	{
		this.name = name;
		this.title = title;
		this.color = color;
	}

	public bool Equals(CreditsListMember other)
	{
		if (name == other.name && title == other.title)
		{
			return color == other.color;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is CreditsListMember other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (name == null)
		{
			return 0;
		}
		return name.GetHashCode();
	}

	public static bool operator ==(CreditsListMember left, CreditsListMember right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CreditsListMember left, CreditsListMember right)
	{
		return !left.Equals(right);
	}
}
