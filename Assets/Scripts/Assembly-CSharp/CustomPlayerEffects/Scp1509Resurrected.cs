using PlayerStatsSystem;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scp1509Resurrected : StatusEffectBase, ICustomDisplayName, IDamageModifierEffect
	{
		private const float DamageImmunityTime = 3f;

		private AhpStat _ahpStat;

		private HealthStat _hpStat;

		private double _lastSaveTime;

		public string DisplayName => "SCP-1509 Resurrected";

		public bool CanBeDisplayed => true;

		public override EffectClassification Classification => EffectClassification.Technical;

		private bool IsImmunityActive => _lastSaveTime + 3.0 >= (double)Time.timeSinceLevelLoad;

		public bool DamageModifierActive => IsImmunityActive;

		protected override void Enabled()
		{
			base.Hub.playerStats.TryGetModule<HealthStat>(out _hpStat);
			base.Hub.playerStats.TryGetModule<AhpStat>(out _ahpStat);
			_hpStat.MaxValue = 75f;
			_ahpStat.MaxValue = 25f;
			_ahpStat.ServerAddProcess(25f, 25f, 0f, 0.7f, 0f, persistant: false);
			_lastSaveTime = Time.timeSinceLevelLoad;
		}

		protected override void OnEffectUpdate()
		{
			if (_ahpStat.MaxValue != 25f)
			{
				_ahpStat.MaxValue = 25f;
			}
			if (_hpStat.MaxValue != 75f)
			{
				_hpStat.MaxValue = 75f;
			}
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			if (handler is StandardDamageHandler { Damage: -1f })
			{
				return 1f;
			}
			if (IsImmunityActive)
			{
				return 0f;
			}
			if (base.IsEnabled)
			{
				return 0f;
			}
			return 1f;
		}
	}
}
