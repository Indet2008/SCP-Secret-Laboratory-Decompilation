using System;
using Utf8Json;

public readonly struct RequestSignatureResponse : IEquatable<RequestSignatureResponse>, IJsonSerializable
{
	public readonly bool success;

	public readonly string error;

	public readonly SignedToken authToken;

	public readonly SignedToken badgeToken;

	public readonly string nonce;

	[SerializationConstructor]
	public RequestSignatureResponse(bool success, string error, SignedToken authToken, SignedToken badgeToken, string nonce)
	{
		this.success = success;
		this.error = error;
		this.authToken = authToken;
		this.badgeToken = badgeToken;
		this.nonce = nonce;
	}

	public bool Equals(RequestSignatureResponse other)
	{
		if (success == other.success && error == other.error && authToken == other.authToken && badgeToken == other.badgeToken)
		{
			return nonce == other.nonce;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is RequestSignatureResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		bool flag = success;
		return (((((((flag.GetHashCode() * 397) ^ ((error != null) ? error.GetHashCode() : 0)) * 397) ^ ((authToken != null) ? authToken.GetHashCode() : 0)) * 397) ^ ((badgeToken != null) ? badgeToken.GetHashCode() : 0)) * 397) ^ ((nonce != null) ? nonce.GetHashCode() : 0);
	}

	public static bool operator ==(RequestSignatureResponse left, RequestSignatureResponse right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(RequestSignatureResponse left, RequestSignatureResponse right)
	{
		return !left.Equals(right);
	}
}
