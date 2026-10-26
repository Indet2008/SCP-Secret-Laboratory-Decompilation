using System;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	[Flags]
	public enum WearableElements : byte
	{
		None = 0,
		Scp268Hat = 1,
		Scp1344Goggles = 2,
		Armor = 4
	}
}
