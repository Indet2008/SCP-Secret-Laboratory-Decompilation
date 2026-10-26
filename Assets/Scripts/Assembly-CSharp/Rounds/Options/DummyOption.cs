using System;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles;
using UnityEngine;

namespace Rounds.Options
{
	[Serializable]
	public class DummyOption : IRoundOption
	{
		[field: SerializeField]
		public RoleTypeId RoleType { get; set; }

		public DummyOption(RoleTypeId targetRole = RoleTypeId.None)
		{
			RoleType = targetRole;
		}

		public void Invoke()
		{
			if (NetworkServer.active)
			{
				ReferenceHub referenceHub = DummyUtils.SpawnDummy(RoleType.GetAbbreviatedRoleName());
				if (RoleType != RoleTypeId.None)
				{
					referenceHub.roleManager.ServerSetRole(RoleType, RoleChangeReason.RemoteAdmin);
				}
			}
		}
	}
}
