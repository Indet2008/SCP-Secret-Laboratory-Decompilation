using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using UserSettings;
using UserSettings.VideoSettings;

namespace CustomRendering
{
	// Client-only behaviour stripped from the server build; rebuilt against the video settings enums.
	public class ApplyPostProcessGraphicSettings : MonoBehaviour
	{
		private VolumeProfile _volumeProfile;

		private void Start()
		{
			if (TryGetComponent<Volume>(out var component))
			{
				_volumeProfile = component.profile;
			}
			if (_volumeProfile == null)
			{
				Debug.LogWarning("[ApplyPostProcessGraphicSettings] No volume profile found on " + base.name, this);
				return;
			}
			UserSetting<float>.AddListener(MiscVideoSetting.BrightnessBoost, UpdateBrightness);
			UserSetting<int>.AddListener(PerformanceVideoSetting.BloomQuality, UpdateBloom);
			UserSetting<int>.AddListener(PerformanceVideoSetting.AOQuality, UpdateAO);
			UserSetting<bool>.AddListener(MiscVideoSetting.ExplosionShake, UpdateShake);
			UpdateBrightness(UserSetting<float>.Get(MiscVideoSetting.BrightnessBoost));
			UpdateBloom(UserSetting<int>.Get(PerformanceVideoSetting.BloomQuality));
			UpdateAO(UserSetting<int>.Get(PerformanceVideoSetting.AOQuality));
			UpdateShake(UserSetting<bool>.Get(MiscVideoSetting.ExplosionShake));
		}

		private void OnDestroy()
		{
			UserSetting<float>.RemoveListener(MiscVideoSetting.BrightnessBoost, UpdateBrightness);
			UserSetting<int>.RemoveListener(PerformanceVideoSetting.BloomQuality, UpdateBloom);
			UserSetting<int>.RemoveListener(PerformanceVideoSetting.AOQuality, UpdateAO);
			UserSetting<bool>.RemoveListener(MiscVideoSetting.ExplosionShake, UpdateShake);
		}

		private void UpdateBrightness(float brightness)
		{
			if (_volumeProfile.TryGet<ColorAdjustments>(out var component) || (component = _volumeProfile.Add<ColorAdjustments>()) != null)
			{
				component.active = true;
				component.postExposure.Override(brightness);
			}
		}

		// Quality 0 disables the effect; 1-3 map to HDRP's Low/Medium/High scalable levels.
		private void UpdateBloom(int qualityLevel)
		{
			if (_volumeProfile.TryGet<Bloom>(out var component))
			{
				component.active = qualityLevel > 0;
				if (qualityLevel > 0)
				{
					component.quality.Override(Mathf.Clamp(qualityLevel - 1, 0, 2));
				}
			}
		}

		private void UpdateAO(int qualityLevel)
		{
			if (_volumeProfile.TryGet<ScreenSpaceAmbientOcclusion>(out var component))
			{
				component.active = qualityLevel > 0;
				if (qualityLevel > 0)
				{
					component.quality.Override(Mathf.Clamp(qualityLevel - 1, 0, 2));
				}
			}
		}

		private void UpdateShake(bool enable)
		{
			if (_volumeProfile.TryGet<CameraShake>(out var component))
			{
				component.active = enable;
			}
		}
	}
}
