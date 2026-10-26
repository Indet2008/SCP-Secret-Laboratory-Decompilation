using UnityEngine;
using UnityEngine.UI;

public class GameplayOptionsMenu : MonoBehaviour
{
	public Slider classIntroFastFadeSlider;

	public Slider headBobSlider;

	public Slider toggleSprintSlider;

	public Slider modeSwitchToggle079;

	public Slider postProcessing079;

	public Slider healthBarShowsExact;

	public Slider richPresence;

	public Slider publicLobby;

	public Slider hideIP;

	public Slider toggleSearch;

	private bool _isAwake;

	public void Awake()
	{
		classIntroFastFadeSlider.value = (PlayerPrefsSl.Get("ClassIntroFastFade", defaultValue: false) ? 1f : 0f);
		headBobSlider.value = (PlayerPrefsSl.Get("HeadBob", defaultValue: true) ? 1f : 0f);
		toggleSprintSlider.value = (PlayerPrefsSl.Get("ToggleSprint", defaultValue: false) ? 1f : 0f);
		modeSwitchToggle079.value = (PlayerPrefsSl.Get("ModeSwitchSetting079", defaultValue: false) ? 1f : 0f);
		postProcessing079.value = (PlayerPrefsSl.Get("PostProcessing079", defaultValue: true) ? 1f : 0f);
		healthBarShowsExact.value = (PlayerPrefsSl.Get("HealthBarShowsExact", defaultValue: true) ? 1f : 0f);
		richPresence.value = (PlayerPrefsSl.Get("RichPresence", defaultValue: true) ? 1f : 0f);
		publicLobby.value = (PlayerPrefsSl.Get("PublicLobby", defaultValue: true) ? 1f : 0f);
		hideIP.value = (PlayerPrefsSl.Get("HideIP", defaultValue: false) ? 1f : 0f);
		toggleSearch.value = (PlayerPrefsSl.Get("ToggleSearch", defaultValue: false) ? 1f : 0f);
		_isAwake = true;
	}

	public void SaveSettings()
	{
		if (_isAwake)
		{
			PlayerPrefsSl.Set("ClassIntroFastFade", (int)classIntroFastFadeSlider.value == 1);
			PlayerPrefsSl.Set("HeadBob", (int)headBobSlider.value == 1);
			PlayerPrefsSl.Set("ToggleSprint", (int)toggleSprintSlider.value == 1);
			PlayerPrefsSl.Set("ModeSwitchSetting079", (int)modeSwitchToggle079.value == 1);
			PlayerPrefsSl.Set("PostProcessing079", (int)postProcessing079.value == 1);
			PlayerPrefsSl.Set("HealthBarShowsExact", (int)healthBarShowsExact.value == 1);
			PlayerPrefsSl.Set("RichPresence", (int)richPresence.value == 1);
			PlayerPrefsSl.Set("PublicLobby", (int)publicLobby.value == 1);
			PlayerPrefsSl.Set("HideIP", (int)hideIP.value == 1);
			PlayerPrefsSl.Set("ToggleSearch", (int)toggleSearch.value == 1);
		}
	}
}
