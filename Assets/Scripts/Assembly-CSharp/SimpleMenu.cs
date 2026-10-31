using System;
using System.Collections.Generic;
using CentralAuth;
using MEC;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SimpleMenu : MonoBehaviour
{
	public bool isPreloader;

	private static bool _server;

	private static bool _forceSettings;

	private static string _targetSceneName;

	private const float minLoadingTime = 3f;

	internal static readonly string[] MenuSceneNames = new string[3] { "MainMenuRemastered", "NewMainMenu", "FastMenu" };

	private void Awake()
	{
		if (isPreloader)
		{
			return;
		}
		CentralAuthManager.InitAuth();
		string[] args = StartupArgs.Args;
		for (int i = 0; i < args.Length; i++)
		{
			switch (args[i])
			{
			case "-fastmenu":
				PlayerPrefsSl.Set("fastmenu", value: true);
				PlayerPrefsSl.Set("menumode", 2);
				break;
			case "-newmenu":
				PlayerPrefsSl.Set("menumode", 1);
				break;
			case "-nographics":
				_server = true;
				break;
			case "-forcemenu":
				_forceSettings = true;
				break;
			}
		}
		Refresh();
	}

	private void Start()
	{
		if (isPreloader)
		{
			StartCoroutine(PreloadScene());
		}
		else
		{
			Timing.RunCoroutine(StartLoad());
		}
	}

	private System.Collections.IEnumerator PreloadScene()
	{
		yield return null;
		AsyncOperation asyncOperation = SceneManager.LoadSceneAsync("Loader", LoadSceneMode.Single);
		asyncOperation.allowSceneActivation = true;
		LauncherAssetScanProgressBar.Text = "LOADING";
		LauncherAssetScanProgressBar.Progress = 0f;
		while (!asyncOperation.isDone)
		{
			LauncherAssetScanProgressBar.Progress = Math.Max(LauncherAssetScanProgressBar.Progress, asyncOperation.progress);
			yield return null;
		}
	}

	private IEnumerator<float> StartLoad()
	{
		yield return float.NegativeInfinity;
		if (isPreloader)
		{
			AsyncOperation asyncOperation = SceneManager.LoadSceneAsync("Loader", LoadSceneMode.Single);
			asyncOperation.allowSceneActivation = true;
			LauncherAssetScanProgressBar.Text = "LOADING";
			float sceneProgress = 0f;
			while (!asyncOperation.isDone)
			{
				sceneProgress = (LauncherAssetScanProgressBar.Progress = Math.Max(sceneProgress, asyncOperation.progress));
				yield return float.NegativeInfinity;
			}
		}
		else
		{
			// Fallback for the client path the server build stripped. Loader's MenuLoader normally loads the menu first;
			// MEC coroutines outlive the scene, so only load if we are still sitting in Loader.
			yield return Timing.WaitForSeconds(minLoadingTime);
			if (SceneManager.GetActiveScene().name == "Loader")
			{
				LoadCorrectScene();
			}
		}
	}

	public void ChangeMode()
	{
		PlayerPrefsSl.Set("fastmenu", value: false);
		PlayerPrefsSl.Set("menumode", 1);
		Refresh();
		LoadCorrectScene();
	}

	public static void ChangeMode(int id)
	{
		PlayerPrefsSl.Set("menumode", id);
		Refresh();
		LoadCorrectScene();
	}

	public static void Refresh()
	{
		_targetSceneName = (_server ? "FastMenu" : MenuSceneNames[(!_forceSettings) ? 1 : Mathf.Clamp(PlayerPrefsSl.Get("menumode", 1), 0, 2)]);
		UnityEngine.Object.FindObjectOfType<CustomNetworkManager>().offlineScene = _targetSceneName;
	}

	public static void LoadCorrectScene()
	{
		SceneManager.LoadScene(_targetSceneName);
	}
}
