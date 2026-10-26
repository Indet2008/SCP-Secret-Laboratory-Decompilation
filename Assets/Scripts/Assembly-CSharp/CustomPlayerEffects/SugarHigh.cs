using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SugarHigh : TickingEffectBase, ISoundtrackMutingEffect, IHolidayEffect
	{
		private const float PassiveRegenHealthThreshold = 100f;

		private const float MaxHealthAddition = 200f;

		private const float HealthRegen = 6f;

		private const float DisableTime = 10f;

		[SerializeField]
		private AudioSource _soundSource;

		private HealthStat _healthStat;

		private float _disabledCounter;

		private float _cachedMaxHealth;

		private bool _beingDisabled;

		public bool MuteSoundtrack => base.IsEnabled;

		public override EffectClassification Classification => EffectClassification.Positive;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		protected override void Enabled()
		{
			base.Enabled();
			if (!(base.Hub.roleManager.CurrentRole is HumanRole))
			{
				return;
			}
			UpdateSourceMute();
			_soundSource.Play();
			if (NetworkServer.active)
			{
				_healthStat = base.Hub.playerStats.GetModule<HealthStat>();
				if (_beingDisabled)
				{
					ServerResetRemaining();
				}
				_cachedMaxHealth = _healthStat.MaxValue;
				_healthStat.MaxValue += 200f;
				_healthStat.ServerHeal(200f);
				PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			}
		}

		protected override void Disabled()
		{
			_soundSource.Stop();
			if (NetworkServer.active)
			{
				PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
				if (base.Hub.roleManager.CurrentRole is HumanRole)
				{
					_beingDisabled = true;
					_disabledCounter = 0f;
				}
			}
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			UpdateSourceMute();
		}

		private void UpdateSourceMute()
		{
			_soundSource.mute = !base.IsLocalPlayer && !base.IsSpectated;
		}

		protected override void OnTick()
		{
			if (NetworkServer.active && _healthStat != null && _healthStat.CurValue >= 100f)
			{
				_healthStat.ServerHeal(6f);
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (NetworkServer.active && !(hub != base.Hub))
			{
				_beingDisabled = false;
			}
		}

		private void ServerResetRemaining()
		{
			if (NetworkServer.active && _beingDisabled)
			{
				float num = 1f - _disabledCounter / 10f;
				float num2 = 200f * num;
				_healthStat.MaxValue -= num2;
				_healthStat.MaxValue = Mathf.Max(_cachedMaxHealth, _healthStat.MaxValue);
				_healthStat.CurValue = Mathf.Min(_healthStat.CurValue, _healthStat.MaxValue);
				_beingDisabled = false;
				_disabledCounter = 0f;
			}
		}

		private void LateUpdate()
		{
			if (NetworkServer.active && _beingDisabled && _healthStat != null)
			{
				float num = 20f * Time.deltaTime;
				float a = _healthStat.MaxValue - num;
				_healthStat.MaxValue = Mathf.Max(a, _cachedMaxHealth);
				_disabledCounter += Time.deltaTime;
				if (!(_disabledCounter < 10f))
				{
					_beingDisabled = false;
				}
			}
		}
	}
}
