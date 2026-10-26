using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public interface IDamageModifierEffect
	{
		bool DamageModifierActive { get; }

		float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType);
	}
}
