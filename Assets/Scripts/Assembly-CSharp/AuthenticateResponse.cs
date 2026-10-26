using System;
using Utf8Json;

public readonly struct AuthenticateResponse : IEquatable<AuthenticateResponse>, IJsonSerializable
{
	public readonly bool success;

	public readonly string error;

	public readonly string token;

	public readonly string id;

	public readonly string nonce;

	public readonly string country;

	public readonly byte flags;

	public readonly long expiration;

	public readonly string preauth;

	public readonly string globalBan;

	public readonly ushort lifetime;

	public readonly bool NoWatermarking;

	[SerializationConstructor]
	public AuthenticateResponse(bool success, string error, string token, string id, string nonce, string country, byte flags, long expiration, string preauth, string globalBan, ushort lifetime, bool NoWatermarking)
	{
		this.success = success;
		this.error = error;
		this.token = token;
		this.id = id;
		this.nonce = nonce;
		this.country = country;
		this.flags = flags;
		this.expiration = expiration;
		this.preauth = preauth;
		this.globalBan = globalBan;
		this.lifetime = lifetime;
		this.NoWatermarking = NoWatermarking;
	}

	public bool Equals(AuthenticateResponse other)
	{
		if (success == other.success && error == other.error && token == other.token && id == other.id && nonce == other.nonce && country == other.country && flags == other.flags && expiration == other.expiration && preauth == other.preauth && globalBan == other.globalBan && lifetime == other.lifetime)
		{
			return NoWatermarking == other.NoWatermarking;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is AuthenticateResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		bool flag = success;
		int num = ((((((((((flag.GetHashCode() * 397) ^ ((error != null) ? error.GetHashCode() : 0)) * 397) ^ ((token != null) ? token.GetHashCode() : 0)) * 397) ^ ((id != null) ? id.GetHashCode() : 0)) * 397) ^ ((nonce != null) ? nonce.GetHashCode() : 0)) * 397) ^ ((country != null) ? country.GetHashCode() : 0)) * 397;
		byte b = flags;
		int num2 = (num ^ b.GetHashCode()) * 397;
		long num3 = expiration;
		int num4 = (((((num2 ^ num3.GetHashCode()) * 397) ^ ((preauth != null) ? preauth.GetHashCode() : 0)) * 397) ^ ((globalBan != null) ? globalBan.GetHashCode() : 0)) * 397;
		ushort num5 = lifetime;
		int num6 = (num4 ^ num5.GetHashCode()) * 397;
		flag = NoWatermarking;
		return num6 ^ flag.GetHashCode();
	}

	public static bool operator ==(AuthenticateResponse left, AuthenticateResponse right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(AuthenticateResponse left, AuthenticateResponse right)
	{
		return !left.Equals(right);
	}
}
