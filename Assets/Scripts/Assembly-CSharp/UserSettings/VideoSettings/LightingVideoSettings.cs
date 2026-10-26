using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UnityEngine.SceneManagement;

namespace UserSettings.VideoSettings
{
	public static class LightingVideoSettings
	{
		// Lights that cast shadows as authored; only these get shadows toggled back on.
		private static readonly HashSet<HDAdditionalLightData> AuthoredShadowCasters = new HashSet<HDAdditionalLightData>();

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(LightingVideoSetting.RenderShadows, defaultValue: true);
			UserSetting<int>.SetDefaultValue(LightingVideoSetting.ShadowResolution, 2);
			UserSetting<bool>.SetDefaultValue(LightingVideoSetting.RenderLights, defaultValue: true);
			UserSetting<bool>.AddListener(LightingVideoSetting.RenderShadows, delegate
			{
				ApplyShadowSettings();
			});
			UserSetting<int>.AddListener(LightingVideoSetting.ShadowResolution, delegate
			{
				ApplyShadowSettings();
			});
			SceneManager.sceneLoaded += delegate
			{
				ApplyShadowSettings();
			};
		}

		public static void ApplyShadowSettings()
		{
			bool flag = UserSetting<bool>.Get(LightingVideoSetting.RenderShadows);
			int shadowResolutionLevel = Mathf.Clamp(UserSetting<int>.Get(LightingVideoSetting.ShadowResolution), 0, 3);
			HDAdditionalLightData[] array = Object.FindObjectsByType<HDAdditionalLightData>(FindObjectsInactive.Include, FindObjectsSortMode.None);
			foreach (HDAdditionalLightData hDAdditionalLightData in array)
			{
				Light component = hDAdditionalLightData.GetComponent<Light>();
				if (component == null || component.type == LightType.Directional)
				{
					continue;
				}
				if (component.shadows != LightShadows.None)
				{
					AuthoredShadowCasters.Add(hDAdditionalLightData);
				}
				if (AuthoredShadowCasters.Contains(hDAdditionalLightData))
				{
					hDAdditionalLightData.EnableShadows(flag);
					hDAdditionalLightData.SetShadowResolutionLevel(shadowResolutionLevel);
				}
			}
		}
	}
}
