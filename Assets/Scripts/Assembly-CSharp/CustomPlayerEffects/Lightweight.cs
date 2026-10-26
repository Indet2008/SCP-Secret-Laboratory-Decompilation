namespace CustomPlayerEffects
{
	public class Lightweight : StatusEffectBase, IJumpModifierEffect
	{
		public override EffectClassification Classification => EffectClassification.Technical;

		public float JumpStrengthMultplier => 1f + (float)(int)base.Intensity * 0.01f;
	}
}
