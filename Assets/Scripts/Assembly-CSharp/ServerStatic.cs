using System;
using System.Diagnostics;
using LabApi.Loader;
using ServerOutput;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ServerStatic : MonoBehaviour
{
	public enum NextRoundAction : byte
	{
		DoNothing = 0,
		Restart = 1,
		Shutdown = 2
	}

	public static ushort ShutdownRedirectPort;

	public static YamlConfig RolesConfig;

	public static YamlConfig SharedGroupsConfig;

	public static YamlConfig SharedGroupsMembersConfig;

	public static string RolesConfigPath;

	public static PermissionsHandler PermissionsHandler;

	public static IServerOutput ServerOutput;

	internal static bool ProcessIdPassed;

	internal static bool DisableConfigValidation;

	internal static bool KeepSession;

	internal static bool EnableConsoleHeartbeat;

	private static short _serverTickrate = 60;

	private static bool _serverArgsProcessed;

	private static bool _serverPortSet;

	public static bool IsDedicated { get; private set; }

	public static NextRoundAction StopNextRound { get; set; } = NextRoundAction.DoNothing;

	public static short ServerTickrate
	{
		get
		{
			return _serverTickrate;
		}
		set
		{
			if (value < -1 || value == 0)
			{
				_serverTickrate = 60;
			}
			else
			{
				_serverTickrate = value;
			}
			if (IsDedicated)
			{
				Application.targetFrameRate = _serverTickrate;
				ServerConsole.AddLog("Server tickrate set to: " + _serverTickrate);
			}
		}
	}

	public static ushort ServerPort { get; private set; }

	private void Awake()
	{
		ProcessServerArgs();
		if (!IsDedicated)
		{
			Shutdown.Quit();
			return;
		}
		if (ServerOutput == null)
		{
			Shutdown.Quit();
			return;
		}
		ServerOutput.Start();
		if (IsDedicated)
		{
			AudioListener.volume = 0f;
			AudioListener.pause = true;
			QualitySettings.pixelLightCount = 0;
			ServerConsole.AddLog("SCP Secret Laboratory process started. Creating match...", ConsoleColor.Green);
			ServerTickrate = 60;
			if (!_serverPortSet)
			{
				ServerConsole.AddLog("\"-port\" argument is required for dedicated server. Aborting startup.", ConsoleColor.DarkRed);
				ServerConsole.AddLog("Make sure you are using latest version of LocalAdmin.", ConsoleColor.DarkRed);
				Shutdown.Quit();
				return;
			}
		}
		PluginLoader.Initialize();
		SceneManager.sceneLoaded += OnSceneWasLoaded;
	}

	[RuntimeInitializeOnLoadMethod]
	internal static void ProcessServerArgs()
	{
		if (_serverArgsProcessed)
		{
			return;
		}
		_serverArgsProcessed = true;
		int result = 0;
		int result2 = 0;
		for (int i = 0; i < StartupArgs.Args.Length; i++)
		{
			string text = StartupArgs.Args[i];
			switch (text)
			{
			case "-nographics":
				IsDedicated = true;
				continue;
			case "-keepsession":
				KeepSession = true;
				continue;
			case "-heartbeat":
				EnableConsoleHeartbeat = true;
				continue;
			case "-appdatapath":
				if (i < StartupArgs.Args.Length - 1)
				{
					FileManager.SetAppFolder(StartupArgs.Args[i + 1]);
					continue;
				}
				break;
			case "-txbuffer":
				if (i < StartupArgs.Args.Length - 1 && int.TryParse(StartupArgs.Args[i + 1], out result))
				{
					continue;
				}
				break;
			case "-rxbuffer":
				if (i < StartupArgs.Args.Length - 1 && int.TryParse(StartupArgs.Args[i + 1], out result2))
				{
					continue;
				}
				break;
			case "-configpath":
				if (i < StartupArgs.Args.Length - 1)
				{
					FileManager.SetConfigFolder(StartupArgs.Args[i + 1]);
					continue;
				}
				break;
			case "-disableconfigvalidation":
				DisableConfigValidation = true;
				continue;
			case "-stdout":
				if (!_serverPortSet && ServerOutput == null)
				{
					ServerOutput = new StandardOutput();
					continue;
				}
				break;
			}
			if (text.StartsWith("-key", StringComparison.Ordinal) && text.Length > 4 && !_serverPortSet && ServerOutput == null)
			{
				ServerOutput = new FileConsole(text.Remove(0, 4));
			}
			else if (text.StartsWith("-console", StringComparison.Ordinal) && ServerOutput == null)
			{
				if (ushort.TryParse(text.Remove(0, 8), out var result3))
				{
					ServerOutput = new TcpConsole(result3, result2, result);
				}
			}
			else if (text.StartsWith("-id", StringComparison.Ordinal) && !ProcessIdPassed)
			{
				ProcessIdPassed = true;
				if (int.TryParse(text.Remove(0, 3), out var result4))
				{
					ServerConsole.ConsoleProcess = Process.GetProcessById(result4);
				}
				if (ServerConsole.ConsoleProcess == null)
				{
					OnConsoleExited(null, null);
				}
				ServerConsole.ConsoleProcess.EnableRaisingEvents = true;
				ServerConsole.ConsoleProcess.Exited += OnConsoleExited;
			}
			else if (text.StartsWith("-port", StringComparison.Ordinal) && !_serverPortSet)
			{
				if (!ushort.TryParse(text.Remove(0, 5), out var result5))
				{
					ServerConsole.AddLog("\"-port\" argument value is not a valid unsigned short integer (0 - 65535). Aborting startup.");
					Shutdown.Quit();
					break;
				}
				ServerPort = result5;
				_serverPortSet = true;
			}
		}
	}

	private static void OnConsoleExited(object sender, EventArgs e)
	{
		ServerConsole.DisposeStatic();
		IsDedicated = false;
		UnityEngine.Debug.Log("OnConsoleExited");
		ServerConsole.ConsoleProcess?.Dispose();
		ServerConsole.ConsoleProcess = null;
		Shutdown.Quit();
	}

	private void OnSceneWasLoaded(Scene scene, LoadSceneMode mode)
	{
		if (IsDedicated)
		{
			int buildIndex = scene.buildIndex;
			if (buildIndex == 3 || buildIndex == 4)
			{
				GetComponent<CustomNetworkManager>().CreateMatch();
			}
		}
	}
}
