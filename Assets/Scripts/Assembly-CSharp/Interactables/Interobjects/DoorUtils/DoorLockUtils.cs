namespace Interactables.Interobjects.DoorUtils
{
	public static class DoorLockUtils
	{
		public static DoorLockMode GetMode(DoorLockReason reason)
		{
			if (reason == DoorLockReason.None)
			{
				return DoorLockMode.CanOpen | DoorLockMode.CanClose;
			}
			if ((int)(reason & (DoorLockReason.AdminCommand | DoorLockReason.DecontLockdown | DoorLockReason.SpecialDoorFeature | DoorLockReason.NoPower | DoorLockReason.Lockdown2176)) > 0)
			{
				return DoorLockMode.FullLock;
			}
			if ((int)(reason & (DoorLockReason.Regular079 | DoorLockReason.Lockdown079)) > 0)
			{
				return DoorLockMode.ScpOverride;
			}
			if ((int)(reason & (DoorLockReason.Warhead | DoorLockReason.DecontEvacuate)) > 0)
			{
				return DoorLockMode.CanOpen;
			}
			if ((int)(reason & DoorLockReason.Isolation) > 0)
			{
				return DoorLockMode.CanClose;
			}
			return DoorLockMode.CanOpen | DoorLockMode.CanClose;
		}

		public static DoorLockMode GetMode(DoorVariant door)
		{
			return GetMode((DoorLockReason)door.ActiveLocks);
		}

		public static bool HasFlagFast(this DoorLockMode mode, DoorLockMode flag)
		{
			return (mode & flag) == flag;
		}

		public static bool HasFlagFast(this DoorLockReason res, DoorLockReason flag)
		{
			return (res & flag) == flag;
		}
	}
}
