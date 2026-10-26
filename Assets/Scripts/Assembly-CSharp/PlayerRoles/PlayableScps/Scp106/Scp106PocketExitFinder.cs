using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using Interactables;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using Mirror;
using PlayerRoles.FirstPersonControl;
using ProgressiveCulling;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public static class Scp106PocketExitFinder
	{
		private const int RequiredTriggers = 2;

		private const int MaxArraySize = 64;

		private const int MaxDistanceSqr = 750;

		private const float ZombieSqrModifier = 0.3f;

		private const float RaycastRange = 11f;

		private const float SurfaceRaycastRange = 45f;

		public static readonly Dictionary<FacilityZone, Pose[]> PosesForZoneCache = new Dictionary<FacilityZone, Pose[]>();

		public static readonly RoomName[] BlacklistedRooms = new RoomName[6]
		{
			RoomName.Hcz079,
			RoomName.LczCheckpointA,
			RoomName.LczCheckpointB,
			RoomName.HczCheckpointToEntranceZone,
			RoomName.LczClassDSpawn,
			RoomName.HczTesla
		};

		private static readonly string[] BlacklistedDoors = new string[1] { "ESCAPE_FINAL" };

		private static readonly Pose[] PosesNonAlloc = new Pose[64];

		private static readonly Vector3[] PositionsCache = new Vector3[64];

		private static readonly bool[] PositionModifiers = new bool[64];

		private static readonly int Mask = LayerMask.GetMask("Default", "Glass");

		public static Vector3 GetBestExitPosition(IFpcRole role)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Scp106PocketExitFinder.GetBestExitPosition is a server-side only method!");
			}
			if (!(role is PlayerRoleBase playerRoleBase) || !playerRoleBase.TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("Scp106PocketExitFinder.GetBestExitPosition provided with non-compatible role!");
			}
			Vector3 position = hub.playerEffectsController.GetEffect<PocketCorroding>().CapturePosition.Position;
			if (!position.TryGetRoom(out var room))
			{
				return position;
			}
			Pose[] posesForZone = GetPosesForZone(room.Zone);
			if (posesForZone.Length != 0)
			{
				Pose randomPose = GetRandomPose(posesForZone);
				float raycastRange = GetRaycastRange(room.Zone);
				return SafeLocationFinder.GetSafePositionForPose(randomPose, raycastRange, role.FpcModule.CharController);
			}
			return position;
		}

		public static Pose GetRandomPose(Pose[] poses)
		{
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is FpcStandardScp fpcStandardScp)
				{
					PositionsCache[num] = fpcStandardScp.FpcModule.Position;
					PositionModifiers[num] = fpcStandardScp.RoleTypeId == RoleTypeId.Scp0492;
					if (++num >= 64)
					{
						break;
					}
				}
			}
			if (num == 0)
			{
				return poses.RandomItem();
			}
			Pose? pose = null;
			float num2 = float.MaxValue;
			int num3 = 0;
			for (int i = 0; i < poses.Length; i++)
			{
				Pose pose2 = poses[i];
				float num4 = 0f;
				bool flag = true;
				for (int j = 0; j < num; j++)
				{
					float num5 = (pose2.position - PositionsCache[j]).sqrMagnitude;
					if (PositionModifiers[j])
					{
						num5 *= 0.3f;
					}
					if (num5 < 750f)
					{
						flag = false;
					}
					num4 += num5;
				}
				if (flag)
				{
					PosesNonAlloc[num3++] = pose2;
				}
				if (num4 < num2)
				{
					pose = pose2;
					num2 = num4;
				}
			}
			if (num3 != 0)
			{
				return PosesNonAlloc[UnityEngine.Random.Range(0, num3)];
			}
			return pose ?? poses.RandomItem();
		}

		public static Pose[] GetPosesForZone(FacilityZone zone)
		{
			if (PosesForZoneCache.TryGetValue(zone, out var value))
			{
				return value;
			}
			Pose[] array = SafeLocationFinder.GetLocations((RoomCullingConnection x) => ValidateConnection(x, zone), (DoorVariant y) => ValidateDoor(y, zone)).ToArray();
			PosesForZoneCache[zone] = array;
			return array;
		}

		public static float GetRaycastRange(FacilityZone zone)
		{
			if (zone != FacilityZone.Surface)
			{
				return 11f;
			}
			return 45f;
		}

		private static bool ValidateDoor(DoorVariant dv, FacilityZone requiredZone)
		{
			if (!(dv is BasicDoor basicDoor))
			{
				return false;
			}
			if (BlacklistedDoors.Contains<string>(dv.DoorName))
			{
				return false;
			}
			if (dv.RequiredPermissions.RequiredPermissions != DoorPermissionFlags.None)
			{
				return false;
			}
			if (!InteractableCollider.AllInstances.TryGetValue(basicDoor, out var value))
			{
				return false;
			}
			if (value.Count < 2)
			{
				return false;
			}
			RoomIdentifier[] rooms = basicDoor.Rooms;
			for (int i = 0; i < rooms.Length; i++)
			{
				if (!ValidateRoom(rooms[i], requiredZone))
				{
					return false;
				}
			}
			return true;
		}

		private static bool ValidateConnection(RoomCullingConnection conn, FacilityZone requiredZone)
		{
			RoomCullingConnection.RoomLink link = conn.Link;
			if (link.Valid && ValidateRoom(link.RoomA, requiredZone))
			{
				return ValidateRoom(link.RoomB, requiredZone);
			}
			return false;
		}

		private static bool ValidateRoom(RoomIdentifier room, FacilityZone requiredZone)
		{
			if (room.Zone == requiredZone)
			{
				return !BlacklistedRooms.Contains(room.Name);
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationFinished += PosesForZoneCache.Clear;
		}
	}
}
