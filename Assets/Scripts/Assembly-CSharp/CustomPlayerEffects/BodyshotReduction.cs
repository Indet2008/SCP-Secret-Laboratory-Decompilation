using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class BodyshotReduction : StatusEffectBase, ISpectatorDataPlayerEffect, IDamageModifierEffect
	{
		private static readonly float[] Multipliers = new float[5] { 1f, 0.95f, 0.9f, 0.875f, 0.85f };

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool DamageModifierActive => base.IsEnabled;

		private float CurrentMultiplier => Multipliers[Mathf.Min(base.Intensity, Multipliers.Length - 1)];

		public bool GetSpectatorText(out string s)
		{
			s = $"Damage Reduction (Body, -{Mathf.Round((1f - CurrentMultiplier) * 1000f) / 10f}%)";
			return base.IsEnabled;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			if (hitboxType == HitboxType.Body)
			{
				return CurrentMultiplier;
			}
			return 1f;
		}
	}
}
