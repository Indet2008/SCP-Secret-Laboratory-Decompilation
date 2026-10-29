using System.Diagnostics;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class DebugInfoLoader : MonoBehaviour
{
	public Text Audio;

	public Text Cpu;

	public Text CpuThreadsAndFrequency;

	public Text Gpu;

	public Text DriverVersion;

	public Text GraphicApi;

	public Text Os;

	public Text Ram;

	public Text Resolution;

	public Text Fullscreen;

	public Text ShaderLevel;

	public Text Steam;

	public Text UnityVersion;

	public Text GameVersion;

	public Text Build;

	public Text GameLanguage;

	public Text GameScene;

	public Text Errors;

	public Text CentralServerText;

	private string _centralserver = string.Empty;

	private bool _updateOnNextFrame;

	private readonly Stopwatch _stopwatch = new Stopwatch();

	private void Awake()
	{
		SceneManager.sceneLoaded += delegate
		{
			_updateOnNextFrame = true;
		};
	}

	private void OnEnable()
	{
		_stopwatch.Restart();
		UpdateData();
	}

	private static void SetText(Text text, string value)
	{
		if (text != null)
		{
			text.text = value;
		}
	}

	private void UpdateData()
	{
		SetText(Gpu, "GPU: " + SystemInfo.graphicsDeviceName);
		SetText(DriverVersion, "GPU Driver: " + GpuDriver.DriverVersion);
		SetText(ShaderLevel, "VRAM: " + SystemInfo.graphicsMemorySize + "MB ShaderLevel: " + SystemInfo.graphicsShaderLevel.ToString().Insert(1, "."));
		SetText(GraphicApi, "Graphic API: " + SystemInfo.graphicsDeviceType.ToString() + " " + SystemInfo.graphicsDeviceVersion);
		SetText(Resolution, "Resolution: " + Screen.width + "x" + Screen.height + " " + ((QualitySettings.vSyncCount == 0) ? string.Format("FPS Limit: {0}", Application.targetFrameRate) : string.Format("VSync: {0}", QualitySettings.vSyncCount)));
		SetText(Fullscreen, "Fullscreen: " + Screen.fullScreenMode);
		SetText(Cpu, "CPU: " + SystemInfo.processorType);
		SetText(CpuThreadsAndFrequency, "Threads: " + SystemInfo.processorCount + " " + SystemInfo.processorFrequency + "MHz");
		SetText(Ram, "RAM: " + SystemInfo.systemMemorySize + "MB");
		SetText(Audio, "Audio Supported: " + (SystemInfo.supportsAudio ? "True" : "False"));
		SetText(Os, "OS: " + NorthwoodLib.OperatingSystem.VersionString);
		SetText(UnityVersion, "Unity " + Application.unityVersion);
		SetText(GameVersion, "Version: " + GameCore.Version.VersionString);
		SetText(Build, "Build: " + Application.buildGUID);
		SetText(GameLanguage, "Language: " + TranslationReader.TranslationDirectoryName);
		SetText(GameScene, "Scene: " + SceneManager.GetActiveScene().name);
		SetText(Steam, "Steam: " + (SteamManager.Running ? "Running" : "No auth platform!"));
		SetText(Errors, "Asserts: " + DebugScreenController.Asserts + " Errors: " + DebugScreenController.Errors + " Exceptions: " + DebugScreenController.Exceptions);
		SetText(CentralServerText, "Central Server: " + _centralserver);
	}

	private void Update()
	{
		if (_stopwatch.ElapsedMilliseconds >= 15000)
		{
			_stopwatch.Restart();
			_updateOnNextFrame = true;
		}
		if (_updateOnNextFrame)
		{
			_updateOnNextFrame = false;
			UpdateData();
		}
	}

	private void FixedUpdate()
	{
		string text = CentralServer.SelectedServer;
		if (!string.IsNullOrEmpty(text) && !_centralserver.Contains(text))
		{
			_centralserver = text;
			SetText(CentralServerText, "Central Server: " + _centralserver);
		}
	}
}
