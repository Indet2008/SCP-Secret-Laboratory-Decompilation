using PlayerRoles;
using PlayerRoles.PlayableScps.Scp3114;
using PlayerRoles.Ragdolls;
using PlayerStatsSystem;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class FlyingCorpse : Scp2536AnomalousGiftBase
	{
		private const float RagdollRotationOffset = 5f;

		private const float MaxDistanceMultiplier = 2.5f;

		private const float RagdollHeightOffset = 0.5f;

		private const float RagdollScale = 0.75f;

		private const float CorpseForce = -7f;

		private static readonly RoleTypeId[] TargetCorpseTypes = new RoleTypeId[8]
		{
			RoleTypeId.NtfPrivate,
			RoleTypeId.NtfSergeant,
			RoleTypeId.NtfCaptain,
			RoleTypeId.NtfSpecialist,
			RoleTypeId.ChaosMarauder,
			RoleTypeId.ChaosRepressor,
			RoleTypeId.ChaosRifleman,
			RoleTypeId.ChaosConscript
		};

		private static readonly CachedLayerMask RaycastLayer = new CachedLayerMask("Default", "Door");

		private static string RagdollNickname => "SCP-2536-" + Random.Range(6, ReferenceHub.AllHubs.Count);

		public override UrgencyLevel Urgency => UrgencyLevel.Three;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (hub.roleManager.CurrentRole is Scp3114Role scp3114Role)
			{
				return !scp3114Role.Disguised;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			Vector3 position = hub.PlayerCameraReference.position;
			Vector3 forward = hub.PlayerCameraReference.forward;
			float maxDistance = 6.05f;
			if (!Physics.Raycast(position, forward, out var hitInfo, maxDistance, RaycastLayer))
			{
				return;
			}
			Vector3 vector = hitInfo.point + Vector3.up * 0.5f;
			Quaternion rotation = Quaternion.LookRotation(vector - (position + Vector3.up * 5f));
			Vector3 value = Vector3.one * 0.75f;
			RoleTypeId role = TargetCorpseTypes.RandomItem();
			DamageHandlerBase handler = new UniversalDamageHandler(0f, DeathTranslations.Asphyxiated);
			if (RagdollManager.ServerCreateRagdoll(role, vector, rotation, handler, hub.nicknameSync.DisplayName, value) is DynamicRagdoll dynamicRagdoll)
			{
				Vector3 force = dynamicRagdoll.transform.forward * -7f;
				Rigidbody[] linkedRigidbodies = dynamicRagdoll.LinkedRigidbodies;
				for (int i = 0; i < linkedRigidbodies.Length; i++)
				{
					linkedRigidbodies[i].AddForce(force, ForceMode.Impulse);
				}
			}
		}
	}
}
