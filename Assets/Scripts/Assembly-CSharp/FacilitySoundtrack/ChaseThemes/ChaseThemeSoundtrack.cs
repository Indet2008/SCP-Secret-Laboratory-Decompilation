using System.Collections.Generic;
using AudioPooling;
using PlayerRoles;
using UnityEngine;
using UserSettings;
using UserSettings.AudioSettings;

namespace FacilitySoundtrack.ChaseThemes
{
	public class ChaseThemeSoundtrack : SoundtrackLayerBase
	{
		public class ClipHandler
		{
			private readonly AudioSource _source;

			private readonly List<DesiredChaseClip> _chaseThemes;

			private bool _needsMixing;

			private DesiredChaseClip _mixed;

			private float _unscaledVolume;

			private bool _scheduled;

			public readonly AudioClip Clip;

			public float UnscaledVolume
			{
				get
				{
					return _unscaledVolume;
				}
				set
				{
					_unscaledVolume = Mathf.Clamp01(value);
				}
			}

			public bool IsPlaying
			{
				get
				{
					if (!_source.isPlaying)
					{
						return _scheduled;
					}
					return true;
				}
			}

			public int TimeSamples => _source.timeSamples;

			public bool UsesCustomOffset { get; private set; }

			private void RecalcMix()
			{
				_needsMixing = false;
				float num = 0f;
				float num2 = float.MinValue;
				float num3 = float.MinValue;
				DesiredChaseClip.Offset? offset = null;
				foreach (DesiredChaseClip chaseTheme in _chaseThemes)
				{
					num += chaseTheme.TrackVolume;
					num2 = Mathf.Max(num2, chaseTheme.VolumeIncreaseSpeed);
					num3 = Mathf.Max(num3, chaseTheme.VolumeDecreaseSpeed);
					DesiredChaseClip.Offset? offset2 = offset;
					if (!offset2.HasValue)
					{
						offset = chaseTheme.JoinOffset;
					}
				}
				_mixed = new DesiredChaseClip(Clip, Mathf.Clamp01(num), num2, num3, offset);
			}

			public bool TryGetMixed(out DesiredChaseClip mixed)
			{
				if (_needsMixing)
				{
					RecalcMix();
				}
				mixed = _mixed;
				return _chaseThemes.Count > 0;
			}

			public void ClearMix()
			{
				_chaseThemes.Clear();
				_needsMixing = true;
			}

			public void AddToMix(DesiredChaseClip theme, float volumeScale)
			{
				theme = new DesiredChaseClip(theme.Clip, theme.TrackVolume * volumeScale, theme.VolumeIncreaseSpeed, theme.VolumeDecreaseSpeed, theme.JoinOffset);
				_chaseThemes.Add(theme);
				_needsMixing = true;
			}

			public void FadeAway(float masterVolumeScale)
			{
				if (_source.isPlaying)
				{
					UnscaledVolume -= Time.deltaTime * 0.17f;
					if (UnscaledVolume <= 0f)
					{
						_scheduled = false;
						_source.volume = 0f;
						_source.Stop();
					}
					else
					{
						_source.volume = UnscaledVolume * masterVolumeScale;
					}
				}
			}

			public void StartPlaying(DesiredChaseClip.Offset? offset)
			{
				double dspTime = AudioSettings.dspTime;
				double? synchronizationDpsTime = SynchronizationDpsTime;
				double valueOrDefault = synchronizationDpsTime.GetValueOrDefault();
				if (!synchronizationDpsTime.HasValue)
				{
					valueOrDefault = dspTime;
					SynchronizationDpsTime = valueOrDefault;
				}
				int samplesElapsed = ChaseClipUtils.GetSamplesElapsed(Clip, SynchronizationDpsTime.Value);
				if (!offset.HasValue)
				{
					StartPlayingCustom(samplesElapsed, dspTime);
					return;
				}
				DesiredChaseClip.Offset value = offset.Value;
				if (value.DontSyncWithOthers)
				{
					StartPlayingCustom(value.StartSamples, dspTime + value.SchedulingDelay);
				}
				else
				{
					StartPlayingCustom(samplesElapsed + value.StartSamples, dspTime + value.SchedulingDelay);
				}
			}

			public void StartPlayingCustom(int timeSamples, double dpsTime)
			{
				_source.timeSamples = ChaseClipUtils.WrapSamples(Clip, timeSamples);
				_source.PlayScheduled(dpsTime + 0.10000000149011612);
				_scheduled = true;
			}

			public void MoveVolume(float targetVolume, float increaseRate, float decreaseRate, float masterVolumeScale)
			{
				float num = ((targetVolume < UnscaledVolume) ? decreaseRate : increaseRate);
				UnscaledVolume = Mathf.MoveTowards(UnscaledVolume, targetVolume, num * Time.deltaTime);
				_source.volume = UnscaledVolume * masterVolumeScale;
			}

			public ClipHandler(AudioSource template, AudioClip clip)
			{
				Clip = clip;
				_source = Object.Instantiate(template, template.transform.parent);
				_source.clip = Clip;
				_chaseThemes = new List<DesiredChaseClip>();
			}
		}

		private const float FadeAwaySpeed = 0.17f;

