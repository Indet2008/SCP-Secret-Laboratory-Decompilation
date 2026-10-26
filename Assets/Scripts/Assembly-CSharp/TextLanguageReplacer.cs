using System;
using UnityEngine;

// Client-only behaviour (bodies stripped from the server build); rebuilt from the v14 dump layout and the SL 12 CE client.
public sealed class TextLanguageReplacer : UniversalTextModifier
{
	public static readonly string[] Files = new string[37]
	{
		"None", "Facility", "NewMainMenu", "SCP939_HUD", "Voicechat", "MainMenu", "MenuWarnings", "SCP079_HUD", "SCP049_HUD", "SCP106_HUD",
		"Version_7-0-0", "ReportForm", "Summary", "InventoryGUI", "AttachmentEditors", "Nuke", "DecontaminationDisplays", "Doors", "Class_Names", "Abilities",
		"Legacy_Interfaces", "HumanAbilities", "HumanBio", "SCP173_HUD", "SCP096_HUD", "Teams", "VideoSettings", "AudioSettings", "SettingsCategories", "ControlsSettings",
		"InterfaceSettings", "OtherSettings", "Hotkeys", "Overwatch_HUD", "SCP3114_HUD", "SCP1507_HUD", "KeyCodes"
	};

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[SerializeField]
	private string _englishVersion;

	[SerializeField]
	private int _fileId;

	[SerializeField]
	private int _line;

	public bool Missing { get; private set; }

	public event Action OnUpdated;

	protected override void Awake()
	{
		base.Awake();
		UpdateText();
		TranslationReader.OnTranslationsRefreshed += UpdateText;
	}

	private void OnDestroy()
	{
		TranslationReader.OnTranslationsRefreshed -= UpdateText;
	}

	private void UpdateText()
	{
		string text = _englishVersion ?? string.Empty;
		Missing = true;
		// Before the first TranslationReader.Refresh (on scene load) only the English text is available; OnTranslationsRefreshed updates it later.
		if (TranslationReader.EverLoaded && _fileId > 0 && _fileId < Files.Length && _line >= 0 && TranslationReader.TryGet(Files[_fileId], _line, out var translated))
		{
			text = translated;
			Missing = false;
		}
		DisplayText = text;
		OnUpdated?.Invoke();
	}
}
