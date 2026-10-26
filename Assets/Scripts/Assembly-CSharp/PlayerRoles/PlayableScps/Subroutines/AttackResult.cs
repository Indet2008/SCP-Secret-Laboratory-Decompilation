using System;

namespace PlayerRoles.PlayableScps.Subroutines
{
	[Flags]
	public enum AttackResult
	{
		None = 0,
		AttackedObject = 1,
		AttackedPlayer = 2,
		KilledPlayer = 6
	}
}
