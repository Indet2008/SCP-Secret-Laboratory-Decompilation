public enum RejectionReason : byte
{
	NotSpecified = 0,
	ServerFull = 1,
	InvalidToken = 2,
	VersionMismatch = 3,
	Error = 4,
	AuthenticationRequired = 5,
	Banned = 6,
	NotWhitelisted = 7,
	GloballyBanned = 8,
	Geoblocked = 9,
	Custom = 10,
	ExpiredAuth = 11,
	RateLimit = 12,
	Challenge = 13,
	InvalidChallengeKey = 14,
	InvalidChallenge = 15,
	Redirect = 16,
	Delay = 17,
	VerificationAccepted = 18,
	VerificationRejected = 19,
	CentralServerAuthRejected = 20
}
