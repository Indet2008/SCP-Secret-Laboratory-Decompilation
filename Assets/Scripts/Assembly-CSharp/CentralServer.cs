using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using GameCore;
using UnityEngine;

public class CentralServer : MonoBehaviour
{
	internal static readonly string[] AllowedDomains = new string[5] { "scpslgame.com", "northwoodstudios.org", "scpsecretlab.com", "scpsecretlaboratory.com", "youshouldnthavebeenhacking.com" };

	public static readonly Regex CentralServerRegex = new Regex("^[a-zA-Z0-9]*$", RegexOptions.CultureInvariant);

	private static string _serversPath;

	private static bool _started;

	private static object _refreshLock;

	private static List<string> _workingServers;

	private static DateTime _lastReset;

	internal static bool Abort;

	public static string CurrentDomain { get; private set; } = "scpslgame.com";

	public static string MasterUrl { get; private set; }

	public static string StandardUrl { get; private set; }

	public static string SelectedServer { get; internal set; }

	public static bool TestServer { get; internal set; }

	public static bool ServerSelected { get; private set; }

	internal static string[] Servers { get; private set; }

	private void Start()
	{
		Init();
	}

	internal static void Init()
	{
		if (_started)
		{
			return;
		}
		_started = true;
		if (HttpQuery.WeakSecurity)
		{
			CurrentDomain = "scpsecretlaboratory.com";
		}
		_lastReset = DateTime.MinValue;
		Servers = Array.Empty<string>();
		_workingServers = new List<string>();
		_refreshLock = new object();
		_serversPath = FileManager.GetAppFolder() + "internal/";
		LoadPrefs();
		if (SelectedServer != null)
		{
			ServerSelected = true;
			ServerConsole.AddLog("Using central server selected by the startup arg: " + SelectedServer + " (" + StandardUrl + ")");
			return;
		}
		if (File.Exists(FileManager.GetAppFolder() + "testserver.txt") || StartupArgs.Args.Any((string arg) => string.Equals(arg, "-cstest", StringComparison.OrdinalIgnoreCase)))
		{
			SelectedServer = "test";
			TestServer = true;
			UpdateUrl();
			ServerSelected = true;
			ServerConsole.AddLog("Using TEST central server: " + MasterUrl);
			return;
		}
		TestServer = false;
		UpdateUrl();
		if (!Directory.Exists(_serversPath))
		{
			Directory.CreateDirectory(_serversPath);
		}
		_serversPath += "CentralServers";
		if (File.Exists(_serversPath))
		{
			Servers = FileManager.ReadAllLines(_serversPath);
			if (Servers.Any((string server) => !CentralServerRegex.IsMatch(server)))
			{
				GameCore.Console.AddLog("Malformed server found on the list. Removing the list and redownloading it from api." + CurrentDomain + ".", Color.yellow);
				Servers = Array.Empty<string>();
				try
				{
					File.Delete(_serversPath);
				}
				catch (Exception ex)
				{
					GameCore.Console.AddLog("Failed to delete malformed central server list.\nException: " + ex.Message, Color.red);
				}
				Thread thread = new Thread(() =>
				{
					RefreshServerList(planned: true, loop: true);
				});
				thread.IsBackground = true;
				thread.Priority = System.Threading.ThreadPriority.BelowNormal;
				thread.Name = "SCP:SL Server list refreshing";
				thread.Start();
				return;
			}
			_workingServers = Servers.ToList();
			if (!ServerStatic.IsDedicated)
			{
				GameCore.Console.AddLog("Cached central servers count: " + Servers.Length, Color.grey);
			}
			if (Servers.Length != 0)
			{
				System.Random random = new System.Random();
				SelectedServer = Servers[random.Next(Servers.Length)];
				UpdateUrl();
				if (ServerStatic.IsDedicated)
				{
					ServerConsole.AddLog("Selected central server: " + SelectedServer + " (" + StandardUrl + ")");
				}
				else
				{
					GameCore.Console.AddLog("Selected central server: " + SelectedServer + " (" + StandardUrl + ")", Color.grey);
				}
			}
		}
		Thread thread2 = new Thread(() =>
		{
			RefreshServerList(planned: true, loop: true);
		});
		thread2.IsBackground = true;
		thread2.Priority = System.Threading.ThreadPriority.BelowNormal;
		thread2.Name = "SCP:SL Server list refreshing";
		thread2.Start();
	}

