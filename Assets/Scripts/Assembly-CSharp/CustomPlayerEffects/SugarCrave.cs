using InventorySystem.Items.MarshmallowMan;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SugarCrave : StatusEffectBase, IStaminaModifier, IHolidayEffect
	{
		private const int AhpAmount = 450;

		private const float StaminaUseRate = 1f / 15f;

		private const float StaminaKillAddition = 0.4666667f;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 0f;

		public float StaminaRegenMultiplier => 0f;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
		{
			HolidayType.Halloween,
			HolidayType.Christmas
		};

		private StaminaStat StaminaStat => base.Hub.playerStats.GetModule<StaminaStat>();

		protected override void Enabled()
		{
			base.Enabled();
			if (NetworkServer.active)
			{
				AhpStat module = base.Hub.playerStats.GetModule<AhpStat>();
				module.ServerKillAllProcesses();
				module.ServerAddProcess(450f, 450f, 0f, 1f, 0f, persistant: false);
				StaminaStat staminaStat = StaminaStat;
				staminaStat.CurValue = staminaStat.MaxValue;
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			if (NetworkServer.active)
			{
				base.Hub.playerStats.GetModule<AhpStat>().ServerKillAllProcesses();
				MarshmallowEffect effect = base.Hub.playerEffectsController.GetEffect<MarshmallowEffect>();
				byte intensity = effect.Intensity;
				if (intensity != 0 && intensity != byte.MaxValue)
				{
					effect.Intensity = byte.MaxValue;
					effect.ServerChangeDuration(1.1f);
				}
			}
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (NetworkServer.active)
			{
				StaminaStat staminaStat = StaminaStat;
				float num = staminaStat.CurValue - 1f / 15f * Time.deltaTime;
				if (num < 0f)
				{
					DisableEffect();
				}
				else
				{
					staminaStat.CurValue = num;
				}
			}
		}

		public void OnKill()
		{
			if (base.IsEnabled)
			{
				StaminaStat staminaStat = StaminaStat;
				staminaStat.CurValue = Mathf.Min(staminaStat.MaxValue, staminaStat.CurValue + 0.4666667f);
			}
		}
	}
}
