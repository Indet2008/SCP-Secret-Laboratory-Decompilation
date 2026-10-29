using UnityEngine;
using UnityEngine.Rendering;

namespace OperationalGuide
{
	public class GameCloseEasterEgg : MonoBehaviour
	{
		public Volume ScreenVolume;

		public float EnableModifier = 0.5f;

		public GameObject RootText;

		public AudioSource MusicToPlay;

		private float _timeTillExit = 10f;

		private float _fixedTime;

		private bool _enabled;

		private void OnEnable()
		{
			MusicToPlay.Play();
			_enabled = true;
			MainMenuSoundtrackController.Singleton.ToposThemeSource.Stop();
		}

		private void OnDisable()
		{
			_enabled = false;
			_fixedTime = 0f;
			ScreenVolume.weight = 0f;
			RootText.SetActive(value: false);
		}

		// Fades the volume in, shows the text, then quits the game.
		private void FixedUpdate()
		{
			if (_enabled)
			{
				float num = Mathf.Clamp01(_fixedTime);
				ScreenVolume.weight = (3f - 2f * num) * num * num;
				if (ScreenVolume.weight >= 0.99f && !RootText.activeSelf)
				{
					RootText.SetActive(value: true);
				}
				_fixedTime += Time.fixedDeltaTime;
				if (_fixedTime >= _timeTillExit)
				{
					Application.Quit();
				}
			}
		}
	}
}
