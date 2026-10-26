using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public static class RoleSpawnpointManager
	{
		private struct SpawnpointDefinition
		{
			public RoleTypeId[] Roles;

			public ISpawnpointHandler[] CompatibleSpawnpoints;

			public SpawnpointDefinition(params RoleTypeId[] roles)
			{
				Roles = roles;
				CompatibleSpawnpoints = null;
			}

			public SpawnpointDefinition SetSpawnpoints(params ISpawnpointHandler[] spawnpoints)
			{
				CompatibleSpawnpoints = spawnpoints;
				return this;
			}
		}

		private static readonly SpawnpointDefinition[] DefinedSpawnpoints = new SpawnpointDefinition[1] { new SpawnpointDefinition(RoleTypeId.ClassD).SetSpawnpoints(new RoomRoleSpawnpoint(new Vector3(-6.18f, 0.91f, -4.23f), 5f, 0f, 26.26f, 0.73f, 7, 1, RoomName.LczClassDSpawn), new RoomRoleSpawnpoint(new Vector3(-6.18f, 0.91f, 4.23f), 175f, 0f, 26.26f, 0.73f, 7, 1, RoomName.LczClassDSpawn)) };

		public static bool TryGetSpawnpointForRole(RoleTypeId role, out ISpawnpointHandler spawnpoint)
		{
			bool flag = false;
			List<ISpawnpointHandler> list = new List<ISpawnpointHandler>();
			SpawnpointDefinition[] definedSpawnpoints = DefinedSpawnpoints;
			for (int i = 0; i < definedSpawnpoints.Length; i++)
			{
				SpawnpointDefinition spawnpointDefinition = definedSpawnpoints[i];
				if (spawnpointDefinition.Roles.Contains(role))
				{
					flag = true;
					list.AddRange(spawnpointDefinition.CompatibleSpawnpoints);
				}
			}
			spawnpoint = (flag ? list.RandomItem() : null);
			return flag;
		}

		internal static void SetPosition(ReferenceHub hub, PlayerRoleBase newRole)
		{
			if (!NetworkServer.active || !(newRole is IFpcRole { SpawnpointHandler: not null } fpcRole))
			{
				return;
			}
			bool useSpawnPoint = fpcRole.SpawnpointHandler.TryGetSpawnpoint(out var position, out var horizontalRot);
			PlayerSpawningEventArgs e = new PlayerSpawningEventArgs(hub, newRole, useSpawnPoint, position, horizontalRot);
			PlayerEvents.OnSpawning(e);
			if (!e.IsAllowed)
			{
				return;
			}
			position = e.SpawnLocation;
			horizontalRot = e.HorizontalRotation;
			useSpawnPoint = e.UseSpawnPoint;
			if (!newRole.ServerSpawnFlags.HasFlag(RoleSpawnFlags.UseSpawnpoint) || !useSpawnPoint)
			{
				PlayerEvents.OnSpawned(new PlayerSpawnedEventArgs(hub, newRole, useSpawnPoint, position, horizontalRot));
				return;
			}
			hub.transform.position = position;
			if (fpcRole.FpcModule.MouseLook != null)
			{
				fpcRole.FpcModule.MouseLook.CurrentHorizontal = horizontalRot;
			}
			PlayerEvents.OnSpawned(new PlayerSpawnedEventArgs(hub, newRole, useSpawnPoint, position, horizontalRot));
		}
	}
}
