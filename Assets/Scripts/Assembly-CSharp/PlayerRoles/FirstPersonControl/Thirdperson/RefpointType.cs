using System;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	[Flags]
	public enum RefpointType
	{
		None = 0,
		LineOfSightPoint = 1,
		Hitbox = 2
	}
}
