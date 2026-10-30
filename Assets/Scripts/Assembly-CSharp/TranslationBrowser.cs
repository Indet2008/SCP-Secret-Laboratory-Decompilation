using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using UnityEngine;

public class TranslationBrowser : MonoBehaviour
{
	public global::UnityEngine.UI.Text instancePrefab;

	public global::UnityEngine.Transform parent;

	private readonly List<GameObject> spawns = new List<GameObject>();

	public static readonly List<(string, bool)> Translations = new List<(string, bool)>();

	public static readonly Dictionary<string, string> Languages = new Dictionary<string, string>();

	public static readonly Dictionary<string, string> Names = new Dictionary<string, string>();

	private void OnEnable()
	{
		foreach (GameObject spawn in spawns)
		{
			Object.Destroy(spawn);
		}
		spawns.Clear();
		GetTranslationList();
		foreach (var (text, flag) in Translations)
		{
			global::UnityEngine.UI.Text text2 = Object.Instantiate(instancePrefab, parent);
			text2.transform.localScale = Vector3.one;
			text2.text = text;
			if (flag)
			{
				text2.color = Color.red;
			}
			spawns.Add(text2.gameObject);
		}
	}

	private void OnDisable()
	{
		foreach (GameObject spawn in spawns)
		{
			Object.Destroy(spawn);
		}
		spawns.Clear();
	}

	public static int GetTranslationList()
	{
		string[] directories = Directory.GetDirectories("Translations");
		string currentLanguage = TranslationReader.TranslationDirectoryName;
		Translations.Clear();
		Languages.Clear();
		Names.Clear();
		int result = 0;
		for (int i = 0; i < directories.Length; i++)
		{
			string text = directories[i];
			string fileName = Path.GetFileName(text);
			if (currentLanguage == fileName)
			{
				result = i;
			}
			string path = Path.Combine(text, "manifest.json");
			string text2 = null;
			if (File.Exists(path))
			{
				TranslationManifest translationManifest = JsonSerialize.FromJson<TranslationManifest>(FileManager.ReadAllText(path));
				if (!string.IsNullOrWhiteSpace(translationManifest.Name))
				{
					text2 = GetFreeName(translationManifest.Name);
				}
			}
			if (text2 == null)
			{
				text2 = (Misc.CultureInfoTryParse(fileName, out var info) ? GetFreeName(GetTranslationName(info)) : fileName);
			}
			Names[text2] = fileName;
			Languages[fileName] = text2;
			bool item = Directory.EnumerateFiles(text, "*.txt").Any((string f) => File.ReadAllText(f, System.Text.Encoding.UTF8).Contains("�"));
			Translations.Add((text2, item));
		}
		return result;
	}

	public static string NameToDirectory(string name)
	{
		if (!Names.TryGetValue(name, out var value))
		{
			return name;
		}
		if (!Languages.TryGetValue(value, out var _))
		{
			return name;
		}
		return value;
	}

	private static string GetFreeName(string name)
	{
		string text = name;
		int num = 0;
		while (Languages.ContainsKey(text) || Names.ContainsKey(text))
		{
			num++;
			text = string.Format("{0} {1}", name, num);
		}
		return text;
	}

	private static string GetTranslationName(CultureInfo c)
	{
		return FirstToUpper(c.NativeName, c) + " - " + FirstToUpper(c.EnglishName, c);
	}

	private static string FirstToUpper(string s, CultureInfo c)
	{
		if (s.Length > 0 && char.IsLower(s, 0))
		{
			return c.TextInfo.ToUpper(s[0]) + s.Substring(1, s.Length - 1);
		}
		return s;
	}
}
