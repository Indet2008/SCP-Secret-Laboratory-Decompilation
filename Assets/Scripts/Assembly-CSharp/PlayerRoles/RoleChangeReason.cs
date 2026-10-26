namespace PlayerRoles
{
	public enum RoleChangeReason : byte
	{
		None = 0,
		RoundStart = 1,
		LateJoin = 2,
		Respawn = 3,
		Died = 4,
		Escaped = 5,
		Revived = 6,
		RemoteAdmin = 7,
		Destroyed = 8,
		RespawnMiniwave = 9,
		ItemUsage = 10,
		Resurrected = 11
	}
}
