using System;

namespace PlayerRoles
{
	[Flags]
	public enum RoleSpawnFlags
	{
		None = 0,
		AssignInventory = 1,
		UseSpawnpoint = 2,
		All = -1
	}
}
