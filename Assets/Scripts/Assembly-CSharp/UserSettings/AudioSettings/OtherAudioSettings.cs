using UnityEngine;

namespace UserSettings.AudioSettings
{
	public static class OtherAudioSettings
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(OtherAudioSetting.NoiseReduction, defaultValue: true);
			UserSetting<bool>.SetDefaultValue(OtherAudioSetting.SpatialAnnouncements, defaultValue: true);
		}
	}
}