		private const float WeightInfluence = 4f;

		private const float SchedulingDelayMargin = 0.1f;

		public static readonly List<IChaseThemeProvider> ActiveChases = new List<IChaseThemeProvider>();

		private static readonly CachedUserSetting<float> SettingCache = new CachedUserSetting<float>(MixerAudioSettings.VolumeSliderSetting.ChaseThemes);

		private readonly List<ClipHandler> _clipHandlers = new List<ClipHandler>();

		private readonly List<AudioPoolSession> _alreadyPlayedStingers = new List<AudioPoolSession>();

		private float _weight;

		[SerializeField]
		private AudioSource _chaseThemeSourceTemplate;

		[SerializeField]
		private AnimationCurve _volumeScaleOverDominance;

		[SerializeField]
		private AnimationCurve _volumeOverUserSetting;

		public static double? SynchronizationDpsTime { get; private set; }

		public override float Weight => _weight;

		public override bool Additive => false;

		public override bool IsMuteable => false;

		private float UserVolume => _volumeOverUserSetting.Evaluate(SettingCache.Value);

		public override void UpdateVolume(float masterVolumeScale)
		{
			bool flag = ReferenceHub.TryGetLocalHub(out var hub) && hub.IsHuman();
			if (flag)
			{
				FindNewChases();
			}
			UpdateActiveThemes(!flag, out var totalDominance, out var highestPriority);
			ResolveThemeConflicts(totalDominance, highestPriority);
			ApplyThemeMixing(masterVolumeScale * UserVolume);
		}

		private void FindNewChases()
		{
			foreach (IChaseThemeProvider instance in ChaseThemeProviders.Instances)
			{
				if (!ActiveChases.Contains(instance) && instance.TryStartChase())
				{
					AudioPoolSession? audioPoolSession = instance.OnChaseStarted(_alreadyPlayedStingers);
					if (audioPoolSession.HasValue)
					{
						_alreadyPlayedStingers.Add(audioPoolSession.Value);
					}
					ActiveChases.Add(instance);
				}
			}
		}

		private void UpdateActiveThemes(bool forceDisable, out float totalDominance, out int highestPriority)
		{
			totalDominance = 0f;
			highestPriority = int.MinValue;
			for (int num = ActiveChases.Count - 1; num >= 0; num--)
			{
				IChaseThemeProvider chaseThemeProvider = ActiveChases[num];
				if (forceDisable || !chaseThemeProvider.IsValid() || !chaseThemeProvider.UpdateChase())
				{
					ActiveChases[num].OnChaseStopped();
					ActiveChases.RemoveAt(num);
				}
				else
				{
					int priority = chaseThemeProvider.Priority;
					if (priority > highestPriority)
					{
						highestPriority = priority;
						totalDominance = chaseThemeProvider.DominanceScale;
					}
					else if (priority == highestPriority)
					{
						totalDominance += chaseThemeProvider.DominanceScale;
					}
				}
			}
		}

		private void ResolveThemeConflicts(float totalDominance, int highestPriority)
		{
			foreach (ClipHandler clipHandler in _clipHandlers)
			{
				clipHandler.ClearMix();
			}
			if (ActiveChases.Count == 0)
			{
				_alreadyPlayedStingers.Clear();
				return;
			}
			foreach (IChaseThemeProvider activeChase in ActiveChases)
			{
				if (activeChase.Priority != highestPriority)
				{
					continue;
				}
				float dominanceScale = activeChase.DominanceScale;
				if (dominanceScale == 0f)
				{
					continue;
				}
				foreach (DesiredChaseClip item in activeChase.ClipsToPlay)
				{
					GetOrCreateHandler(item.Clip).AddToMix(volumeScale: _volumeScaleOverDominance.Evaluate(dominanceScale / totalDominance), theme: item);
				}
			}
		}

		private void ApplyThemeMixing(float masterVolumeScale)
		{
			float num = 0f;
			bool flag = false;
			foreach (ClipHandler clipHandler in _clipHandlers)
			{
				if (!clipHandler.TryGetMixed(out var mixed))
				{
					clipHandler.FadeAway(masterVolumeScale);
				}
				else
				{
					flag = true;
					if (!clipHandler.IsPlaying)
					{
						clipHandler.StartPlaying(mixed.JoinOffset);
					}
					clipHandler.MoveVolume(mixed.TrackVolume, mixed.VolumeIncreaseSpeed, mixed.VolumeDecreaseSpeed, masterVolumeScale);
				}
				num += clipHandler.UnscaledVolume;
			}
			if (!flag && num <= 0f)
			{
				SynchronizationDpsTime = null;
			}
			_weight = Mathf.Clamp01(num * 4f * UserVolume);
		}

		private ClipHandler GetOrCreateHandler(AudioClip clip)
		{
			foreach (ClipHandler clipHandler2 in _clipHandlers)
			{
				if ((object)clipHandler2.Clip == clip)
				{
					return clipHandler2;
				}
			}
			ClipHandler clipHandler = new ClipHandler(_chaseThemeSourceTemplate, clip);
			_clipHandlers.Add(clipHandler);
			return clipHandler;
		}
	}
}
