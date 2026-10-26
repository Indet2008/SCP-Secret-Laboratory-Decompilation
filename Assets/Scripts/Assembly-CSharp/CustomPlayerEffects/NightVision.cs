namespace CustomPlayerEffects
{
	public class NightVision : StatusEffectBase, IAmbientBoostingEffect
	{
		public override EffectClassification Classification => EffectClassification.Technical;

		public float AmbientBoostAddition => (float)(int)base.Intensity * 0.01f;
	}
}
