namespace CustomPlayerEffects
{
	public class SoundtrackMute : StatusEffectBase, ISoundtrackMutingEffect
	{
		public override EffectClassification Classification => EffectClassification.Technical;

		public bool MuteSoundtrack => base.IsEnabled;
	}
}
