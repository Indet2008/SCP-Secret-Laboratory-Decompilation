using UnityEngine;

public static class AudioUtils
{
	public static void SetSpace(this AudioSource src, bool is3D)
	{
		if (is3D)
		{
			src.Set3D();
		}
		else
		{
			src.Set2D();
		}
	}

	public static void Set3D(this AudioSource src)
	{
		src.spatialBlend = 1f;
		src.spread = 0f;
	}

	public static void Replay(this AudioSource src)
	{
		src.Stop();
		src.Play();
	}

	public static void UpdateFade(this AudioSource src, bool isEnabled, float speed, float maxVolume = 1f)
	{
		src.volume = Mathf.MoveTowards(src.volume, isEnabled ? maxVolume : 0f, speed * Time.deltaTime);
	}

	public static void UpdateFadeIn(this AudioSource src, float speed, float targetVolume = 1f)
	{
		src.UpdateFade(isEnabled: true, speed, targetVolume);
	}

	public static void UpdateFadeOut(this AudioSource src, float speed)
	{
		src.UpdateFade(isEnabled: false, speed);
	}

	public static void Set2D(this AudioSource src)
	{
		src.spatialBlend = 0f;
		src.spread = 360f;
	}
}
