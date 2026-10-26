using System;
using Mirror;
using Subtitles;
using UnityEngine;

public class RegularScenarioWarheadAnnouncer : AlphaWarheadScenarioAnnouncer
{
	[Serializable]
	private class TimeVariant
	{
		public int Seconds;

		public AudioClip Clip;

		public float SirenTransitionTime;

		public AnimationCurve SoundtrackVolume;
	}

	[SerializeField]
	private AudioSource _mainSiren;

	[SerializeField]
	private AnimationCurve _mainSirenVolumeFade;

	[SerializeField]
	private AudioSource _finishingSiren;

	[SerializeField]
	private AnimationCurve _finishingSirenVolumeFade;

	[SerializeField]
	private AudioSource _soundtrackSource;

	[SerializeField]
	private AudioClip _soundtrackClip;

	[SerializeField]
	private float _soundtrackExplosionTime;

	[SerializeField]
	private AudioClip _announcementClip;

	[SerializeField]
	private AudioClip _cancelledClip;

	[SerializeField]
	private AudioSource _announcementSource;

	[SerializeField]
	private AudioSource _tminusSource;

	[SerializeField]
	private TimeVariant[] _timeVariants;

	[SerializeField]
	private SubtitleType _subtitleType;

	private float _lastMusicOutput;

	public override float CurrentMusicOutput => _lastMusicOutput;

	public override SubtitleType Subtitle => _subtitleType;

	public override void UpdateActive()
	{
		AlphaWarheadController.DetonationScenario curScenario = AlphaWarheadScenarioAnnouncer.Controller.CurScenario;
		TimeVariant[] timeVariants = _timeVariants;
		foreach (TimeVariant timeVariant in timeVariants)
		{
			if (curScenario.TimeToDetonate == timeVariant.Seconds)
			{
				double num = NetworkTime.time - AlphaWarheadScenarioAnnouncer.Controller.Info.StartTime;
				UpdateSources(timeVariant, (float)num, curScenario.AdditionalTime);
			}
		}
	}

	public override void OnCancelled()
	{
		Clear();
		_announcementSource.PlayOneShot(_cancelledClip);
	}

	public override void Clear()
	{
		_mainSiren.Stop();
		_finishingSiren.Stop();
		_soundtrackSource.Stop();
		_announcementSource.Stop();
		_tminusSource.Stop();
		AnnouncementSource.SetVolumeScale(_soundtrackSource, 1f);
	}

	private void UpdateSources(TimeVariant variant, float elapsed, float leadTime)
	{
		AlphaWarheadScenarioAnnouncer.EnsureClip(_announcementSource, _announcementClip);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_announcementSource, elapsed);
		elapsed -= leadTime;
		AlphaWarheadScenarioAnnouncer.EnsureClip(_tminusSource, variant.Clip);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_tminusSource, elapsed);
		float time = elapsed - variant.SirenTransitionTime;
		AnnouncementSource.SetVolumeScale(_mainSiren, _mainSirenVolumeFade.Evaluate(time));
		AnnouncementSource.SetVolumeScale(_finishingSiren, _finishingSirenVolumeFade.Evaluate(time));
		AlphaWarheadScenarioAnnouncer.EnsureSync(_mainSiren, elapsed);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_finishingSiren, elapsed - variant.SirenTransitionTime);
		_lastMusicOutput = variant.SoundtrackVolume.Evaluate(elapsed);
		AnnouncementSource.SetVolumeScale(_soundtrackSource, _lastMusicOutput);
		AlphaWarheadScenarioAnnouncer.EnsureClip(_soundtrackSource, _soundtrackClip);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_soundtrackSource, elapsed - (float)variant.Seconds + _soundtrackExplosionTime);
	}

	public override void OnStarted()
	{
		_mainSiren.clip.LoadAudioData();
		_finishingSiren.clip.LoadAudioData();
		_soundtrackClip.LoadAudioData();
	}
}
