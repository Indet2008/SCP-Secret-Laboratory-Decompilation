using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public interface IFriendlyFireModifier
	{
		bool AllowFriendlyFire(float baseDamage, AttackerDamageHandler handler, HitboxType hitboxType);
	}
}
