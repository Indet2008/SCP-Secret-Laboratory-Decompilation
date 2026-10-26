using MapGeneration;
using Mirror;
using PlayerRoles.Ragdolls;
using PlayerRoles.RoleAssign;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public static class Scp3114InitialRagdollSpawner
	{
		private static bool _ragdollsSpawned;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			RoleAssigner.OnBeforePlayersSpawned += OnBeforeSpawn;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		private static void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (newRole == RoleTypeId.Scp3114)
			{
				ServerSpawnRagdolls(userHub);
			}
		}

		private static void OnBeforeSpawn()
		{
			if (NetworkServer.active)
			{
				_ragdollsSpawned = false;
			}
		}

		private static void ServerSpawnRagdolls(ReferenceHub nicknameSourceHub)
		{
			if (!_ragdollsSpawned && RoomUtils.TryFindRoom(RoomName.Lcz173, FacilityZone.LightContainment, RoomShape.Endroom, out var foundRoom))
			{
				_ragdollsSpawned = true;
				Transform transform = foundRoom.transform;
				ServerSpawnRagdoll(RoleTypeId.Scientist, transform.TransformPoint(new Vector3(2.05f, 12.5f, 1.74f)), transform.rotation * Quaternion.Euler(25.5f, -35.5f, -9.4f), nicknameSourceHub);
				ServerSpawnRagdoll(RoleTypeId.ClassD, transform.TransformPoint(new Vector3(2.9f, 12.5f, 1.74f)), transform.rotation * Quaternion.Euler(22.2f, -1.3f, 11.8f), nicknameSourceHub);
			}
		}

		private static void ServerSpawnRagdoll(RoleTypeId role, Vector3 pos, Quaternion rot, ReferenceHub nicknameSource)
		{
			if (role.TryGetRoleTemplate<HumanRole>(out var result))
			{
				RelativePosition relPos = new RelativePosition(pos);
				if (!relPos.OutOfRange)
				{
					Quaternion relativeRotation = WaypointBase.GetRelativeRotation(relPos.WaypointId, rot);
					BasicRagdoll basicRagdoll = result.Ragdoll.ServerInstantiateSelf(nicknameSource, role);
					basicRagdoll.NetworkInfo = new RagdollData(null, new Scp3114DamageHandler(basicRagdoll, isStarting: true), role, relPos, relativeRotation, nicknameSource.nicknameSync.DisplayName, NetworkTime.time);
					NetworkServer.Spawn(basicRagdoll.gameObject);
				}
			}
		}
	}
}
