using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using FacilitySoundtrack.ChaseThemes;
using PlayerRoles.PlayableScps.Subroutines;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106ChaseThemeProvider : FpcStandardChaseThemeProvider<Scp106Role>
	{
		private const float FxIntensityInLerp = 10f;

		private const float FxIntensityOutLerp = 0.15f;

		private const float ChaseDesaturation = -90f;

		private const float NormalDesaturation = -40f;

		private Traumatized _traumatizedCache;

		private ColorAdjustments _colorCache;

		private bool _chaseActive;

		private bool _playTraumatizedTheme;

		[SerializeField]
		private StingerThresholdPair[] _stingers;

		[SerializeField]
		private AudioClip _normalClip;

		[SerializeField]
		private AudioClip _traumatizedClip;

		public override bool TryStartChase()
		{
			if (base.TryStartChase())
			{
				return !base.ScpRole.Sinkhole.TargetSubmerged;
			}
			return false;
		}

		public override AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			base.OnChaseStarted(alreadyPlayedStingers);
			_chaseActive = true;
			UpdateTraumatized(skipVisualEffects: true);
			if (alreadyPlayedStingers.Count > 0)
			{
				return null;
			}
			if (!Scp106SinkholeController.TryTriggerCooldown())
			{
				return null;
			}
			return FpcStandardChaseThemeProvider<Scp106Role>.PlayStinger(StingerThresholdPair.GetBest(_stingers, GetPerceivedJumpscareDistance()).Clip);
		}

		public override bool UpdateChase()
		{
			base.ClipsToPlay.Clear();
			AudioClip clip = (_playTraumatizedTheme ? _traumatizedClip : _normalClip);
			base.ClipsToPlay.Add(new DesiredChaseClip(clip));
			return base.UpdateChase();
		}

		public override void OnChaseStopped()
		{
			base.OnChaseStopped();
			_chaseActive = false;
		}

		private void Update()
		{
			UpdateTraumatized();
		}

		private void UpdateTraumatized(bool skipVisualEffects = false)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				if (_traumatizedCache == null)
				{
					_traumatizedCache = hub.playerEffectsController.GetEffect<Traumatized>();
					_traumatizedCache.PPVolume.profile.TryGet<ColorAdjustments>(out _colorCache);
				}
				_playTraumatizedTheme = _chaseActive && !base.ScpRole.Sinkhole.TargetSubmerged && _traumatizedCache.IsEnabled;
				float num = (_playTraumatizedTheme ? (-90f) : (-40f));
				float value = _colorCache.saturation.value;
				if (!skipVisualEffects && !(Mathf.Abs(num - value) < 0.1f))
				{
					float num2 = (_playTraumatizedTheme ? 10f : 0.15f);
					_colorCache.saturation.value = Mathf.Lerp(value, num, num2 * Time.deltaTime);
				}
			}
		}
	}
}
