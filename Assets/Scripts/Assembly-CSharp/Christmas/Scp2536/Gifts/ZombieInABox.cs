using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp049;
using PlayerRoles.Spectating;
using Respawning.Waves;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class ZombieInABox : Scp2536AnomalousGiftBase
	{
		private const int MinimumSpectators = 1;

		private const float MaxSpawnDistance = 3f;

		private const RoleTypeId RespawnRole = RoleTypeId.Scp0492;

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is Scp049Role))
			{
				return false;
			}
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				RoleTypeId roleId = allHub.GetRoleId();
				if (roleId == RoleTypeId.Scp0492 || roleId == RoleTypeId.ZombieFlamingo)
				{
					return false;
				}
				if (allHub.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false })
				{
					num++;
				}
			}
			return num >= 1;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			Vector3 forward = hub.PlayerCameraReference.forward;
			Vector3 position = fpcRole.FpcModule.Position;
			Team team = hub.GetTeam();
			int num = 0;
			ReferenceHub[] availablePlayers = WaveSpawner.GetAvailablePlayers(team);
			foreach (ReferenceHub referenceHub in availablePlayers)
			{
				if (num < 1)
				{
					referenceHub.roleManager.ServerSetRole(RoleTypeId.Scp0492, RoleChangeReason.ItemUsage, ~RoleSpawnFlags.UseSpawnpoint);
					if (referenceHub.roleManager.CurrentRole is IFpcRole fpcRole2)
					{
						Vector3 safePosition = SafeLocationFinder.GetSafePosition(position, forward, 3f, fpcRole2.FpcModule.CharController);
						Vector3 eulerAngles = Quaternion.LookRotation(position - safePosition).eulerAngles;
						fpcRole2.FpcModule.ServerOverridePosition(safePosition);
						fpcRole2.FpcModule.ServerOverrideRotation(eulerAngles);
						num++;
					}
					continue;
				}
				break;
			}
		}
	}
}
