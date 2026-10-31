using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public class Burned : StatusEffectBase, IHealableEffect, IDamageModifierEffect
	{
		private const float BaseDamageMultiplier = 1.25f;

		private TiltShiftWave _tiltShiftOffsetWave;

		private bool _initialized;

		public float DamageMultiplier => 0.25f * RainbowTaste.CurrentMultiplier(base.Hub) + 1f;

		public bool DamageModifierActive => base.IsEnabled;

		protected override void Awake()
		{
			base.Awake();
			if (base.Hub.isLocalPlayer)
			{
				_tiltShiftOffsetWave = GetComponent<TiltShiftWave>();
				_initialized = true;
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (base.Hub.isLocalPlayer && _initialized)
			{
				_tiltShiftOffsetWave.EnableEffect();
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			if (base.Hub.isLocalPlayer && _initialized)
			{
				_tiltShiftOffsetWave.DisableEffect();
			}
		}

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
