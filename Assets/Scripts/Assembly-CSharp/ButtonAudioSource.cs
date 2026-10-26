using System.Diagnostics;
using UnityEngine;

// Scene-wide UI sound player that ButtonAudio components call into. The v14 client bodies were stripped,
// so this is rebuilt from the field layout.
public class ButtonAudioSource : MonoBehaviour
{
	[SerializeField]
	private AudioClip _clickClip;

	[SerializeField]
	private AudioClip _hoverClip;

	private AudioSource _audioSource;

	private static bool _singletonSet;

	private static ButtonAudioSource _singleton;

	private static readonly Stopwatch LastPlay = Stopwatch.StartNew();

	private const float MinCooldown = 0.06f;

	private void Awake()
	{
		_audioSource = GetComponent<AudioSource>();
		if (_audioSource == null)
		{
			_audioSource = gameObject.AddComponent<AudioSource>();
			_audioSource.playOnAwake = false;
		}
		_singleton = this;
		_singletonSet = true;
	}

	private void OnDestroy()
	{
		if (_singleton == this)
		{
			_singleton = null;
			_singletonSet = false;
		}
	}

	public static void PlayHover()
	{
		if (_singletonSet)
		{
			Play(_singleton._hoverClip);
		}
	}

	public static void PlayClick()
	{
		if (_singletonSet)
		{
			Play(_singleton._clickClip);
		}
	}

	private static void Play(AudioClip clip)
	{
		if (clip == null || _singleton._audioSource == null || LastPlay.Elapsed.TotalSeconds < MinCooldown)
		{
			return;
		}
		_singleton._audioSource.PlayOneShot(clip);
		LastPlay.Restart();
	}
}
