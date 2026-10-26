using System;

namespace CustomPlayerEffects
{
	public class HeavyFooted : StatusEffectBase, IJumpModifierEffect
	{
		public override EffectClassification Classification => EffectClassification.Technical;

		public float JumpStrengthMultplier => Math.Max(1f - (float)(int)base.Intensity * 0.01f, 0f);
	}
}
