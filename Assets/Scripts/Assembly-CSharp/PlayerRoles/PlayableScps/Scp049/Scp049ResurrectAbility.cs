using System.Collections.Generic;
using LabApi.Events.Arguments.Scp049Events;
using LabApi.Events.Handlers;
using LabApi.Features.Wrappers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.PlayableScps.Scp049.Zombies;
using PlayerRoles.PlayableScps.Scp1507;
using PlayerRoles.PlayableScps.Scp3114;
using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049ResurrectAbility : RagdollAbilityBase<Scp049Role>
	{
		private enum ResurrectError
		{
			None = 0,
			TargetNull = 1,
			Expired = 2,
			MaxReached = 3,
			Refused = 4,
			TargetInvalid = 5
		}

		public const int MaxResurrections = 2;

		private const float TargetCorpseDuration = 18f;

		private const float HumanCorpseDuration = 12f;

		private const float ResurrectTargetReward = 200f;

		private const float MaxRespawnGroundDistance = 1f;

		private static readonly Dictionary<uint, int> ResurrectedPlayers = new Dictionary<uint, int>();

		private static readonly HashSet<uint> DeadZombies = new HashSet<uint>();

		private static bool _maskSet;

		private static int _mask;

		private Scp049SenseAbility _senseAbility;

		[SerializeField]
		private AudioSource _surgerySource;

		protected override float RangeSqr => 3.5f;

		protected override float Duration => 7f;

		private static int GroundMask
		{
			get
			{
				if (!_maskSet)
				{
					_mask = LayerMask.GetMask("Default");
					_maskSet = true;
				}
				return _mask;
			}
		}

		protected override void ServerComplete()
		{
			ReferenceHub ownerHub = base.CurRagdoll.Info.OwnerHub;
			Scp049ResurrectingBodyEventArgs e = new Scp049ResurrectingBodyEventArgs(Ragdoll.Get(base.CurRagdoll), ownerHub, base.Owner);
			Scp049Events.OnResurrectingBody(e);
			if (e.IsAllowed)
			{
				ownerHub = e.Target.ReferenceHub;
				ownerHub.transform.position = base.CastRole.FpcModule.Position;
				if (_senseAbility.DeadTargets.Contains(ownerHub))
				{
					HumeShieldModuleBase humeShieldModule = base.CastRole.HumeShieldModule;
					humeShieldModule.HsCurrent = Mathf.Min(humeShieldModule.HsCurrent + 200f, humeShieldModule.HsMax);
				}
				RoleTypeId newRole = RoleTypeId.Scp0492;
				if (base.CurRagdoll is Scp1507Ragdoll)
				{
					newRole = RoleTypeId.ZombieFlamingo;
				}
				ownerHub.roleManager.ServerSetRole(newRole, RoleChangeReason.Revived);
				if (!Physics.Raycast(ownerHub.transform.position, Vector3.down, 1f, GroundMask))
				{
					ownerHub.TryOverridePosition(base.CastRole.transform.position);
				}
				NetworkServer.Destroy(base.CurRagdoll.gameObject);
				Scp049Events.OnResurrectedBody(new Scp049ResurrectedBodyEventArgs(ownerHub, base.Owner));
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp049SenseAbility>(out _senseAbility);
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			ClientTryStart();
		}

		protected override void OnKeyUp()
		{
			base.OnKeyUp();
			ClientTryCancel();
		}

		public bool CheckRagdoll(BasicRagdoll ragdoll)
		{
			return CheckBeginConditions(ragdoll) == ResurrectError.None;
		}

		protected override byte ServerValidateBegin(BasicRagdoll ragdoll)
		{
			ResurrectError resurrectError = CheckBeginConditions(ragdoll);
			if (!ServerValidateAny())
			{
				resurrectError = ResurrectError.TargetNull;
			}
			Scp049StartingResurrectionEventArgs e = new Scp049StartingResurrectionEventArgs(resurrectError == ResurrectError.None, ragdoll, ragdoll.Info.OwnerHub, base.Owner);
			Scp049Events.OnStartingResurrection(e);
			if (!e.IsAllowed)
			{
				return 1;
			}
			resurrectError = ((!e.CanResurrect) ? ResurrectError.TargetInvalid : ResurrectError.None);
			return (byte)resurrectError;
		}

		protected override bool ServerValidateAny()
		{
			if (base.CurRagdoll == null)
			{
				return false;
			}
			ReferenceHub ownerHub = base.CurRagdoll.Info.OwnerHub;
			if (ownerHub != null && base.ServerValidateAny() && IsSpawnableSpectator(ownerHub) && CheckMaxResurrections(ownerHub) == ResurrectError.None)
			{
				return !AnyConflicts(base.CurRagdoll);
			}
			return false;
		}

		private ResurrectError CheckBeginConditions(BasicRagdoll ragdoll)
		{
			ReferenceHub ownerHub = ragdoll.Info.OwnerHub;
			bool flag = ownerHub == null;
			if (ragdoll.Info.RoleType == RoleTypeId.Scp0492)
			{
				if (flag || !DeadZombies.Contains(ownerHub.netId))
				{
					return ResurrectError.TargetNull;
				}
				if (!(ragdoll.Info.Handler is AttackerDamageHandler))
				{
					return ResurrectError.TargetInvalid;
				}
			}
			else
			{
				float num = ((!flag && _senseAbility.DeadTargets.Contains(ownerHub)) ? 18f : 12f);
				if (ragdoll.Info.ExistenceTime > num)
				{
					return ResurrectError.Expired;
				}
				if (!IsResurrectableRole(ragdoll.Info.RoleType))
				{
					return ResurrectError.TargetInvalid;
				}
				if (flag || AnyConflicts(ragdoll))
				{
					return ResurrectError.TargetNull;
				}
				if (!IsSpawnableSpectator(ownerHub))
				{
					return ResurrectError.TargetInvalid;
				}
			}
			return CheckMaxResurrections(ownerHub);
		}

		private ResurrectError CheckMaxResurrections(ReferenceHub owner)
		{
			int resurrectionsNumber = GetResurrectionsNumber(owner);
			if (resurrectionsNumber < 2)
			{
				return ResurrectError.None;
			}
			if (resurrectionsNumber <= 2)
			{
				return ResurrectError.MaxReached;
			}
			return ResurrectError.Refused;
		}

		private bool AnyConflicts(BasicRagdoll ragdoll)
		{
			if (ragdoll.Info.Handler is Scp3114DamageHandler { Subtype: Scp3114DamageHandler.HandlerType.SkinSteal })
			{
				return true;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is Scp3114Role { SkeletonIdle: false } scp3114Role && !(scp3114Role.CurIdentity.Ragdoll != ragdoll))
				{
					return true;
				}
			}
			return false;
		}

		private static bool IsSpawnableSpectator(ReferenceHub hub)
		{
			if (hub.roleManager.CurrentRole is SpectatorRole spectatorRole)
			{
				return spectatorRole.ReadyToRespawn;
			}
			return false;
		}

		private static bool IsResurrectableRole(RoleTypeId role)
		{
			if (!role.IsFlamingo())
			{
				return role.IsHuman();
			}
			return true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnServerRoleSet += (ReferenceHub hub, RoleTypeId newRole, RoleChangeReason changeReason) =>
			{
				if (newRole == RoleTypeId.Overwatch || newRole.IsHuman())
				{
					ClearPlayerResurrections(hub);
				}
			};
			CustomNetworkManager.OnClientReady += DeadZombies.Clear;
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				DeadZombies.Remove(hub.netId);
			};
			PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole) =>
			{
				if (NetworkServer.active)
				{
					if (prevRole is ZombieRole && newRole is SpectatorRole)
					{
						DeadZombies.Add(hub.netId);
					}
					else
					{
						DeadZombies.Remove(hub.netId);
					}
				}
			};
		}

		public static int GetResurrectionsNumber(ReferenceHub hub)
		{
			if (!ResurrectedPlayers.TryGetValue(hub.netId, out var value))
			{
				return 0;
			}
			return value;
		}

		public static void RegisterPlayerResurrection(ReferenceHub hub, int amount = 1)
		{
			ResurrectedPlayers[hub.netId] = GetResurrectionsNumber(hub) + amount;
		}

		public static void ClearPlayerResurrections(ReferenceHub hub)
		{
			ResurrectedPlayers.Remove(hub.netId);
		}
	}
}