	private static void LoadPrefs()
	{
		string[] args = StartupArgs.Args;
		foreach (string text in args)
		{
			if (text.StartsWith("-cs:", StringComparison.OrdinalIgnoreCase))
			{
				string text2 = text;
				string text3 = text2.Substring(4, text2.Length - 4);
				if (!CentralServerRegex.IsMatch(text3))
				{
					GameCore.Console.AddLog("Failed to change Central Server - startup arg.", Color.red);
					continue;
				}
				SelectedServer = text3;
				GameCore.Console.AddLog("Central Server changed - startup arg.", Color.yellow);
				UpdateUrl();
			}
			else if (text.StartsWith("-csd:", StringComparison.OrdinalIgnoreCase))
			{
				string text2 = text;
				if (ChangeDomain(text2.Substring(5, text2.Length - 5)))
				{
					GameCore.Console.AddLog("Central Server second-level domain has been changed - startup arg.", Color.yellow);
				}
				else
				{
					GameCore.Console.AddLog("Failed to change Central Server second-level domain - startup arg.", Color.red);
				}
			}
		}
	}

	internal static bool ChangeDomain(string domain)
	{
		domain = domain.ToLowerInvariant();
		if (!AllowedDomains.Contains<string>(domain))
		{
			return false;
		}
		CurrentDomain = domain;
		UpdateUrl();
		return true;
	}

	internal static void UpdateUrl()
	{
		StandardUrl = "https://" + SelectedServer + "." + CurrentDomain + "/";
		MasterUrl = (TestServer ? ("https://test." + CurrentDomain + "/") : ("https://api." + CurrentDomain + "/"));
	}

	private static void RefreshServerList(bool planned = false, bool loop = false)
	{
		while (!Abort)
		{
			lock (_refreshLock)
			{
				if (ServerSelected)
				{
					break;
				}
				if (_workingServers.Count == 0)
				{
					if (Servers.Length == 0)
					{
						SelectedServer = "api";
					}
					else
					{
						_workingServers = Servers.ToList();
						SelectedServer = _workingServers[0];
					}
					UpdateUrl();
				}
				byte b = 1;
				while (!Abort && b != 3)
				{
					b++;
					try
					{
						string[] array = HttpQuery.Get(StandardUrl + "servers.php").Split(';');
						if (File.Exists(_serversPath))
						{
							File.Delete(_serversPath);
						}
						FileManager.WriteToFile(array, _serversPath);
						GameCore.Console.AddLog("Updated list of central servers.", Color.green);
						GameCore.Console.AddLog("Central servers count: " + array.Length, Color.cyan);
						Servers = array;
						if (planned && Servers.All((string srv) => srv != SelectedServer))
						{
							_workingServers = Servers.ToList();
							ChangeCentralServer(remove: false);
						}
						ServerSelected = true;
					}
					catch (Exception ex)
					{
						GameCore.Console.AddLog("Can't update central servers list!", Color.red);
						GameCore.Console.AddLog("Error: " + ex.Message, Color.red);
						if (SelectedServer == "api")
						{
							ServerSelected = true;
							break;
						}
						ChangeCentralServer(remove: true);
						continue;
					}
					break;
				}
			}
			if (!loop)
			{
				break;
			}
			for (uint num = 0u; num < 180; num++)
			{
				if (Abort)
				{
					break;
				}
				Thread.Sleep(5000);
			}
		}
	}

	internal static bool ChangeCentralServer(bool remove)
	{
		ServerSelected = false;
		TestServer = false;
		if (SelectedServer == "api")
		{
			if (_lastReset >= DateTime.Now.AddMinutes(-2.0))
			{
				return false;
			}
			RefreshServerList();
			return true;
		}
		if (_workingServers.Count == 0)
		{
			GameCore.Console.AddLog("All known central servers aren't working.", Color.yellow);
			_workingServers.Add("api");
			SelectedServer = "api";
			UpdateUrl();
			GameCore.Console.AddLog("Changed central server: " + SelectedServer + " (" + StandardUrl + ")", Color.yellow);
			return true;
		}
		if (remove && _workingServers.Contains(SelectedServer))
		{
			_workingServers.Remove(SelectedServer);
		}
		if (_workingServers.Count == 0)
		{
			_workingServers.Add("api");
			SelectedServer = "api";
			UpdateUrl();
			GameCore.Console.AddLog("Changed central server: " + SelectedServer + " (" + StandardUrl + ")", Color.yellow);
			return true;
		}
		System.Random random = new System.Random();
		SelectedServer = _workingServers[random.Next(0, _workingServers.Count)];
		UpdateUrl();
		GameCore.Console.AddLog("Changed central server: " + SelectedServer + " (" + StandardUrl + ")", Color.yellow);
		return true;
	}
}
