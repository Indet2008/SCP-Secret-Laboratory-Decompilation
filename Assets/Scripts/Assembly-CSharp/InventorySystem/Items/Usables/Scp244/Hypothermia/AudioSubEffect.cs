using System.Diagnostics;
using AudioPooling;
using CustomPlayerEffects;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244.Hypothermia
{
	public class AudioSubEffect : HypothermiaSubEffectBase, ISoundtrackMutingEffect
	{
		[SerializeField]
		private TemperatureSubEffect _temperature;

		[SerializeField]
		private AudioSource _fogSoundtrack;

		[SerializeField]
		private float _soundtrackFadeSpeed;

		[SerializeField]
		private AudioClip _enterFogSound;

		[SerializeField]
		private AnimationCurve _shakingOverTemperature;

		[SerializeField]
		private AudioSource _shakingSoundSource;

		[SerializeField]
		private float _thirdpersonShakeVolume;

		private bool _prevExposed;

		private readonly Stopwatch _enterSfxCooldown = Stopwatch.StartNew();

		private const float SfxCooldown = 1.5f;

		public bool MuteSoundtrack { get; private set; }

		public override bool IsActive => false;

		private static void SetVolume(AudioSource src, float volume)
		{
			src.volume = volume;
			bool flag = volume > 0f;
			if (src.isPlaying != flag)
			{
				if (flag)
				{
					src.Play();
				}
				else
				{
					src.Stop();
				}
			}
		}

		private void UpdateShake(float curTemp)
		{
			if (!base.Hub.IsHuman())
			{
				curTemp = 0f;
			}
			float num = _shakingOverTemperature.Evaluate(curTemp);
			float num2 = (base.IsLocalPlayer ? 1f : _thirdpersonShakeVolume);
			SetVolume(_shakingSoundSource, num * num2);
		}

		private void UpdateExposure(bool isExposed)
		{
			if (!base.IsLocalPlayer || !base.Hub.IsAlive())
			{
				isExposed = false;
			}
			MuteSoundtrack = isExposed;
			float volume = Mathf.Lerp(_fogSoundtrack.volume, isExposed ? 1 : 0, Time.deltaTime * _soundtrackFadeSpeed);
			SetVolume(_fogSoundtrack, volume);
			if (isExposed == _prevExposed)
			{
				return;
			}
			_prevExposed = isExposed;
			if (isExposed)
			{
				if (_enterSfxCooldown.Elapsed.TotalSeconds > 1.5)
				{
					AudioSourcePoolManager.Play2D(_enterFogSound);
				}
			}
			else
			{
				_enterSfxCooldown.Restart();
			}
		}

		internal override void UpdateEffect(float curExposure)
		{
			UpdateExposure(curExposure > 0f);
			UpdateShake(_temperature.CurTemperature);
		}
	}
}
