using System;
using System.Globalization;
using UnityEngine;
using UnityEngine.UI;

public class GammaSlider : MonoBehaviour
{
	public const string GammaConfigKey = "UVBrightness2";

	public const float DefaultBrightness = 0f;

	public const float MinBrightness = -0.7f;

	public const float MaxBrightness = 0f;

	public Slider slider;

	public Text warningText;

	public Text indicatorText;

	public static event Action<float> OnGammaChanged;

	public static float SavedToGui(float intensity)
	{
		return (intensity - 0f) * 10f;
	}

	public static float GuiToSaved(float setting)
	{
		return setting * 0.1f + 0f;
	}

	private void Start()
	{
		slider.minValue = SavedToGui(-0.7f);
		slider.maxValue = SavedToGui(0f);
		slider.value = SavedToGui(PlayerPrefsSl.Get("UVBrightness2", 0f));
		warningText.enabled = slider.value > 0f;
	}

	public void SetValue(float f)
	{
		indicatorText.text = f.ToString(CultureInfo.InvariantCulture);
		warningText.enabled = f > 0f;
		float num = GuiToSaved(f);
		PlayerPrefsSl.Set("UVBrightness2", num);
		GammaSlider.OnGammaChanged?.Invoke(num);
	}
}
