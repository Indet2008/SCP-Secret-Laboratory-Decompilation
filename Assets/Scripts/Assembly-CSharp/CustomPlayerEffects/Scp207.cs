using System.Collections.Generic;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using RemoteAdmin.Interfaces;

namespace CustomPlayerEffects
{
	public class Scp207 : CokeBase<Scp207Stack>, ISpectatorDataPlayerEffect, IStaminaModifier, ICustomDisplayName
	{
		public override Dictionary<PlayerMovementState, float> StateMultipliers { get; } = new Dictionary<PlayerMovementState, float>
		{
			[PlayerMovementState.Sprinting] = 1f,
			[PlayerMovementState.Walking] = 0.6f,
			[PlayerMovementState.Sneaking] = 0.15f,
			[PlayerMovementState.Crouching] = 0.1f
		};

		public override EffectClassification Classification => EffectClassification.Mixed;

		public override float MovementSpeedMultiplier => base.CurrentStack.SpeedMultiplier;

		public string DisplayName => "SCP-207";

		public bool CanBeDisplayed => true;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 0f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => false;

		public bool GetSpectatorText(out string s)
		{
			s = ((base.Intensity > 1) ? $"SCP-207 (x{base.Intensity})" : "SCP-207");
			return true;
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (NetworkServer.active && base.Hub.playerStats.TryGetModule<StaminaStat>(out var module))
			{
				module.CurValue = module.MaxValue;
			}
		}

		protected override void OnTick()
		{
			if (NetworkServer.active && !Vitality.CheckPlayer(base.Hub))
			{
				float damage = base.CurrentStack.DamageAmount * GetMovementStateMultiplier();
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(damage, DeathTranslations.Scp207));
			}
		}
	}
}
