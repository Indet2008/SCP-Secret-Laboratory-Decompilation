using UnityEngine;

namespace UserSettings.OtherSettings
{
	public static class ScpSettings
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(ScpSetting.ScpOptOut, defaultValue: false);
		}
	}
}
