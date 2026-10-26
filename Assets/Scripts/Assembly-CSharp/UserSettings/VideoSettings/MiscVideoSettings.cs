using UnityEngine;

namespace UserSettings.VideoSettings
{
	public static class MiscVideoSettings
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(MiscVideoSetting.ExplosionShake, defaultValue: true);
			UserSetting<bool>.SetDefaultValue(MiscVideoSetting.HeadBobbing, defaultValue: true);
			UserSetting<bool>.SetDefaultValue(MiscVideoSetting.ShowNeedles, defaultValue: true);
			UserSetting<bool>.SetDefaultValue(MiscVideoSetting.Scp939VisionBlur, defaultValue: true);
		}
	}
}
