namespace LabApi.Features.Extensions
{
	public static class RoleExtensions
	{
		private static readonly global::InventorySystem.InventoryRoleInfo EmptyInventoryInfo = new global::InventorySystem.InventoryRoleInfo(global::System.Array.Empty<ItemType>(), new global::System.Collections.Generic.Dictionary<ItemType, ushort>());

		public static global::PlayerRoles.PlayerRoleBase GetRoleBase(this global::PlayerRoles.RoleTypeId roleType)
		{
			if (!global::PlayerRoles.PlayerRoleLoader.TryGetRoleTemplate<global::PlayerRoles.PlayerRoleBase>(roleType, out var result))
			{
				return null;
			}
			return result;
		}

		public static bool TryGetRoleBase<T>(this global::PlayerRoles.RoleTypeId roleTypeId, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out T? role)
		{
			return global::PlayerRoles.PlayerRoleLoader.TryGetRoleTemplate<T>(roleTypeId, out role);
		}

		public static string GetFullName(this global::PlayerRoles.RoleTypeId roleType)
		{
			return roleType.GetRoleBase().RoleName;
		}

		public static bool TryGetRandomSpawnPoint(this global::PlayerRoles.RoleTypeId role, out global::UnityEngine.Vector3 position, out float horizontalRotation)
		{
			if (role.TryGetRoleBase<global::PlayerRoles.FirstPersonControl.IFpcRole>(out global::PlayerRoles.FirstPersonControl.IFpcRole role2) && role2.SpawnpointHandler != null)
			{
				return role2.SpawnpointHandler.TryGetSpawnpoint(out position, out horizontalRotation);
			}
			position = global::UnityEngine.Vector3.zero;
			horizontalRotation = 0f;
			return false;
		}

		public static global::InventorySystem.InventoryRoleInfo GetInventory(this global::PlayerRoles.RoleTypeId roleTypeId)
		{
			return global::System.Collections.Generic.CollectionExtensions.GetValueOrDefault(global::InventorySystem.Configs.StartingInventories.DefinedInventories, roleTypeId, EmptyInventoryInfo);
		}

		public static bool IsScp(this global::PlayerRoles.RoleTypeId roleType)
		{
			return global::PlayerRoles.PlayerRolesUtils.GetTeam(roleType) == global::PlayerRoles.Team.SCPs;
		}

		public static bool IsDead(this global::PlayerRoles.RoleTypeId roleType)
		{
			return global::PlayerRoles.PlayerRolesUtils.GetTeam(roleType) == global::PlayerRoles.Team.Dead;
		}

		public static bool IsNtf(this global::PlayerRoles.RoleTypeId roleType)
		{
			if (global::PlayerRoles.PlayerRolesUtils.GetTeam(roleType) == global::PlayerRoles.Team.FoundationForces)
			{
				return roleType != global::PlayerRoles.RoleTypeId.FacilityGuard;
			}
			return false;
		}

		public static bool IsChaos(this global::PlayerRoles.RoleTypeId roleType)
		{
			return global::PlayerRoles.PlayerRolesUtils.GetTeam(roleType) == global::PlayerRoles.Team.ChaosInsurgency;
		}

		public static bool IsMilitary(this global::PlayerRoles.RoleTypeId roleType)
		{
			if (!roleType.IsNtf() && !roleType.IsChaos())
			{
				return roleType == global::PlayerRoles.RoleTypeId.FacilityGuard;
			}
			return true;
		}

		public static bool IsCivilian(this global::PlayerRoles.RoleTypeId roleType)
		{
			if (roleType == global::PlayerRoles.RoleTypeId.ClassD || roleType == global::PlayerRoles.RoleTypeId.Scientist)
			{
				return true;
			}
			return false;
		}
	}
}
