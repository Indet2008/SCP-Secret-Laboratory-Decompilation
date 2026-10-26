using System;
using System.Diagnostics;
using AudioPooling;
using CustomPlayerEffects;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	[Serializable]
	public class ModelShotSettings
	{
		[SerializeField]
		private AudioClip[] _onShotSoundClips;

		[SerializeField]
		private MixerChannel _onShotSoundChannel;

		[SerializeField]
		private float _onShotSoundRange;

		private const float MinCooldown = 0.06f;

		private readonly Stopwatch _lastShot = Stopwatch.StartNew();

		public void PlayOnShotSound(HitboxIdentity hitHitbox, bool firstperson)
		{
			if (_onShotSoundClips.Length != 0 && !(_lastShot.Elapsed.TotalSeconds < 0.05999999865889549))
			{
				if (!TryGetCustomHitSound(hitHitbox.TargetHub, out var clip))
				{
					clip = _onShotSoundClips.RandomItem();
				}
				if (firstperson)
				{
					AudioSourcePoolManager.Play2D(clip, 1f, _onShotSoundChannel);
				}
				else
				{
					AudioSourcePoolManager.PlayOnTransform(clip, hitHitbox.transform, _onShotSoundRange, 1f, FalloffType.Exponential, _onShotSoundChannel);
				}
				_lastShot.Restart();
			}
		}

		private bool TryGetCustomHitSound(ReferenceHub hub, out AudioClip clip)
		{
			clip = null;
			for (int i = 0; i < hub.playerEffectsController.EffectsLength; i++)
			{
				StatusEffectBase statusEffectBase = hub.playerEffectsController.AllEffects[i];
				if (statusEffectBase.IsEnabled && statusEffectBase is ICustomHitSfxEffect customHitSfxEffect)
				{
					clip = customHitSfxEffect.HitSfx;
					return true;
				}
			}
			return false;
		}
	}
}
