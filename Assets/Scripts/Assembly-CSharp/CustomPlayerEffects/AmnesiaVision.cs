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

		// Client half restored from the client build (IL2CPP): whispers fade in over time while affected,
		// and a "disable" cue plays when the effect ends.
		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (!IsPOV)
			{
				StopSources();
				return;
			}
			if (!_whispersSource.isPlaying)
			{
				_whispersSource.Play();
			}
			float target = _whispersOverTime.Evaluate(Time.timeSinceLevelLoad - _lastTime);
			_whispersSource.volume = Mathf.MoveTowards(_whispersSource.volume, target, Time.deltaTime * _soundtrackLerp);
		}

		protected override void Disabled()
		{
			base.Disabled();
			_growlSource.Stop();
			_whispersSource.Stop();
			if (IsPOV && _whispersSource.volume > 0f)
			{
				_disableSource.Play();
			}
			_whispersSource.volume = 0f;
		}

		private void StopSources()
		{
			_whispersSource.Stop();
			_growlSource.Stop();
			_disableSource.Stop();
		}
	}
}
