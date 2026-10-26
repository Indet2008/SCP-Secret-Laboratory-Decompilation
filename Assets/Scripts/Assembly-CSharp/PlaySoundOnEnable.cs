using UnityEngine;

public class PlaySoundOnEnable : MonoBehaviour
{
	private AudioSource audio;

	private void Awake()
	{
		audio = GetComponent<AudioSource>();
	}

	private void OnEnable()
	{
		if (audio != null && !audio.isPlaying)
		{
			audio.Play();
		}
	}
}
