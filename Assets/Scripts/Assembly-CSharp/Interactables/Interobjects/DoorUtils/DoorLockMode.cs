using System;

namespace Interactables.Interobjects.DoorUtils
{
	[Flags]
	public enum DoorLockMode : byte
	{
		FullLock = 0,
		CanOpen = 1,
		CanClose = 2,
		ScpOverride = 4
	}
}
