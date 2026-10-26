using System;
using TMPro;
using UnityEngine;

// Client-only (body stripped from the server build); after the SL 12 CE client. Shows "Welcome back, {name}!".
public class Welcome : MonoBehaviour
{
	public TextMeshProUGUI Text;

	internal static string CurrentNickname;

	private void Start()
	{
		string name = null;
		try
		{
			if (SteamManager.Running)
			{
				name = SteamManager.GetPersonaName();
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[Welcome] Steam name unavailable: " + ex.Message);
		}
		CurrentNickname = string.IsNullOrEmpty(name) ? Environment.UserName : name;
		UpdateText();
		TranslationReader.OnTranslationsRefreshed += UpdateText;
	}

	private void OnDestroy()
	{
		TranslationReader.OnTranslationsRefreshed -= UpdateText;
	}

	private void UpdateText()
	{
		if (Text != null)
		{
			string safeName = CurrentNickname.Replace("<", "(").Replace(">", ")");
			Text.SetText(TranslationReader.GetFormatted("NewMainMenu", 65, "Welcome back, {0}!", safeName));
		}
	}
}
