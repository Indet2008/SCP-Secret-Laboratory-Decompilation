using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Rewards
{
	public static class TeammateProtectionRewards
	{
		private class TrackedTeammate
		{
			public readonly ReferenceHub Hub;

			public readonly FpcStandardRoleBase Role;

			private readonly Dictionary<uint, double> _attackers;

			private const float MinDamage = 100f;

			private const float TimeTolerance = 6f;

			private const int AttackersLimit = 5;

			private double _lastDamageTime;

			private float _damageReceived;

			private static readonly Vector3[] AttackersNonAlloc = new Vector3[5];

			public TrackedTeammate(ReferenceHub ply)
			{
				Hub = ply;
				Role = ply.roleManager.CurrentRole as FpcStandardRoleBase;
				_attackers = new Dictionary<uint, double>();
				Hub.playerStats.OnThisPlayerDamaged += OnDamaged;
			}

			public void Unsubscribe()
			{
				if (!(Hub == null))
				{
					Hub.playerStats.OnThisPlayerDamaged -= OnDamaged;
				}
			}

			public int GetAttackersNonAlloc(out Vector3[] attackersPositions)
			{
				attackersPositions = AttackersNonAlloc;
				if (NetworkTime.time > _lastDamageTime || _damageReceived < 100f)
				{
					return 0;
				}
				int num = 0;
				foreach (KeyValuePair<uint, double> attacker in _attackers)
				{
					if (!(attacker.Value > _lastDamageTime) && ReferenceHub.TryGetHubNetID(attacker.Key, out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole)
					{
						AttackersNonAlloc[num] = fpcRole.FpcModule.Position;
						if (++num >= 5)
						{
							break;
						}
					}
				}
				_attackers.Clear();
				_damageReceived = 0f;
				return num;
			}

			private void OnDamaged(DamageHandlerBase dhb)
			{
				if (dhb is AttackerDamageHandler attackerDamageHandler && !(dhb is Scp018DamageHandler) && !(dhb is ExplosionDamageHandler))
				{
					double time = NetworkTime.time;
					if (time > _lastDamageTime)
					{
						_damageReceived = 0f;
					}
					_damageReceived += attackerDamageHandler.DealtHealthDamage;
					_lastDamageTime = time + 6.0;
					_attackers[attackerDamageHandler.Attacker.NetId] = _lastDamageTime;
				}
			}
		}

		private const float Cooldown = 10f;

		private static readonly int[] Rewards = new int[6] { 0, 10, 15, 25, 40, 60 };

		private static readonly HashSet<TrackedTeammate> Teammates = new HashSet<TrackedTeammate>();

		private static double _grantTargetCooldown;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Scp079DoorAbility.OnServerAnyDoorInteraction += CheckBlock;
			PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase prev, PlayerRoleBase cur) =>
			{
				if (NetworkServer.active)
				{
					if (ValidateRole(prev))
					{
						Teammates.RemoveWhere((TrackedTeammate x) => x.Hub == hub);
					}
					if (ValidateRole(cur))
					{
						Teammates.Add(new TrackedTeammate(hub));
					}
				}
			};
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				if (NetworkServer.active && ValidateRole(hub.roleManager.CurrentRole))
				{
					Teammates.RemoveWhere((TrackedTeammate x) => x.Hub == hub);
				}
			};
		}

		private static bool ValidateRole(PlayerRoleBase prb)
		{
			if (prb is FpcStandardRoleBase)
			{
				return prb.Team == Team.SCPs;
			}
			return false;
		}

		private static void CheckBlock(Scp079Role scp079, DoorVariant dv)
		{
			if (dv.TargetState)
			{
				return;
			}
			DoorLockReason activeLocks = (DoorLockReason)dv.ActiveLocks;
			if ((!activeLocks.HasFlagFast(DoorLockReason.Lockdown079) && !activeLocks.HasFlagFast(DoorLockReason.Regular079)) || _grantTargetCooldown > NetworkTime.time)
			{
				return;
			}
			int num = 0;
			Transform transform = dv.transform;
			foreach (TrackedTeammate teammate in Teammates)
			{
				int attackersNonAlloc = teammate.GetAttackersNonAlloc(out var attackersPositions);
				if (attackersNonAlloc == 0)
				{
					continue;
				}
				bool flag = transform.InverseTransformPoint(teammate.Role.FpcModule.Position).z > 0f;
				for (int i = 0; i < attackersNonAlloc; i++)
				{
					bool flag2 = transform.InverseTransformPoint(attackersPositions[i]).z > 0f;
					if (flag != flag2)
					{
						num++;
					}
				}
			}
			int num2 = Mathf.Min(num, Rewards.Length - 1);
			Scp079RewardManager.GrantExp(scp079, Rewards[num2], Scp079HudTranslation.ExpGainTeammateProtection);
			_grantTargetCooldown = NetworkTime.time + 10.0;
		}
	}
}
