using UnityEngine;

namespace UserSettings.OtherSettings
{
	public static class MiscPrivacySettings
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(MiscPrivacySetting.SteamLobbyPrivacy, defaultValue: true);
			UserSetting<bool>.SetDefaultValue(MiscPrivacySetting.RichPresence, defaultValue: true);
			UserSetting<int>.SetDefaultValue(MiscPrivacySetting.SteamLobbyPrivacy, 1);
		}
	}
}
