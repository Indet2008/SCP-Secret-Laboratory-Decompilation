using System;

namespace Interactables.Interobjects.DoorUtils
{
	[Flags]
	public enum DoorLockReason : ushort
	{
		None = 0,
		Regular079 = 1,
		Lockdown079 = 2,
		Warhead = 4,
		AdminCommand = 8,
		DecontLockdown = 0x10,
		DecontEvacuate = 0x20,
		SpecialDoorFeature = 0x40,
		NoPower = 0x80,
		Isolation = 0x100,
		Lockdown2176 = 0x200
	}
}
