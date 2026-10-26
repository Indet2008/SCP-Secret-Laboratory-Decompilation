using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;

public static class CreditsData
{
	public static bool RemoteLoaded;

	internal const string CurrentNicknamePlaceholder = "<current nickname>";

	private static readonly string CachePath;

	internal static CreditsCategory[] Data;

	static CreditsData()
	{
		CachePath = FileManager.GetAppFolder() + "CreditsCache.json";
		try
		{
			SetCredits(File.ReadAllText(CachePath));
		}
		catch
		{
			LoadData(File.ReadAllText("CreditsCache.json"));
		}
	}

	internal static void LoadData(string text)
	{
		try
		{
			SetCredits(text);
			File.WriteAllText(CachePath, text);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private static void SetCredits(string text)
	{
		if (!text.StartsWith('{'))
		{
			throw new ArgumentException("Invalid credits data", "text");
		}
		CreditsList creditsList = JsonSerialize.FromJson<CreditsList>(text);
		List<CreditsCategory> list = new List<CreditsCategory>();
		TranslationManifest[] array = (from s in Directory.EnumerateFiles("Translations/", "manifest.json", SearchOption.AllDirectories)
			select JsonSerialize.FromFile<TranslationManifest>(s)).ToArray();
		for (int num = 0; num < creditsList.credits.Length; num++)
		{
			CreditsListCategory creditsListCategory = creditsList.credits[num];
			List<CreditsEntry> list2 = new List<CreditsEntry>();
			for (int num2 = 0; num2 < creditsListCategory.members.Length; num2++)
			{
				list2.Add(ProcessEntry(creditsListCategory.members[num2]));
			}
			if (creditsListCategory.category.Equals("SPECIAL THANKS", StringComparison.OrdinalIgnoreCase))
			{
				list2.Add(new CreditsEntry(TranslationReader.Get("NewMainMenu", 87, "For playing our game!"), "<current nickname>", new Color32(byte.MaxValue, 215, 0, byte.MaxValue)));
				list.Add(new CreditsCategory
				{
					Header = creditsListCategory.category,
					Records = list2.ToArray()
				});
				list2.Clear();
				TranslationManifest[] array2 = array;
				for (int num3 = 0; num3 < array2.Length; num3++)
				{
					TranslationManifest translationManifest = array2[num3];
					string text2 = translationManifest.Name;
					if (!text2.Equals("en", StringComparison.OrdinalIgnoreCase))
					{
						int num4 = translationManifest.Name.IndexOf('-');
						if (num4 > -1)
						{
							text2 = translationManifest.Name.Substring(num4 + 2);
						}
						string[] authors = translationManifest.Authors;
						foreach (string name in authors)
						{
							list2.Add(new CreditsEntry(text2, name));
						}
						list2.Add(new CreditsEntry("", ""));
					}
				}
				list.Add(new CreditsCategory
				{
					Header = "COMMUNITY TRANSLATORS",
					Records = list2.ToArray()
				});
			}
			else
			{
				list.Add(new CreditsCategory
				{
					Header = creditsListCategory.category,
					Records = list2.ToArray()
				});
			}
		}
		Data = list.ToArray();
		RemoteLoaded = true;
	}

	private static CreditsEntry ProcessEntry(CreditsListMember member)
	{
		if (string.IsNullOrEmpty(member.name))
		{
			return new CreditsEntry();
		}
		if (!string.IsNullOrEmpty(member.title))
		{
			return new CreditsEntry(member.title, member.name, HexToColor(member));
		}
		return new CreditsEntry(member.name);
	}

	private static Color32 HexToColor(CreditsListMember member)
	{
		if (string.IsNullOrEmpty(member.color))
		{
			return Color.white;
		}
		if (Misc.TryParseColor(member.color, out var color))
		{
			return color;
		}
		Debug.LogError("Error during processing credits color (" + member.name + " - " + member.title + " - " + member.color + ").");
		return Color.white;
	}
}
