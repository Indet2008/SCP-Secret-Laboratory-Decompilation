using CustomPlayerEffects;
using Mirror;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244.Hypothermia
{
	public class DamageSubEffect : HypothermiaSubEffectBase
	{
		private float _damageCounter;

		[SerializeField]
		private TemperatureSubEffect _temperature;

		[SerializeField]
		private AnimationCurve _damageOverTemperature;

		public override bool IsActive => _temperature.IsActive;

		internal override void UpdateEffect(float curExposure)
		{
			if (NetworkServer.active && !SpawnProtected.CheckPlayer(base.Hub) && (!(base.Hub.roleManager.CurrentRole is IHumeShieldedRole humeShieldedRole) || !(humeShieldedRole.HumeShieldModule.HsCurrent > 0f)))
			{
				DealDamage(_temperature.CurTemperature);
			}
		}

		private void DealDamage(float curTemp)
		{
			_damageCounter += Mathf.Max(_damageOverTemperature.Evaluate(curTemp) * Time.deltaTime, 0f);
			if (!(_damageCounter < 1f))
			{
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(_damageCounter, DeathTranslations.Hypothermia));
				_damageCounter = 0f;
			}
		}
	}
}
