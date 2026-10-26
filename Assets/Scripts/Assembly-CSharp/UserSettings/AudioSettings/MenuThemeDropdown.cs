using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace UserSettings.AudioSettings
{
	// Client-only (body stripped from the server build): lists MainMenuSoundtrackController themes and plays the chosen one.
	public class MenuThemeDropdown : MonoBehaviour
	{
		private void Awake()
		{
			TMP_Dropdown dropdown = GetComponent<TMP_Dropdown>();
			if (dropdown == null)
			{
				return;
			}
			dropdown.ClearOptions();
			dropdown.AddOptions(new List<string>(MainMenuSoundtrackController.GetThemeNames));
			dropdown.SetValueWithoutNotify(Mathf.Clamp(MainMenuSoundtrackController.SelectedTheme, 0, Mathf.Max(0, dropdown.options.Count - 1)));
			dropdown.RefreshShownValue();
			dropdown.onValueChanged.AddListener(delegate(int value)
			{
				MainMenuSoundtrackController.SelectedTheme = value;
			});
		}
	}
}
