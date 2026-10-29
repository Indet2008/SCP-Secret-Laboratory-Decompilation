using System;
using System.Collections.Generic;
using System.IO;
using TMPro;
using UnityEngine;

namespace UserSettings.UserInterfaceSettings
{
	// Client-only (bodies stripped from the server build); rebuilt from the v14 dump layout.
	// Lists Translations/<dir>/manifest.json entries and stores the chosen directory in UISetting.Language.
	public class LanguageDropdown : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[SerializeField]
		private TMP_Text _onChangeWarning;

		private TMP_Dropdown _dropdown;

		private readonly List<(string, bool)> _loadedOptions = new List<(string, bool)>();

		private const string InvalidCharFormat = "<color=red>{0}</color>";

		private void Awake()
		{
			_dropdown = GetComponent<TMP_Dropdown>();
			if (_onChangeWarning != null)
			{
				_onChangeWarning.enabled = false;
			}
			if (_dropdown != null)
			{
				// The original Awake is async; populating a frame later also lets this win over the
				// DropdownLanguageReplacer on the same object, which writes the "Loading..." placeholder in Start.
				StartCoroutine(PopulateNextFrame());
			}
		}

		private System.Collections.IEnumerator PopulateNextFrame()
		{
			yield return null;
			Populate();
		}

		private void Populate()
		{
			_dropdown.ClearOptions();
			_loadedOptions.Clear();
			// The loaded language, which may come from the system locale when none was chosen.
			string current = TranslationReader.TranslationDirectoryName ?? UserSetting<string>.Get(UISetting.Language, "en");
			int loadedValue = 0;
			List<TMP_Dropdown.OptionData> options = new List<TMP_Dropdown.OptionData>();
			if (Directory.Exists(TranslationReader.TranslationDirectory))
			{
				foreach (string dir in Directory.GetDirectories(TranslationReader.TranslationDirectory))
				{
					string manifestPath = Path.Combine(dir, "manifest.json");
					if (!File.Exists(manifestPath))
					{
						continue;
					}
					string dirName = Path.GetFileName(dir);
					string label = dirName;
					bool valid = true;
					try
					{
						TranslationManifest manifest = JsonSerialize.FromFile<TranslationManifest>(manifestPath);
						if (!string.IsNullOrWhiteSpace(manifest.Name))
						{
							label = manifest.Name;
						}
					}
					catch (Exception ex)
					{
						Debug.LogWarning("[LanguageDropdown] Invalid manifest " + manifestPath + ": " + ex.Message);
						valid = false;
						label = string.Format(InvalidCharFormat, dirName);
					}
					if (string.Equals(dirName, current, StringComparison.OrdinalIgnoreCase))
					{
						loadedValue = _loadedOptions.Count;
					}
					_loadedOptions.Add((dirName, valid));
					options.Add(new TMP_Dropdown.OptionData(label));
				}
			}
			_dropdown.AddOptions(options);
			_dropdown.SetValueWithoutNotify(loadedValue);
			_dropdown.RefreshShownValue();
			_dropdown.onValueChanged.AddListener(OnSelected);
			// The scene saves the dropdown as non-interactable until the list is loaded.
			_dropdown.interactable = true;
		}

		private void OnSelected(int index)
		{
			if (index < 0 || index >= _loadedOptions.Count || !_loadedOptions[index].Item2)
			{
				return;
			}
			UserSetting<string>.Set(UISetting.Language, _loadedOptions[index].Item1);
			if (_onChangeWarning != null)
			{
				_onChangeWarning.enabled = true;
			}
			TranslationReader.Refresh();
		}
	}
}
