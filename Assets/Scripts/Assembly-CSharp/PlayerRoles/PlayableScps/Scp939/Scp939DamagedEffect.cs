using System.Diagnostics;
using Mirror;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939DamagedEffect : StandardSubroutine<Scp939Role>
	{
		private bool _eventAssigned;

		private HealthStat _hpStat;

		private DynamicHumeShieldController _hume;

		private readonly Stopwatch _lastTriggered = new Stopwatch();

		private float _totalDamageReceived;

		private const float AbsoluteCooldown = 3f;

		private const float HighDamageCooldown = 10f;

		private const float HighDamageThreshold = 90f;

		private const float HighDamageDecay = 80f;

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (NetworkServer.active)
			{
				_lastTriggered.Restart();
				_hpStat = base.Owner.playerStats.GetModule<HealthStat>();
				_hume = base.CastRole.HumeShieldModule as DynamicHumeShieldController;
				_eventAssigned = true;
				base.Owner.playerStats.OnThisPlayerDamaged += OnDamaged;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_eventAssigned)
			{
				_eventAssigned = false;
				base.Owner.playerStats.OnThisPlayerDamaged -= OnDamaged;
			}
		}

		private void Update()
		{
			if (!(_totalDamageReceived <= 0f))
			{
				_totalDamageReceived = Mathf.Clamp(_totalDamageReceived - Time.deltaTime * 80f, 0f, 90f);
			}
		}

		private void OnDamaged(DamageHandlerBase dhb)
		{
			if (dhb is AttackerDamageHandler attackerDamageHandler && !(_hpStat.CurValue <= 0f))
			{
				_totalDamageReceived += attackerDamageHandler.TotalDamageDealt;
				if (!(_lastTriggered.Elapsed.TotalSeconds < 3.0) && CheckDamagedConditions(attackerDamageHandler))
				{
					ServerSendRpc(toAll: true);
					_lastTriggered.Restart();
				}
			}
		}

		private bool CheckDamagedConditions(AttackerDamageHandler adh)
		{
			float time = _hpStat.CurValue + adh.DealtHealthDamage;
			float a = _hume.HsCurrent + adh.AbsorbedHumeDamage;
			float b = _hume.ShieldOverHealth.Evaluate(time);
			if (Mathf.Approximately(a, b))
			{
				return true;
			}
			if (adh.AbsorbedHumeDamage > 0f && _hume.HsCurrent == 0f)
			{
				return true;
			}
			if (_lastTriggered.Elapsed.TotalSeconds > 10.0 && _totalDamageReceived >= 90f)
			{
				return true;
			}
			return false;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)Random.Range(0, 255));
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (base.CastRole.FpcModule.CharacterModelInstance is Scp939Model scp939Model)
			{
				scp939Model.PlayDamagedEffect(reader.ReadByte());
			}
		}
	}
}
