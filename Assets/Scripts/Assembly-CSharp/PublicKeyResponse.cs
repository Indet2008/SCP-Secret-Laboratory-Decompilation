using System;
using Utf8Json;

public readonly struct PublicKeyResponse : IEquatable<PublicKeyResponse>, IJsonSerializable
{
	public readonly string key;

	public readonly string signature;

	public readonly string credits;

	[SerializationConstructor]
	public PublicKeyResponse(string key, string signature, string credits)
	{
		this.key = key;
		this.signature = signature;
		this.credits = credits;
	}

	public bool Equals(PublicKeyResponse other)
	{
		if (key == other.key && signature == other.signature)
		{
			return credits == other.credits;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is PublicKeyResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((key != null) ? key.GetHashCode() : 0) * 397) ^ ((signature != null) ? signature.GetHashCode() : 0) ^ ((credits != null) ? credits.GetHashCode() : 0);
	}

	public static bool operator ==(PublicKeyResponse left, PublicKeyResponse right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(PublicKeyResponse left, PublicKeyResponse right)
	{
		return !left.Equals(right);
	}
}
