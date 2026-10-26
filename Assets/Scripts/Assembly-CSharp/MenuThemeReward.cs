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

	public static bool IsHolidayThemeActive
	{
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		get
		{
			return default;
		}
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		private set
		{
		}
	}

	public static void LoadAchievementThemes()
	{
	}

	private void Awake()
	{
	}

	public MenuThemeReward()
	{
	}
}
