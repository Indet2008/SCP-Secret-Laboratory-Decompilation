using System;
using System.Collections.Generic;
using System.IO;
using GameCore;

public static class WhiteList
{
	public static bool WhitelistEnabled;

	public static readonly HashSet<string> Users;

	static WhiteList()
	{
		Users = new HashSet<string>();
		Reload();
	}

	public static void Reload()
	{
		WhitelistEnabled = ConfigFile.ServerConfig.GetBool("enable_whitelist");
		string path = ConfigSharing.Paths[2] + "UserIDWhitelist.txt";
		Users.Clear();
		if (!File.Exists(path))
		{
			FileManager.WriteStringToFile("#Put one UserID (eg. 76561198071934271@steam or 274613382353518592@discord) per line. Lines prefixed with \"#\" are ignored.", path);
			return;
		}
		using (StreamReader streamReader = new StreamReader(path))
		{
			while (true)
			{
				string text = streamReader.ReadLine();
				if (text != null)
				{
					if (!string.IsNullOrWhiteSpace(text) && !text.TrimStart().StartsWith("#", StringComparison.Ordinal) && text.Contains("@", StringComparison.Ordinal))
					{
						Users.Add(text.Trim());
					}
					continue;
				}
				break;
			}
		}
		ServerConsole.AddLog("Whitelist has been loaded.");
	}

	public static bool IsOnWhitelist(string userId)
	{
		return Users.Contains(userId);
	}

	public static bool IsWhitelisted(string userId)
	{
		if (WhitelistEnabled)
		{
			return Users.Contains(userId);
		}
		return true;
	}
}
