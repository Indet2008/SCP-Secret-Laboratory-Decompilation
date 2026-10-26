using System.Runtime.InteropServices;
using System.Threading;
using GameCore;
using NorthwoodLib;
using NorthwoodLib.Logging;
using UnityEngine;

public class PlatformInfo : MonoBehaviour
{
	public static PlatformInfo singleton;

	public bool IsHeadless { get; } = true;

	public bool IsIl2Cpp { get; }

	public bool IsEditor { get; }

	public bool UsesCustomLauncher { get; }

	public string BuildGuid { get; private set; }

	public bool IsWindows { get; } = RuntimeInformation.IsOSPlatform(OSPlatform.Windows);

	public bool IsLinux { get; } = RuntimeInformation.IsOSPlatform(OSPlatform.Linux);

	public int MainThreadId { get; private set; }

	public bool IsMainThread => Thread.CurrentThread.ManagedThreadId == MainThreadId;

	private void Awake()
	{
		MainThreadId = Thread.CurrentThread.ManagedThreadId;
		BuildGuid = Application.buildGUID;
		singleton = this;
		Console.AddLog("Loaded NorthwoodLib " + PlatformSettings.Version, Color.green);
		PlatformSettings.Logged += OnLogged;
	}

	private static void OnLogged(string text, NorthwoodLib.Logging.LogType type)
	{
		switch (type)
		{
		case NorthwoodLib.Logging.LogType.Debug:
			Debug.Log(text);
			break;
		case NorthwoodLib.Logging.LogType.Info:
			Console.AddLog(text, Color.blue);
			break;
		case NorthwoodLib.Logging.LogType.Warning:
			Console.AddLog(text, Color.yellow);
			break;
		case NorthwoodLib.Logging.LogType.Error:
			Console.AddLog(text, Color.red);
			break;
		default:
			Debug.Log(text);
			break;
		}
	}
}
