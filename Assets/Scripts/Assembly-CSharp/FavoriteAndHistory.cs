using System;
using System.Collections.Generic;
using System.IO;
using GameCore;
using UnityEngine;

public class FavoriteAndHistory : MonoBehaviour
{
	public enum StorageLocation
	{
		History = 0,
		Favorites = 1,
		IPHistory = 2
	}

	public const int MaxHistoryAmount = 10;

	public static readonly List<string> Favorites;

	public static readonly List<string> History;

	public static readonly List<string> IPHistory;

	public static string ServerIDLastJoined;

	public static string AccountIDLastJoined;

	public static readonly Dictionary<StorageLocation, List<string>> LocationToList;

	private static readonly Dictionary<StorageLocation, string> StorageEnumToPath;

	public static string GetPath(StorageLocation location)
	{
		return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/" + StorageEnumToPath[location];
	}

	public static void ResetServerID()
	{
		ServerIDLastJoined = string.Empty;
	}

	static FavoriteAndHistory()
	{
		Favorites = new List<string>();
		History = new List<string>();
		IPHistory = new List<string>();
		LocationToList = new Dictionary<StorageLocation, List<string>>
		{
			{
				StorageLocation.History,
				History
			},
			{
				StorageLocation.Favorites,
				Favorites
			},
			{
				StorageLocation.IPHistory,
				IPHistory
			}
		};
		StorageEnumToPath = new Dictionary<StorageLocation, string>
		{
			{
				StorageLocation.History,
				"history.txt"
			},
			{
				StorageLocation.Favorites,
				"favorites.txt"
			},
			{
				StorageLocation.IPHistory,
				"iphistory.txt"
			}
		};
		foreach (KeyValuePair<StorageLocation, List<string>> locationTo in LocationToList)
		{
			Load(locationTo.Key);
		}
	}

	public static void Load(StorageLocation location)
	{
		GameCore.Console.AddLog("Loading " + location, Color.grey);
		try
		{
			List<string> list = LocationToList[location];
			list.Clear();
			if (!File.Exists(GetPath(location)))
			{
				Revert(StorageEnumToPath[location]);
			}
			StreamReader streamReader = new StreamReader(GetPath(location));
			string text;
			while ((text = streamReader.ReadLine()) != null)
			{
				if (!string.IsNullOrEmpty(text) && !list.Contains(text))
				{
					list.Add(text);
				}
			}
			streamReader.Close();
		}
		catch (Exception ex)
		{
			Debug.Log("REVENT: " + ex.StackTrace + " - " + ex.Message);
			Revert(StorageEnumToPath[location]);
		}
	}

	public static void Modify(StorageLocation location, string id, bool delete = false)
	{
		List<string> list = LocationToList[location];
		list.RemoveAll((string x) => x == id);
		if (!delete)
		{
			list.Add(id);
		}
		StreamWriter streamWriter = new StreamWriter(GetPath(location), append: false);
		foreach (string item in list)
		{
			streamWriter.WriteLine(item);
		}
		streamWriter.Close();
		Load(location);
		if ((location == StorageLocation.History || location == StorageLocation.IPHistory) && list.Count >= 10)
		{
			HistoryLimit(location, id);
		}
	}

	private static void HistoryLimit(StorageLocation location, string id)
	{
		int num = 0;
		List<string> list = LocationToList[location];
		if (list.Contains(id))
		{
			num = list.RemoveAll((string x) => x == id);
		}
		if (num == 0)
		{
			list.RemoveAt(0);
		}
		list.Add(id);
		StreamWriter streamWriter = new StreamWriter(GetPath(location), append: false);
		foreach (string item in list)
		{
			streamWriter.WriteLine(item);
		}
		streamWriter.Close();
		Load(location);
	}

	public static bool IsInStorage(StorageLocation location, string id)
	{
		return LocationToList[location].Contains(id);
	}

	private static void Revert(string fileName)
	{
		Debug.Log("Reverting:" + fileName);
		new StreamWriter(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/" + fileName).Close();
	}
}
