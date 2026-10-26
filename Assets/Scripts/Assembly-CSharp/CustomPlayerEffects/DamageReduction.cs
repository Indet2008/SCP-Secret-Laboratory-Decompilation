using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class DamageReduction : StatusEffectBase, ISpectatorDataPlayerEffect, IDamageModifierEffect
	{
		private float CurrentMultiplier => 1f - (float)(int)base.Intensity * 0.005f;

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool DamageModifierActive => base.IsEnabled;

		public bool GetSpectatorText(out string s)
		{
			s = $"Damage Reduction (All, -{Mathf.Round((1f - CurrentMultiplier) * 1000f) / 10f}%)";
			return base.IsEnabled;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			return CurrentMultiplier;
		}
	}
}
