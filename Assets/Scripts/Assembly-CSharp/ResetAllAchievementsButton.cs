public class ResetAllAchievementsButton : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.GameObject ConfirmationPopup;

	public global::UnityEngine.GameObject ConfirmationWindow;

	public global::UnityEngine.GameObject CompletionWindow;

	public void ButtonPressed()
	{
		ConfirmationPopup.SetActive(value: true);
		ConfirmationWindow.SetActive(value: true);
		CompletionWindow.SetActive(value: false);
	}

	public void ConfirmationPressed()
	{
		foreach (global::System.Collections.Generic.KeyValuePair<global::Achievements.AchievementName, global::Achievements.Achievement> achievement in global::Achievements.AchievementManager.Achievements)
		{
			achievement.Value.Reset();
		}
		ConfirmationPopup.SetActive(value: false);
		CompletionWindow.SetActive(value: true);
	}
}
