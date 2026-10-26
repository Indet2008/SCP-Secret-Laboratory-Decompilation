using System.Collections.Generic;
using Mirror;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507SwarmAbility : StandardSubroutine<Scp1507Role>
	{
		private const float RegenCombatCooldown = 0.7f;

		private const float EffectRange = 7.5f;

		private const float BaseHealthRegenRate = 1f;

		private const float EffectRangeSqr = 56.25f;

		private const float AdjustSpeed = 0.6f;

		private readonly HashSet<Scp1507Role> _nearbyFlamingos = new HashSet<Scp1507Role>();

		private readonly HashSet<Scp1507Role> _entireFlock = new HashSet<Scp1507Role>();

		private byte _flockSize;

		private float _regenCooldown;

		private HealthStat _healthStat;

		public int FlockSize => _flockSize;

		public float Multiplier { get; private set; }

		private void UpdateMultiplier()
		{
			Multiplier = Mathf.MoveTowards(Multiplier, FlockSize, 0.6f * Time.deltaTime);
		}

		private void Update()
		{
			UpdateMultiplier();
			if (NetworkServer.active)
			{
				ServerUpdateNearby();
				ServerUpdateFlock();
				ServerUpdateHealthRegen();
			}
		}

		private void ServerUpdateNearby()
		{
			Team team = base.Owner.GetTeam();
			Vector3 position = base.CastRole.FpcModule.Position;
			_nearbyFlamingos.Clear();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is Scp1507Role scp1507Role && scp1507Role.Team == team)
				{
					Vector3 position2 = scp1507Role.FpcModule.Position;
					if (!((position - position2).sqrMagnitude > 56.25f))
					{
						_nearbyFlamingos.Add(scp1507Role);
					}
				}
			}
		}

		private void ServerUpdateFlock()
		{
			_entireFlock.Clear();
			foreach (Scp1507Role nearbyFlamingo in _nearbyFlamingos)
			{
				_entireFlock.Add(nearbyFlamingo);
				if (!nearbyFlamingo.SubroutineModule.TryGetSubroutine<Scp1507SwarmAbility>(out var subroutine))
				{
					continue;
				}
				foreach (Scp1507Role nearbyFlamingo2 in subroutine._nearbyFlamingos)
				{
					_entireFlock.Add(nearbyFlamingo2);
				}
			}
			int num = Mathf.Max(0, _entireFlock.Count - 1);
			if (num != _flockSize)
			{
				_flockSize = (byte)num;
				ServerSendRpc(toAll: true);
			}
		}

		private void ServerUpdateHealthRegen()
		{
			if (_regenCooldown >= 0.7f)
			{
				_regenCooldown -= Time.deltaTime;
			}
			else
			{
				_healthStat.ServerHeal(Multiplier * 1f * Time.deltaTime);
			}
		}

		private void OnPlayerDamaged(ReferenceHub victim, DamageHandlerBase dhb)
		{
			if (victim == base.Owner)
			{
				InitiateCombatTime();
			}
			else if (dhb is AttackerDamageHandler attackerDamageHandler && !(attackerDamageHandler.Attacker.Hub != base.Owner))
			{
				InitiateCombatTime();
			}
		}

		private void InitiateCombatTime()
		{
			_regenCooldown = 0.7f;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte(_flockSize);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_flockSize = reader.ReadByte();
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (NetworkServer.active)
			{
				_healthStat = base.Owner.playerStats.GetModule<HealthStat>();
				PlayerStats.OnAnyPlayerDamaged += OnPlayerDamaged;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_flockSize = 0;
			Multiplier = 0f;
			_nearbyFlamingos.Clear();
			_entireFlock.Clear();
			PlayerStats.OnAnyPlayerDamaged -= OnPlayerDamaged;
		}
	}
}
