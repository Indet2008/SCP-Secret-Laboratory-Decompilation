using System;
using Utf8Json;

public readonly struct CreditsListCategory : IEquatable<CreditsListCategory>, IJsonSerializable
{
	public readonly string category;

	public readonly CreditsListMember[] members;

	[SerializationConstructor]
	public CreditsListCategory(string category, CreditsListMember[] members)
	{
		this.category = category;
		this.members = members;
	}

	public bool Equals(CreditsListCategory other)
	{
		if (category == other.category)
		{
			return members == other.members;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is CreditsListCategory other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (category == null)
		{
			return 0;
		}
		return category.GetHashCode();
	}

	public static bool operator ==(CreditsListCategory left, CreditsListCategory right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CreditsListCategory left, CreditsListCategory right)
	{
		return !left.Equals(right);
	}
}
