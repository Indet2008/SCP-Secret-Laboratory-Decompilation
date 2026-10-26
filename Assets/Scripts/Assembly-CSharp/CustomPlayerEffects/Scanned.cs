using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scanned : StatusEffectBase, ISoundtrackMutingEffect
	{
		[SerializeField]
		private AudioSource _soundSource;

		public bool MuteSoundtrack => base.IsEnabled;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public override EffectClassification Classification => EffectClassification.Technical;

		protected override void Enabled()
		{
			base.Enabled();
			UpdateSourceMute();
			_soundSource.Play();
		}

		protected override void Disabled()
		{
			base.Disabled();
			_soundSource.mute = true;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			UpdateSourceMute();
		}

		private void UpdateSourceMute()
		{
			_soundSource.mute = !base.IsLocalPlayer && !base.IsSpectated;
		}
	}
}
