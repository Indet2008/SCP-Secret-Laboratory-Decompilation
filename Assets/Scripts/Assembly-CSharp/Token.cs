using System;

public abstract class Token
{
	public readonly string UserId;

	public readonly string Nickname;

	public readonly DateTimeOffset IssuanceTime;

	public readonly DateTimeOffset ExpirationTime;

	public readonly string Usage;

	public readonly string IssuedBy;

	public readonly string Serial;

	public readonly bool TestSignature;

	public readonly int TokenVersion;

	protected Token(string userId, string nickname, DateTimeOffset issuanceTime, DateTimeOffset expirationTime, string usage, string issuedBy, string serial, bool testSignature, int tokenVersion)
	{
		UserId = userId;
		Nickname = nickname;
		IssuanceTime = issuanceTime;
		ExpirationTime = expirationTime;
		Usage = usage;
		IssuedBy = issuedBy;
		Serial = serial;
		TestSignature = testSignature;
		TokenVersion = tokenVersion;
	}
}
