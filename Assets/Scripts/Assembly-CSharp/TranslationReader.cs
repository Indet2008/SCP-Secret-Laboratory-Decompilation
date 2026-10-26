using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using GameCore;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class TranslationReader
{
	private static string _translationPath;

	public static readonly Dictionary<string, string[]> Elements;

	public static readonly Dictionary<string, string[]> Fallback;

	private static readonly Dictionary<string, Dictionary<int, Dictionary<string, int>>> _positions;

	private static readonly Regex _matchFormat;

	private static TMP_FontAsset[] defaultFallbacks;

	public const string DefaultLanguage = "en";

	public const string NoTranslation = "NO_TRANSLATION";

	public const string TranslationDirectory = "Translations/";

	public static string TranslationPath
	{
		get
		{
			return _translationPath;
		}
		private set
		{
			_translationPath = Path.GetFullPath(value);
			TranslationDirectoryName = Path.GetFileName(_translationPath);
		}
	}

	public static bool EverLoaded { get; private set; }

	public static string TranslationDirectoryName { get; private set; }

	public static TranslationManifest TranslationManifest { get; private set; }

	public static CultureInfo TranslationCulture { get; private set; }

	public static event Action OnTranslationsRefreshed;

	static TranslationReader()
	{
		Elements = new Dictionary<string, string[]>();
		Fallback = new Dictionary<string, string[]>();
		_positions = new Dictionary<string, Dictionary<int, Dictionary<string, int>>>();
		_matchFormat = new Regex("\\{.*?\\}|\\[.*?\\]");
		LoadPositions();
		SceneManager.sceneLoaded += OnSceneWasLoaded;
	}

	private static void OnSceneWasLoaded(Scene scene, LoadSceneMode mode)
	{
		PlayerPrefsSl.Refresh();
		Refresh();
	}

	public static void Refresh()
	{
		TranslationPath = GetTranslationPath();
		TranslationManifest = LoadTranslation(TranslationPath, Elements);
		LoadTranslation(CheckPath(), Fallback);
		TranslationCulture = null;
		string[] array = TranslationManifest.InterfaceLocales ?? Array.Empty<string>();
		foreach (string name in array)
		{
			try
			{
				TranslationCulture = CultureInfo.GetCultureInfo(name);
			}
			catch
			{
				TranslationCulture = null;
				continue;
			}
			break;
		}
		if (TranslationCulture == null)
		{
			TranslationCulture = CultureInfo.CurrentCulture;
		}
		CultureInfo.CurrentCulture = TranslationCulture;
		CultureInfo.CurrentUICulture = TranslationCulture;
		ApplyFontOrder(TranslationManifest);
		EverLoaded = true;
		Translations.ResetCache();
		OnTranslationsRefreshed?.Invoke();
	}

	private static string GetTranslationPath()
	{
		// The server build always loads "en". The client loads the language chosen in the settings (Translations/<dir>),
		// or, when none was chosen yet, the one whose manifest lists the system locale.
		string chosen = UserSettings.UserSetting<string>.Get(UserSettings.UserInterfaceSettings.UISetting.Language, string.Empty);
		if (string.IsNullOrEmpty(chosen))
		{
			chosen = FindSystemLanguage();
		}
		return CheckPath(chosen) ?? throw new DirectoryNotFoundException();
	}

	private static string FindSystemLanguage()
	{
		if (!Directory.Exists("Translations/"))
		{
			return null;
		}
		CultureInfo culture = CultureInfo.InstalledUICulture;
		string[] wanted = { culture.Name, culture.TwoLetterISOLanguageName };
		foreach (string locale in wanted)
		{
			foreach (string dir in Directory.GetDirectories("Translations/"))
			{
				string manifestPath = Path.Combine(dir, "manifest.json");
				if (!File.Exists(manifestPath))
				{
					continue;
				}
				try
				{
					TranslationManifest manifest = JsonSerialize.FromFile<TranslationManifest>(manifestPath);
					if ((manifest.SystemLocales ?? Array.Empty<string>()).Contains(locale, StringComparer.OrdinalIgnoreCase))
					{
						return Path.GetFileName(dir);
					}
				}
				catch (Exception ex)
				{
					Debug.LogWarning("Invalid translation manifest " + manifestPath + ": " + ex.Message);
				}
			}
		}
		return null;
	}

	// Client-only: puts the language's ForcedFontOrder fonts (e.g. NotoSansCJKkr-RegularDynamic) first among TMP fallbacks.
	private static void ApplyFontOrder(TranslationManifest manifest)
	{
		if (TMP_Settings.instance == null)
		{
			return;
		}
		List<TMP_FontAsset> fallbacks = TMP_Settings.fallbackFontAssets;
		if (defaultFallbacks == null)
		{
			defaultFallbacks = fallbacks.ToArray();
		}
		fallbacks.Clear();
		fallbacks.AddRange(defaultFallbacks);
		string[] order = manifest.ForcedFontOrder ?? Array.Empty<string>();
		for (int i = order.Length - 1; i >= 0; i--)
		{
			TMP_FontAsset font = defaultFallbacks.FirstOrDefault((TMP_FontAsset f) => f != null && f.name.Equals(order[i], StringComparison.OrdinalIgnoreCase));
			if (font != null)
			{
				fallbacks.Remove(font);
				fallbacks.Insert(0, font);
			}
		}
	}

	private static void LoadPositions()
	{
		string[] files = Directory.GetFiles(CheckPath());
		foreach (string path in files)
		{
			string[] array = File.ReadAllLines(path);
			Dictionary<int, Dictionary<string, int>> dictionary = new Dictionary<int, Dictionary<string, int>>();
			for (int j = 0; j < array.Length; j++)
			{
				Dictionary<string, int> dictionary2 = new Dictionary<string, int>();
				MatchCollection matchCollection = _matchFormat.Matches(array[j]);
				for (int k = 0; k < matchCollection.Count; k++)
				{
					dictionary2.TryAdd(matchCollection[k].Value, k);
				}
				dictionary.Add(j, dictionary2);
			}
			_positions.Add(Path.GetFileNameWithoutExtension(path), dictionary);
		}
	}

	private static TranslationManifest LoadTranslation(string translationPath, Dictionary<string, string[]> dictionary)
	{
		dictionary.Clear();
		if (File.Exists(translationPath + "Legacy_Interfaces.txt") && File.Exists(translationPath + "Legancy_Interfaces.txt"))
		{
			File.Delete(translationPath + "Legancy_Interfaces.txt");
		}
		foreach (string item in Directory.EnumerateFiles(translationPath, "*.txt"))
		{
			string[] array = FileManager.ReadAllLines(item);
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = array[i].Replace("\\n", Environment.NewLine);
				foreach (Match item2 in _matchFormat.Matches(array[i]))
				{
					if (_positions.TryGetValue(Path.GetFileNameWithoutExtension(item), out var value) && value.TryGetValue(i, out var value2) && value2.TryGetValue(item2.Value, out var value3))
					{
						array[i] = array[i].Replace(item2.Value, "{" + value3 + "}");
					}
				}
			}
			string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(item);
			dictionary[(fileNameWithoutExtension == "Legancy_Interfaces") ? "Legacy_Interfaces" : fileNameWithoutExtension] = array;
		}
		try
		{
			return JsonSerialize.FromFile<TranslationManifest>(Path.Combine(translationPath, "manifest.json"));
		}
		catch (FileNotFoundException)
		{
			return new TranslationManifest(Path.GetFileName(translationPath), Array.Empty<string>(), Array.Empty<string>(), Array.Empty<string>(), Array.Empty<string>());
		}
	}

	private static string CheckPath(params string[] suffixes)
	{
		if (suffixes == null || suffixes.Length == 0)
		{
			return CheckDefaultLangPath();
		}
		foreach (string text in suffixes)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				string text2 = Path.Combine("Translations/", text);
				if (CheckPathInternal(text2))
				{
					return text2;
				}
			}
		}
		return CheckDefaultLangPath();
	}

	private static string CheckDefaultLangPath()
	{
		string text = Path.Combine("Translations/", "en");
		if (!CheckPathInternal(text))
		{
			return null;
		}
		return text;
	}

	private static bool CheckPathInternal(string path)
	{
		if (Directory.Exists(path))
		{
			return Directory.EnumerateFileSystemEntries(path).Any();
		}
		return false;
	}

	public static string[] GetKeys(string keyName)
	{
		if (keyName == "Legancy_Interfaces")
		{
			keyName = "Legacy_Interfaces";
		}
		if (Fallback.TryGetValue(keyName, out var value))
		{
			return value;
		}
		Debug.LogWarning("Tried to get **FALLBACK** translation from nonexistent file " + keyName);
		return null;
	}

	public static string[] GetFallbackKeys(string keyName)
	{
		if (keyName == "Legancy_Interfaces")
		{
			keyName = "Legacy_Interfaces";
		}
		if (!Fallback.TryGetValue(keyName, out var value))
		{
			return null;
		}
		return value;
	}

	public static string Get(string keyName, int index, string defaultValue = "NO_TRANSLATION")
	{
		if (GameCore.Console.TranslationDebugMode)
		{
			return $"{keyName}:{index}";
		}
		if (keyName == "Legancy_Interfaces")
		{
			keyName = "Legacy_Interfaces";
		}
		// The server build only reads the English fallback; the client prefers the selected language.
		if (Elements.TryGetValue(keyName, out var selected) && selected.TryGet(index, out var element) && !string.IsNullOrWhiteSpace(element))
		{
			return element;
		}
		return GetFallback(keyName, index, defaultValue) ?? defaultValue;
	}

	public static bool TryGet(string keyName, int index, out string val)
	{
		// The server build only reads the English fallback; the client prefers the selected language.
		if (Elements.TryGetValue(keyName, out var selected) && selected.TryGet(index, out var selectedElement) && !string.IsNullOrWhiteSpace(selectedElement))
		{
			val = selectedElement;
			return true;
		}
		if (Fallback.TryGetValue(keyName, out var value) && value.TryGet(index, out var element) && !string.IsNullOrWhiteSpace(element))
		{
			val = element;
			return true;
		}
		val = GetFallback(keyName, index, "NO_TRANSLATION");
		return false;
	}

	private static string GetFallback(string keyName, int index, string defaultvalue)
	{
		if (Fallback.TryGetValue(keyName, out var value) && value.TryGet(index, out var element) && !string.IsNullOrWhiteSpace(element))
		{
			return element;
		}
		Debug.LogWarning(string.Format("Missing **FALLBACK** translation! {0}:{1}. Default value: {2}", keyName, index, defaultvalue.Replace("<", "(<)")));
		return null;
	}

	public static string GetFormatted(string keyName, int index, string defaultvalue, object obj1)
	{
		return string.Format(Get(keyName, index, defaultvalue), obj1);
	}

	public static string GetFormatted(string keyName, int index, string defaultvalue, object obj1, object obj2)
	{
		return string.Format(Get(keyName, index, defaultvalue), obj1, obj2);
	}

	public static string GetFormatted(string keyName, int index, string defaultvalue, object obj1, object obj2, object obj3)
	{
		return string.Format(Get(keyName, index, defaultvalue), obj1, obj2, obj3);
	}

	public static string GetFormatted(string keyName, int index, string defaultvalue, params object[] format)
	{
		return string.Format(Get(keyName, index, defaultvalue), format);
	}
}
