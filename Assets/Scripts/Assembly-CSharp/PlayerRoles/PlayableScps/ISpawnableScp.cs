using System.Collections.Generic;

namespace PlayerRoles.PlayableScps
{
	public interface ISpawnableScp
	{
		bool RespectPreferences => true;

		bool AllowFallback => true;

		float GetSpawnChance(List<RoleTypeId> alreadySpawned);
	}
}
