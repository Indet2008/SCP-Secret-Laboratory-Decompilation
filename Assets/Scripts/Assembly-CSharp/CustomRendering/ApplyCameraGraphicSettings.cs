using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using UserSettings;
using UserSettings.VideoSettings;

namespace CustomRendering
{
	// Client-only behaviour stripped from the server build; applies the anti-aliasing settings to this camera.
	public class ApplyCameraGraphicSettings : MonoBehaviour
	{
		private enum AntiAliasingType
		{
			Disabled = 0,
			FXAA = 1,
			SMAA = 2
		}

		[SerializeField]
		private int _defaultAAType;

		[SerializeField]
		private int _defaultAAQuality;

		private HDAdditionalCameraData _cameraData;

		private void Start()
		{
			if (!TryGetComponent<HDAdditionalCameraData>(out _cameraData))
			{
				return;
			}
			UserSetting<int>.AddListener(PerformanceVideoSetting.AntiAliasingType, UpdateAAType);
			UserSetting<int>.AddListener(PerformanceVideoSetting.AntiAliasingQuality, UpdateAAQuality);
			UpdateAAType(UserSetting<int>.Get(PerformanceVideoSetting.AntiAliasingType));
			UpdateAAQuality(UserSetting<int>.Get(PerformanceVideoSetting.AntiAliasingQuality));
		}

		private void OnDestroy()
		{
			UserSetting<int>.RemoveListener(PerformanceVideoSetting.AntiAliasingType, UpdateAAType);
			UserSetting<int>.RemoveListener(PerformanceVideoSetting.AntiAliasingQuality, UpdateAAQuality);
		}

		private void UpdateAAType(int type)
		{
			if (!(_cameraData == null))
			{
				_cameraData.antialiasing = (AntiAliasingType)type switch
				{
					AntiAliasingType.FXAA => HDAdditionalCameraData.AntialiasingMode.FastApproximateAntialiasing,
					AntiAliasingType.SMAA => HDAdditionalCameraData.AntialiasingMode.SubpixelMorphologicalAntiAliasing,
					_ => HDAdditionalCameraData.AntialiasingMode.None,
				};
			}
		}

		private void UpdateAAQuality(int quality)
		{
			if (!(_cameraData == null))
			{
				_cameraData.SMAAQuality = (HDAdditionalCameraData.SMAAQualityLevel)Mathf.Clamp(quality, 0, 2);
			}
		}
	}
}
