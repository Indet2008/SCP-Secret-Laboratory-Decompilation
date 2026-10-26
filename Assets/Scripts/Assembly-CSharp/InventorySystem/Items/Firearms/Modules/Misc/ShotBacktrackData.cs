using System;
using Mirror;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public readonly struct ShotBacktrackData
	{
		private static readonly RelativePosition DefaultPos;

		public readonly RelativePosition RelativeOwnerPosition;

		public readonly Quaternion RelativeOwnerRotation;

		public readonly bool HasPrimaryTarget;

		public readonly ReferenceHub PrimaryTargetHub;

		public readonly RelativePosition PrimaryTargetRelativePosition;

		public readonly double CreationTimestamp;

		public double Age => NetworkTime.time - CreationTimestamp;

		public void WriteSelf(NetworkWriter writer)
		{
			writer.WriteRelativePosition(RelativeOwnerPosition);
			writer.WriteQuaternion(RelativeOwnerRotation);
			writer.WriteReferenceHub(PrimaryTargetHub);
			writer.WriteRelativePosition(PrimaryTargetRelativePosition);
		}

		public void ProcessShot(Firearm firearm, Action<ReferenceHub> processingMethod)
		{
			if (!WaypointBase.TryGetWaypoint(RelativeOwnerPosition.WaypointId, out var wp))
			{
				return;
			}
			double lagCompensation = 0.0;
			if (firearm.Owner != null)
			{
				lagCompensation = firearm.Owner.connectionToClient.rtt / 2.0;
			}
			using (new WaypointBacktracker(wp, lagCompensation))
			{
				Vector3 worldspacePosition = wp.GetWorldspacePosition(RelativeOwnerPosition.Relative);
				Quaternion worldspaceRotation = wp.GetWorldspaceRotation(RelativeOwnerRotation);
				using (new FpcBacktracker(firearm.Owner, worldspacePosition, worldspaceRotation))
				{
					if (HasPrimaryTarget)
					{
						using (new WaypointBacktracker(PrimaryTargetRelativePosition.WaypointId, lagCompensation))
						{
							using (new FpcBacktracker(PrimaryTargetHub, PrimaryTargetRelativePosition.Position))
							{
								processingMethod(PrimaryTargetHub);
								return;
							}
						}
					}
					processingMethod(null);
				}
			}
		}

		public ShotBacktrackData(NetworkReader reader)
		{
			CreationTimestamp = NetworkTime.time;
			RelativeOwnerPosition = reader.ReadRelativePosition();
			RelativeOwnerRotation = reader.ReadQuaternion();
			HasPrimaryTarget = reader.TryReadReferenceHub(out PrimaryTargetHub);
			PrimaryTargetRelativePosition = reader.ReadRelativePosition();
		}

		public ShotBacktrackData(Firearm firearm)
		{
			CreationTimestamp = NetworkTime.time;
			if (!(firearm.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				RelativeOwnerPosition = DefaultPos;
				RelativeOwnerRotation = Quaternion.identity;
				HasPrimaryTarget = false;
				PrimaryTargetHub = null;
				PrimaryTargetRelativePosition = DefaultPos;
				return;
			}
			RelativeOwnerPosition = new RelativePosition(fpcRole.FpcModule.Position);
			RelativeOwnerRotation = WaypointBase.GetRelativeRotation(RelativeOwnerPosition.WaypointId, firearm.Owner.PlayerCameraReference.rotation);
			if (TryGetPrimaryTarget(firearm, out var bestHitbox) && bestHitbox.TargetHub.roleManager.CurrentRole is IFpcRole fpcRole2)
			{
				HasPrimaryTarget = true;
				PrimaryTargetHub = bestHitbox.TargetHub;
				PrimaryTargetRelativePosition = new RelativePosition(fpcRole2.FpcModule.Position);
			}
			else
			{
				HasPrimaryTarget = false;
				PrimaryTargetHub = null;
				PrimaryTargetRelativePosition = DefaultPos;
			}
		}

		private static bool TryGetPrimaryTarget(Firearm firearm, out HitboxIdentity bestHitbox)
		{
			CachedLayerMask hitregMask = HitscanHitregModuleBase.HitregMask;
			uint netId = firearm.Owner.netId;
			float num = 0.5f;
			Transform playerCameraReference = firearm.Owner.PlayerCameraReference;
			Vector3 position = playerCameraReference.position;
			Vector3 forward = playerCameraReference.forward;
			if (Physics.Raycast(position, forward, out var hitInfo, 150f, hitregMask) && hitInfo.collider.TryGetComponent<HitboxIdentity>(out bestHitbox))
			{
				return true;
			}
			bestHitbox = null;
			foreach (HitboxIdentity instance in HitboxIdentity.Instances)
			{
				if (instance.NetworkId != netId && !(Mathf.Abs(instance.CenterOfMass.y - position.y) > 50f))
				{
					float num2 = Vector3.Dot(forward, (instance.CenterOfMass - position).normalized);
					if (!(num2 < num))
					{
						num = num2;
						bestHitbox = instance;
					}
				}
			}
			return bestHitbox != null;
		}
	}
}
