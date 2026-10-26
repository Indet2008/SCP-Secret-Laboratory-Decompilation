using Mirror;
using Subtitles;
using UnityEngine;

public class DeadMansSwitchAnnouncer : AlphaWarheadScenarioAnnouncer
{
	private float _lastElapsed;

	[SerializeField]
	private AudioSource _announcementSource;

	[SerializeField]
	private AudioClip _announcementClip;

	[SerializeField]
	private AudioSource _musicSource;

	[SerializeField]
	private AudioClip _musicClip;

	[SerializeField]
	private float _musicOffset;

	[SerializeField]
	private float _musicIntenseTime;

	public override float CurrentMusicOutput => Mathf.Clamp01(_lastElapsed - _musicIntenseTime - _musicOffset);

	public override SubtitleType Subtitle => SubtitleType.DeadMansSwitch;

	public override void UpdateActive()
	{
		_lastElapsed = (float)(NetworkTime.time - AlphaWarheadScenarioAnnouncer.Controller.Info.StartTime);
		AlphaWarheadScenarioAnnouncer.EnsureClip(_announcementSource, _announcementClip);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_announcementSource, _lastElapsed);
		AlphaWarheadScenarioAnnouncer.EnsureClip(_musicSource, _musicClip);
		AlphaWarheadScenarioAnnouncer.EnsureSync(_musicSource, _lastElapsed - _musicOffset);
	}

	public override void OnCancelled()
	{
		Clear();
	}

	public override void Clear()
	{
		_announcementSource.Stop();
		_musicSource.Stop();
	}

	public override void OnStarted()
	{
		_musicClip.LoadAudioData();
	}
}
