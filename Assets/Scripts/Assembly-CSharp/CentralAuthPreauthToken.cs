public readonly struct CentralAuthPreauthToken
{
	public readonly string UserId;

	public readonly byte Flags;

	public readonly string Country;

	public readonly long Expiration;

	public readonly string Signature;

	public CentralAuthPreauthToken(string userId, byte flags, string country, long expiration, string signature)
	{
		UserId = userId;
		Flags = flags;
		Country = country;
		Expiration = expiration;
		Signature = signature;
	}
}
