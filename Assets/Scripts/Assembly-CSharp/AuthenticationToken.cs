using System;
using Utf8Json;

public class AuthenticationToken : Token, IJsonSerializable
{
	public readonly string RequestIp;

	public readonly int Asn;

	public readonly string GlobalBan;

	public readonly string VacSession;

	public readonly bool DoNotTrack;

	public readonly bool SkipIpCheck;

	public readonly bool BypassBans;

	public readonly bool BypassGeoRestrictions;

	public readonly bool BypassWhitelists;

	public readonly bool GlobalBadge;

	public readonly bool PrivateBetaOwnership;

	public readonly bool SyncHashed;

	public readonly string PublicKey;

	public readonly string Challenge;

	public readonly int PlayerId;

	public readonly string GameVersion;

	[SerializationConstructor]
	public AuthenticationToken(string requestIp, int asn, string globalBan, string vacSession, bool doNotTrack, bool skipIpCheck, bool bypassBans, bool bypassGeoRestrictions, bool bypassWhitelists, bool globalBadge, bool privateBetaOwnership, bool syncHashed, string publicKey, string challenge, int playerId, string gameVersion, string userId, string nickname, DateTimeOffset issuanceTime, DateTimeOffset expirationTime, string usage, string issuedBy, string serial, bool testSignature, int tokenVersion)
		: base(userId, nickname, issuanceTime, expirationTime, usage, issuedBy, serial, testSignature, tokenVersion)
	{
		RequestIp = requestIp;
		Asn = asn;
		GlobalBan = globalBan;
		VacSession = vacSession;
		DoNotTrack = doNotTrack;
		SkipIpCheck = skipIpCheck;
		BypassBans = bypassBans;
		BypassGeoRestrictions = bypassGeoRestrictions;
		BypassWhitelists = bypassWhitelists;
		GlobalBadge = globalBadge;
		PrivateBetaOwnership = privateBetaOwnership;
		SyncHashed = syncHashed;
		PublicKey = publicKey;
		Challenge = challenge;
		PlayerId = playerId;
		GameVersion = gameVersion;
	}
}
