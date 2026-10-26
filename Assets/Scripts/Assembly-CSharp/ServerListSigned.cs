using System;
using Utf8Json;

public readonly struct ServerListSigned : IEquatable<ServerListSigned>, IJsonSerializable
{
	public readonly string payload;

	public readonly long timestamp;

	public readonly string signature;

	public readonly string nonce;

	public readonly string error;

	[SerializationConstructor]
	public ServerListSigned(string payload, long timestamp, string signature, string nonce, string error)
	{
		this.payload = payload;
		this.timestamp = timestamp;
		this.signature = signature;
		this.nonce = nonce;
		this.error = error;
	}

	public bool Equals(ServerListSigned other)
	{
		if (payload == other.payload && timestamp == other.timestamp && signature == other.signature && nonce == other.nonce)
		{
			return error == other.error;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is ServerListSigned other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		int num = ((payload != null) ? payload.GetHashCode() : 0) * 397;
		long num2 = timestamp;
		return ((((((num ^ num2.GetHashCode()) * 397) ^ ((signature != null) ? signature.GetHashCode() : 0)) * 397) ^ ((nonce != null) ? nonce.GetHashCode() : 0)) * 397) ^ ((error != null) ? error.GetHashCode() : 0);
	}

	public static bool operator ==(ServerListSigned left, ServerListSigned right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(ServerListSigned left, ServerListSigned right)
	{
		return !left.Equals(right);
	}
}
