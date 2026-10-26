using System;

namespace PlayerRoles.PlayableScps.Scp096
{
	[Flags]
	public enum Scp096HitResult : byte
	{
		None = 0,
		Window = 1,
		Door = 2,
		Human = 4,
		Lethal = 0xC
	}
}
