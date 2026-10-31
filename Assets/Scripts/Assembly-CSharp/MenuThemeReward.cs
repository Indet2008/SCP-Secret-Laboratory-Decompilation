public class MenuThemeReward : global::UnityEngine.MonoBehaviour
{
	[global::System.Serializable]
	private struct MenuUnlockableTheme
	{
		public string Name;

		public global::UnityEngine.AudioClip Theme;

		public string AchievementID;

		public global::MapGeneration.Holidays.HolidayType Holiday;
	}

	private static MenuThemeReward _instance;

	[global::UnityEngine.SerializeField]
	private global::System.Collections.Generic.List<MenuThemeReward.MenuUnlockableTheme> _unlockableThemes;

	public static bool IsHolidayThemeActive { get; private set; }

	public static void LoadAchievementThemes()
	{
		foreach (MenuUnlockableTheme unlockableTheme in _instance._unlockableThemes)
		{
			bool flag = global::SteamManager.CheckAchievement(unlockableTheme.AchievementID);
			global::MapGeneration.Holidays.HolidayType activeHoliday = global::GameCore.Version.ActiveHoliday;
			if (!flag && activeHoliday != unlockableTheme.Holiday)
			{
				continue;
			}
			global::MainMenuSoundtrackController.MenuAltTheme theme = new global::MainMenuSoundtrackController.MenuAltTheme
			{
				Name = unlockableTheme.Name,
				Theme = unlockableTheme.Theme
			};
			if (activeHoliday != unlockableTheme.Holiday)
			{
				global::MainMenuSoundtrackController.AddTheme(theme);
				continue;
			}
			IsHolidayThemeActive = true;
			global::MainMenuSoundtrackController.Singleton.Themes.Insert(0, theme);
		}
	}

	private void Awake()
	{
		_instance = this;
	}
}
