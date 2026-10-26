using UnityEngine;

namespace CustomPlayerEffects
{
	public class AmnesiaVision : StatusEffectBase, ISoundtrackMutingEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AnimationCurve _whispersOverTime;

		[global::UnityEngine.SerializeField]
		private float _soundtrackLerp;

		[global::UnityEngine.SerializeField]
		private float _growlDetectionRangeSqr;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _whispersSource;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _growlSource;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _disableSource;


		private float _lastTime;

		public bool MuteSoundtrack => false;

		public float LastActive => Time.timeSinceLevelLoad - _lastTime;

		protected override void Enabled()
		{
			base.Enabled();
			_lastTime = Time.timeSinceLevelLoad;
		}
	}
}
