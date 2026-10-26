using System;

namespace PlayerRoles.Voice
{
	[Flags]
	public enum GroupMuteFlags
	{
		None = 0,
		Spectators = 1,
		Alive = 2,
		Lobby = 4,
		Summary = 8
	}
}
