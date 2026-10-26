using System;
using System.Collections.Generic;
using System.IO;
using CentralAuth;
using GameCore;

public static class ReservedSlot
{
	public static readonly HashSet<string> Users;

	static ReservedSlot()
	{
		Users = new HashSet<string>();
		Reload();
	}

	public static void Reload()
	{
		string path = ConfigSharing.Paths[3] + "UserIDReservedSlots.txt";
		Users.Clear();
		if (!File.Exists(path))
		{
			FileManager.WriteStringToFile("#Put one UserID (eg. 76561198071934271@steam or 274613382353518592@discord) per line. Lines prefixed with \"#\" are ignored.", path);
			return;
		}
		using (StreamReader streamReader = new StreamReader(path))
		{
			string text;
			while ((text = streamReader.ReadLine()) != null)
			{
				if (!string.IsNullOrWhiteSpace(text) && !text.TrimStart().StartsWith("#", StringComparison.Ordinal) && text.Contains("@"))
				{
					Users.Add(text.Trim());
				}
			}
		}
		ServerConsole.AddLog("Reserved slots list has been loaded.");
	}

	public static bool HasReservedSlot(string userId)
	{
		if (!Users.Contains(userId.Trim()))
		{
			return !PlayerAuthenticationManager.OnlineMode;
		}
		return true;
	}
}
