using Subtitles;
using UnityEngine;

public abstract class AlphaWarheadScenarioAnnouncer : MonoBehaviour
{
	private const float MaxDesync = 0.5f;

	protected static AlphaWarheadController Controller => AlphaWarheadController.Singleton;

	public abstract SubtitleType Subtitle { get; }

	public abstract float CurrentMusicOutput { get; }

	public abstract void UpdateActive();

	public abstract void OnStarted();

	public abstract void OnCancelled();

	public abstract void Clear();

	protected static void EnsureClip(AudioSource src, AudioClip clip)
	{
		if ((object)src.clip != clip)
		{
			src.Stop();
			src.clip = clip;
			clip.LoadAudioData();
		}
	}

	protected static void EnsureSync(AudioSource src, float elapsed)
	{
		AudioClip clip = src.clip;
		if (elapsed < 0f || elapsed > clip.length || clip.loadState != AudioDataLoadState.Loaded)
		{
			src.Stop();
		}
		else if (!src.isPlaying)
		{
			src.Play();
			src.time = elapsed;
		}
		else if (Mathf.Abs(src.time - elapsed) > 0.5f)
		{
			src.time = elapsed;
		}
	}
}
