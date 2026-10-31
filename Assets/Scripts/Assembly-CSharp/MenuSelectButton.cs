public class MenuSelectButton : global::UnityEngine.MonoBehaviour
{
	public global::TMPro.TMP_Dropdown dropdown;

	public void OnChangeValue()
	{
		if (!(global::UnityEngine.SceneManagement.SceneManager.GetActiveScene().name == global::SimpleMenu.MenuSceneNames[dropdown.value]))
		{
			global::PlayerPrefsSl.Set("menumode", dropdown.value);
			global::SimpleMenu.Refresh();
			global::SimpleMenu.LoadCorrectScene();
		}
	}

	private void Start()
	{
		dropdown.value = global::PlayerPrefsSl.Get("menumode", 1);
	}

	public MenuSelectButton()
	{
	}
}
