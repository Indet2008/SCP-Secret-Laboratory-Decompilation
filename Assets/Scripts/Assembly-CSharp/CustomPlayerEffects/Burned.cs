using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public class Burned : StatusEffectBase, IHealableEffect, IDamageModifierEffect
	{
		private const float BaseDamageMultiplier = 1.25f;

		public float DamageMultiplier => 0.25f * RainbowTaste.CurrentMultiplier(base.Hub) + 1f;

		public bool DamageModifierActive => base.IsEnabled;

		public bool IsHealable(ItemType it)
		{
			if (it != ItemType.Medkit)
			{
				return it == ItemType.SCP500;
			}
			return true;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			return DamageMultiplier;
		}
	}
}
