using System.Collections.Generic;
using MEC;
using Mirror;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

// Client-only (every body was stripped from the server build). Rebuilt after the SL 12 CE client: shows hints and
// scene-load progress while connecting/hosting, and hides itself once the Facility scene has finished loading.
public class LoadingScreen : MonoBehaviour
{
	public CanvasGroup selfGroup;

	public GameObject root;

	public Image image;

	public Image loadingCircle;

	public Image oldImage;

	public TextMeshProUGUI hints;

	public TextMeshProUGUI progress;

	public int framesToNext;

	public Sprite[] backgrounds;

	[UnityEngine.Serialization.FormerlySerializedAs("hints_text")]
	public string[] hintsText;

	public string description;

	private CoroutineHandle _checkLoadingScreen;

	private int _currentFrames;

	private int _lastProgress;

	private static bool _noFade;

	private static bool _loaded;

	private static bool _loadedSet;

	private string _currentLoadedScene;

	private const string _facilitySceneName = "Assets/_Scenes/Facility.unity";

	private static LoadingScreen _singleton;

	public LoadingScreen()
	{
		framesToNext = 600;
	}

	private void Awake()
	{
		_singleton = this;
		SceneManager.sceneLoaded += OnSceneLoaded;
	}

	private void Start()
	{
		TranslationReader.OnTranslationsRefreshed += RefreshHints;
		RefreshHints();
	}

	private void OnDestroy()
	{
		SceneManager.sceneLoaded -= OnSceneLoaded;
		TranslationReader.OnTranslationsRefreshed -= RefreshHints;
		if (_singleton == this)
		{
			_singleton = null;
		}
	}

	private void RefreshHints()
	{
		hintsText = TranslationReader.Elements.TryGetValue("LoadingHints", out var selected) ? selected : TranslationReader.GetKeys("LoadingHints");
		description = TranslationReader.Get("Connection_Info", 1, "Loading");
		SetProgress(_lastProgress);
		Next();
	}

	private void OnEnable()
	{
		if (loadingCircle != null)
		{
			loadingCircle.fillAmount = 0f;
		}
		SetProgress(0);
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		_currentLoadedScene = scene.name;
		if (scene.name == "Facility")
		{
			// The map is generated in SeedSynchronizer.Awake during the load; once the scene is in, the screen can go.
			FinishedLoading();
		}
		else if (scene.name.ToLowerInvariant().Contains("menu") && !NetworkClient.active && !NetworkServer.active)
		{
			ResetToDefault();
		}
	}

	private void CheckIfStuck()
	{
		// Stuck in a menu with the loading screen up and no connection: hide it.
		if (!NetworkClient.active && !NetworkServer.active && root != null && root.activeSelf && _currentLoadedScene != null && _currentLoadedScene.ToLowerInvariant().Contains("menu"))
		{
			ResetToDefault();
		}
	}

	private void ResetToDefault()
	{
		_currentFrames = 0;
		_noFade = true;
		_loaded = false;
		_loadedSet = false;
		if (root != null)
		{
			root.SetActive(false);
		}
		if (Timing.IsRunning(_checkLoadingScreen))
		{
			Timing.KillCoroutines(_checkLoadingScreen);
		}
	}

	private IEnumerator<float> _CheckLoadingScreenStuck()
	{
		while (root != null && root.activeSelf)
		{
			yield return Timing.WaitForSeconds(3f);
			CheckIfStuck();
		}
	}

	private void FixedUpdate()
	{
		if (root == null || !root.activeSelf)
		{
			if (selfGroup != null)
			{
				selfGroup.alpha = 0f;
			}
			_currentFrames = 0;
			return;
		}
		if (!Timing.IsRunning(_checkLoadingScreen))
		{
			_checkLoadingScreen = Timing.RunCoroutine(_CheckLoadingScreenStuck());
		}
		if (selfGroup != null)
		{
			selfGroup.alpha = _noFade ? 1f : Mathf.Min(1f, selfGroup.alpha + Time.fixedDeltaTime);
		}
		if (++_currentFrames > framesToNext)
		{
			_currentFrames = 0;
			Next();
		}
		AsyncOperation load = NetworkManager.loadingSceneAsync;
		if (load != null && NetworkManager.networkSceneName == _facilitySceneName)
		{
			if (loadingCircle != null)
			{
				loadingCircle.fillAmount = load.progress;
			}
			SetProgress((int)(load.progress * 100f));
		}
		else if (_loaded && !_loadedSet)
		{
			_loadedSet = true;
			root.SetActive(false);
		}
	}

	private void SetProgress(int percent)
	{
		if (progress != null && (percent != _lastProgress || percent == 0))
		{
			progress.SetText(description + " " + percent + "%");
		}
		_lastProgress = percent;
	}

	private void Next()
	{
		if (oldImage != null && image != null)
		{
			oldImage.sprite = image.sprite;
		}
		if (image != null && backgrounds != null && backgrounds.Length != 0)
		{
			image.sprite = backgrounds[Random.Range(0, backgrounds.Length)];
		}
		if (hints != null && hintsText != null && hintsText.Length != 0)
		{
			hints.SetText(hintsText[Random.Range(0, hintsText.Length)]);
		}
	}

	// Called when the loading screen is shown, so a previous load's "finished" state doesn't hide it straight away.
	internal static void BeginLoading()
	{
		_loaded = false;
		_loadedSet = false;
	}

	internal static void FinishedLoading()
	{
		_noFade = true;
		_loaded = true;
		_loadedSet = false;
	}
}
