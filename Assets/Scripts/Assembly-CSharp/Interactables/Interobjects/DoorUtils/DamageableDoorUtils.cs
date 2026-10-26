namespace Interactables.Interobjects.DoorUtils
{
	public static class DamageableDoorUtils
	{
		public static bool HasFlagFast(this DoorDamageType value, DoorDamageType flag)
		{
			return (value & flag) == flag;
		}
	}
}
