using UnityEngine;

namespace UserSettings.ControlsSettings
{
	public static class SensitivitySettings
	{
		private static CachedUserSetting<float> _sensMultiplier;

		private static CachedUserSetting<float> _adsReductionMultiplier;

		private static CachedUserSetting<bool> _invert;

		public static bool SmoothInput;

		public static float SensMultiplier
		{
			get
			{
				return _sensMultiplier.Value;
			}
			set
			{
				_sensMultiplier.Value = value;
			}
		}

		public static float AdsReductionMultiplier
		{
			get
			{
				return _adsReductionMultiplier.Value;
			}
			set
			{
				_adsReductionMultiplier.Value = value;
			}
		}

		public static bool Invert
		{
			get
			{
				return _invert.Value;
			}
			set
			{
				_invert.Value = value;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<float>.SetDefaultValue(SensitivitySetting.SensMultiplier, 1f);
			UserSetting<float>.SetDefaultValue(SensitivitySetting.AdsReductionMultiplier, 1f);
			_sensMultiplier = new CachedUserSetting<float>(SensitivitySetting.SensMultiplier);
			_adsReductionMultiplier = new CachedUserSetting<float>(SensitivitySetting.AdsReductionMultiplier);
			_invert = new CachedUserSetting<bool>(SensitivitySetting.Invert);
		}
	}
}
