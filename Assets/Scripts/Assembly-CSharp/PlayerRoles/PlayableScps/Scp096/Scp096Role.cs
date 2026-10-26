using System.Collections.Generic;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096Role : FpcStandardScp, ISubroutinedRole, IHumeShieldedRole, IHudScp, ISpawnableScp
	{
		[field: SerializeField]
		public Scp096StateController StateController { get; private set; }

		[field: SerializeField]
		public HumeShieldModuleBase HumeShieldModule { get; private set; }

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public ScpHudBase HudPrefab { get; private set; }

		public float GetSpawnChance(List<RoleTypeId> alreadySpawned)
		{
			return (alreadySpawned.Count != 0 && !alreadySpawned.Contains(RoleTypeId.Scp079)) ? 1 : 0;
		}
	}
}
