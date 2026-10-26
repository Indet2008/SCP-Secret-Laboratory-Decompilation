using System;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.HumanTracker;

namespace PlayerRoles
{
	public static class PlayerRolesUtils
	{
		public static readonly CachedLayerMask AttackMask = new CachedLayerMask("Default", "Door", "Glass");

		public static readonly CachedLayerMask LineOfSightMask = new CachedLayerMask("Default", "Door");

		public static RoleTypeId GetRoleId(this ReferenceHub hub)
		{
			return hub.roleManager.CurrentRole.RoleTypeId;
		}

		public static Team GetTeam(this ReferenceHub hub)
		{
			return hub.roleManager.CurrentRole.Team;
		}

		public static Team GetTeam(this RoleTypeId role)
		{
			if (!role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				return Team.OtherAlive;
			}
			return result.Team;
		}

		public static Faction GetFaction(this ReferenceHub hub)
		{
			return hub.GetTeam().GetFaction();
		}

		public static Faction GetFaction(this RoleTypeId role)
		{
			return role.GetTeam().GetFaction();
		}

		public static Faction GetFaction(this Team t)
		{
			switch (t)
			{
			case Team.SCPs:
				return Faction.SCP;
			case Team.Flamingos:
				return Faction.Flamingos;
			case Team.FoundationForces:
			case Team.Scientists:
				return Faction.FoundationStaff;
			case Team.ChaosInsurgency:
			case Team.ClassD:
				return Faction.FoundationEnemy;
			default:
				return Faction.Unclassified;
			}
		}

		public static bool IsHuman(this RoleTypeId role)
		{
			Team team = role.GetTeam();
			if (team != Team.Dead && team != Team.SCPs)
			{
				return !role.IsFlamingo();
			}
			return false;
		}

		public static bool IsHuman(this ReferenceHub hub)
		{
			return hub.roleManager.CurrentRole.RoleTypeId.IsHuman();
		}

		public static bool IsFlamingo(this RoleTypeId role, bool ignoreScpTeam = true)
		{
			switch (role.GetTeam())
			{
			case Team.Flamingos:
				return true;
			case Team.SCPs:
				if (role == RoleTypeId.ZombieFlamingo)
				{
					return !ignoreScpTeam;
				}
				return false;
			case Team.FoundationForces:
				return role == RoleTypeId.NtfFlamingo;
			case Team.ChaosInsurgency:
				return role == RoleTypeId.ChaosFlamingo;
			default:
				return false;
			}
		}

		public static bool IsFlamingo(this ReferenceHub hub, bool ignoreScpTeam = true)
		{
			return hub.roleManager.CurrentRole.RoleTypeId.IsFlamingo(ignoreScpTeam);
		}

		public static bool IsZombie(this RoleTypeId role)
		{
			if (role != RoleTypeId.ZombieFlamingo)
			{
				return role == RoleTypeId.Scp0492;
			}
			return true;
		}

		public static bool IsAlive(this RoleTypeId role)
		{
			return role.GetTeam() != Team.Dead;
		}

		public static bool IsAlive(this ReferenceHub hub)
		{
			return hub.GetTeam() != Team.Dead;
		}

		public static bool IsSCP(this ReferenceHub hub, bool includeZombies = true)
		{
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (currentRole.Team != Team.SCPs)
			{
				return false;
			}
			if (!includeZombies && currentRole.RoleTypeId.IsZombie())
			{
				return false;
			}
			return true;
		}

		public static CharacterModel GetModel(this ReferenceHub hub)
		{
			return (hub.roleManager.CurrentRole as IFpcRole)?.FpcModule.CharacterModelInstance;
		}

		public static void ForEachRole<T>(Action<ReferenceHub, T> action) where T : PlayerRoleBase
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is T arg)
				{
					action?.Invoke(allHub, arg);
				}
			}
		}

		public static void ForEachRole<T>(Action<T> action) where T : PlayerRoleBase
		{
			ForEachRole((ReferenceHub x, T y) =>
			{
				action?.Invoke(y);
			});
		}

		public static void ForEachRole<T>(Action<ReferenceHub> action) where T : PlayerRoleBase
		{
			ForEachRole((ReferenceHub x, T y) =>
			{
				action?.Invoke(x);
			});
		}

		public static string GetColoredName(this PlayerRoleBase role)
		{
			return "<color=" + role.RoleColor.ToHex() + ">" + role.RoleName + "</color>";
		}

		public static bool IsLastScpTarget(this ReferenceHub hub)
		{
			if (hub.IsHuman())
			{
				return LastHumanTracker.IsLastTarget(hub);
			}
			return false;
		}
	}
}
