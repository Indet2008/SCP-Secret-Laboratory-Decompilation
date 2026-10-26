using System;
using Utf8Json;

public readonly struct AuthenticatorResponse : IEquatable<AuthenticatorResponse>, IJsonSerializable
{
	public readonly bool success;

	public readonly bool verified;

	public readonly string error;

	public readonly string token;

	public readonly string[] messages;

	public readonly string[] actions;

	public readonly string[] authAccepted;

	public readonly AuthenticatiorAuthReject[] authRejected;

	public readonly string verificationChallenge;

	public readonly string verificationResponse;

	[SerializationConstructor]
	public AuthenticatorResponse(bool success, bool verified, string error, string token, string[] messages, string[] actions, string[] authAccepted, AuthenticatiorAuthReject[] authRejected, string verificationChallenge, string verificationResponse)
	{
		this.success = success;
		this.verified = verified;
		this.error = error;
		this.token = token;
		this.messages = messages;
		this.actions = actions;
		this.authAccepted = authAccepted;
		this.authRejected = authRejected;
		this.verificationChallenge = verificationChallenge;
		this.verificationResponse = verificationResponse;
	}

	public bool Equals(AuthenticatorResponse other)
	{
		if (success == other.success && verified == other.verified && string.Equals(error, other.error) && string.Equals(token, other.token) && messages == other.messages && actions == other.actions && authAccepted == other.authAccepted && authRejected == other.authRejected && verificationChallenge == other.verificationChallenge)
		{
			return verificationResponse == other.verificationResponse;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is AuthenticatorResponse other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		bool flag = success;
		int num = flag.GetHashCode() * 397;
		flag = verified;
		return ((((((((((((((((num ^ flag.GetHashCode()) * 397) ^ ((error != null) ? error.GetHashCode() : 0)) * 397) ^ ((token != null) ? token.GetHashCode() : 0)) * 397) ^ ((messages != null) ? messages.GetHashCode() : 0)) * 397) ^ ((actions != null) ? actions.GetHashCode() : 0)) * 397) ^ ((authAccepted != null) ? authAccepted.GetHashCode() : 0)) * 397) ^ ((authRejected != null) ? authRejected.GetHashCode() : 0)) * 397) ^ ((verificationChallenge != null) ? verificationChallenge.GetHashCode() : 0)) * 397) ^ ((verificationResponse != null) ? verificationResponse.GetHashCode() : 0);
	}

	public static bool operator ==(AuthenticatorResponse left, AuthenticatorResponse right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(AuthenticatorResponse left, AuthenticatorResponse right)
	{
		return !left.Equals(right);
	}
}
