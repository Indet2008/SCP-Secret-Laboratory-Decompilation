using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	// Restored from the client build (IL2CPP): oscillates one post-process value around its default;
	// when disabled it keeps waving until it is back near the default, then switches itself off.
	public abstract class PostProcessEffectWave : MonoBehaviour
	{
		public float WaveIntensity;

		public float speedMultiplier;

		public float disableTolerance;

		private float _defaultIntensity;

		private float _timer;

		private bool _disabling;

		protected abstract float EffectValue { get; set; }

		protected abstract void SetEffectType(VolumeProfile profile);

		private void Awake()
		{
			Volume volume = GetComponent<Volume>();
			SetEffectType(volume != null ? volume.profile : null);
			_defaultIntensity = EffectValue;
		}

		private void Update()
		{
			if (_disabling && Mathf.Abs(EffectValue - _defaultIntensity) < disableTolerance)
			{
				_disabling = false;
				EffectValue = _defaultIntensity;
				base.enabled = false;
				return;
			}
			_timer += Time.deltaTime * speedMultiplier;
			EffectValue = _defaultIntensity + Mathf.Sin(_timer) * WaveIntensity;
		}

		public void EnableEffect()
		{
			base.enabled = true;
			_disabling = false;
		}

		public void DisableEffect()
		{
			if (base.enabled)
			{
				_disabling = true;
			}
		}
	}
}
