using System;
using MapGeneration;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class TeleportOutcome : BlackCandyOutcomeBase
	{
		private static readonly FacilityZone[] PossibleZones = new FacilityZone[2]
		{
			FacilityZone.LightContainment,
			FacilityZone.HeavyContainment
		};

		public override void ServerGrant(ReferenceHub target)
		{
			if (!AlphaWarheadController.Detonated && !AlphaWarheadController.InProgress && target.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				Vector3 bestExitPosition = GetBestExitPosition(fpcRole);
				fpcRole.FpcModule.ServerOverridePosition(bestExitPosition);
			}
		}

		public static Vector3 GetBestExitPosition(IFpcRole role)
		{
			if (!(role is PlayerRoleBase playerRoleBase) || !playerRoleBase.TryGetOwner(out var _))
			{
				throw new InvalidOperationException("TeleportOutcome.GetBestExitPosition provided with non-compatible role!");
			}
			FacilityZone zone = PossibleZones.RandomItem();
			Pose[] posesForZone = Scp106PocketExitFinder.GetPosesForZone(zone);
			if (posesForZone.Length != 0)
			{
				Pose randomPose = Scp106PocketExitFinder.GetRandomPose(posesForZone);
				float raycastRange = Scp106PocketExitFinder.GetRaycastRange(zone);
				return SafeLocationFinder.GetSafePositionForPose(randomPose, raycastRange, role.FpcModule.CharController);
			}
			return role.FpcModule.Position;
		}
	}
}
