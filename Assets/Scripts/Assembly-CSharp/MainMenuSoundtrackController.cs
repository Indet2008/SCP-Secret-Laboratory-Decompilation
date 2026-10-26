using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// Client-only behaviour (bodies stripped from the server build). The state machine follows the SL 12 CE client;
// the selectable themes (Themes / AddTheme / PlayTheme) follow the v14 dump layout.
public class MainMenuSoundtrackController : MonoBehaviour
{
	public enum MenuSoundtrackState
	{
		MenuJustLoaded = 0,
		MenuLoop = 1,
		MenuIntensive = 2,
		Muted = 3,
		Retro = 4,
		PregameLobby = 5
	}

	public enum MenuThemeSetting
	{
		RegularTheme = 0,
		EventTheme = 1
	}

	[System.Serializable]
	public struct MenuAltTheme
	{
		public string Name;

		public AudioClip Theme;
	}

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public AudioSource ToposThemeSource;

	public AudioClip IntroClip;

	public AudioClip ToposClip;

	public float ToposMetric;

	public float ToposLength;

	public AudioSource IntenseThemeSource;

	public float IntenseDropTime;

	public int IntenseSequencesToDrop;

	public float IntenseOldToposFadeoffTime;

	public AudioSource RetroThemeSource;

	public MenuSoundtrackState SoundtrackState;

	public AnimationCurve FadeoffAnimationCurve;

	public AudioSource LobbyThemeSource;

	[SerializeField]
	public List<MenuAltTheme> Themes;

	public bool DebugMode;

	public bool DebugTrigger;

	public MenuSoundtrackState DebugOverride;

	private float fadeoffAnim;

	private CustomNetworkManager cnm;

	public static MainMenuSoundtrackController Singleton;

	public static bool DontPlayIntensive;

	private const string ThemePrefsPrefix = "MenuTheme_";

	// No seasonal event music is shipped in this build.
	private static bool HasEventMusic => false;

	public static MenuThemeSetting ThemePrefsKey => HasEventMusic ? MenuThemeSetting.EventTheme : MenuThemeSetting.RegularTheme;

	public static string[] GetThemeNames
	{
		get
		{
			if (Singleton == null || Singleton.Themes == null)
			{
				return new string[0];
			}
			string[] names = new string[Singleton.Themes.Count];
			for (int i = 0; i < names.Length; i++)
			{
				names[i] = Singleton.Themes[i].Name.Trim('"');
			}
			return names;
		}
	}

	public static int SelectedTheme
	{
		get
		{
			return PlayerPrefsSl.Get(ThemePrefsPrefix + ThemePrefsKey, 0);
		}
		set
		{
			PlayerPrefsSl.Set(ThemePrefsPrefix + ThemePrefsKey, value);
			if (Singleton != null)
			{
				Singleton.SetPreferredTheme(forcePlay: true);
			}
		}
	}

	private void Awake()
	{
		Singleton = this;
		cnm = GetComponentInParent<CustomNetworkManager>();
		SceneManager.sceneLoaded += OnSceneLoaded;
	}

	private void Start()
	{
		Scene scene = SceneManager.GetActiveScene();
		OnSceneLoaded(scene, LoadSceneMode.Single);
	}

	private void OnDestroy()
	{
		SceneManager.sceneLoaded -= OnSceneLoaded;
		if (Singleton == this)
		{
			Singleton = null;
		}
	}

	public static void AddTheme(MenuAltTheme theme)
	{
		Singleton?.Themes.Add(theme);
	}

	public static void InsertTheme(int index, MenuAltTheme theme)
	{
		Singleton?.Themes.Insert(index, theme);
	}

	public void PlayTheme(AudioClip clip)
	{
		if (ToposThemeSource == null)
		{
			return;
		}
		SoundtrackState = MenuSoundtrackState.MenuLoop;
		DontPlayIntensive = true;
		ToposThemeSource.Stop();
		ToposThemeSource.clip = clip;
		ToposThemeSource.loop = true;
		ToposThemeSource.volume = 1f;
		ToposThemeSource.time = 0f;
		ToposThemeSource.Play();
	}

	private void SetPreferredTheme(bool forcePlay)
	{
		int selected = SelectedTheme;
		if (Themes != null && selected > 0 && selected < Themes.Count && Themes[selected].Theme != null)
		{
			if (forcePlay || ToposThemeSource.clip != Themes[selected].Theme)
			{
				PlayTheme(Themes[selected].Theme);
			}
			return;
		}
		if (!forcePlay && (ToposThemeSource.clip == IntroClip || ToposThemeSource.clip == ToposClip) && ToposThemeSource.isPlaying)
		{
			return;
		}
		// Default theme: intro, then the looping Topos track (with the intensive layer while connecting).
		DontPlayIntensive = false;
		SoundtrackState = MenuSoundtrackState.MenuJustLoaded;
		ToposThemeSource.Stop();
		ToposThemeSource.volume = 1f;
		ToposThemeSource.loop = false;
		ToposThemeSource.clip = IntroClip;
		if (IntenseThemeSource != null)
		{
			IntenseThemeSource.volume = 0f;
		}
		if (IntroClip != null)
		{
			ToposThemeSource.Play();
		}
	}

	private void MuteTheme()
	{
		DontPlayIntensive = true;
		SoundtrackState = MenuSoundtrackState.Muted;
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		if (ToposThemeSource == null)
		{
			return;
		}
		if (!scene.name.Contains("Menu"))
		{
			MuteTheme();
			return;
		}
		SetPreferredTheme(forcePlay: false);
	}

	private void LateUpdate()
	{
		if (DebugMode && DebugTrigger)
		{
			SoundtrackState = DebugOverride;
			DebugTrigger = false;
		}
		if (ToposThemeSource == null)
		{
			return;
		}
		if (ToposThemeSource.clip == ToposClip)
		{
			if (ToposThemeSource.time >= ToposLength)
			{
				ToposMetric += Time.deltaTime * ToposThemeSource.pitch;
			}
			else
			{
				ToposMetric = ToposThemeSource.time;
			}
			if (ToposMetric > ToposLength)
			{
				ToposMetric -= ToposLength;
			}
		}
		if (SoundtrackState == MenuSoundtrackState.MenuLoop && !DebugMode && !DontPlayIntensive && cnm != null && cnm.ShouldPlayIntensive())
		{
			SoundtrackState = MenuSoundtrackState.MenuIntensive;
		}
		if (SoundtrackState == MenuSoundtrackState.MenuJustLoaded && !ToposThemeSource.isPlaying)
		{
			ToposThemeSource.Stop();
			ToposThemeSource.clip = ToposClip;
			ToposThemeSource.loop = true;
			ToposThemeSource.time = 0f;
			ToposThemeSource.Play();
			ToposMetric = 0f;
			SoundtrackState = MenuSoundtrackState.MenuLoop;
		}
		if (SoundtrackState == MenuSoundtrackState.MenuIntensive)
		{
			if (!DebugMode && cnm != null && !cnm.ShouldPlayIntensive())
			{
				SoundtrackState = MenuSoundtrackState.MenuLoop;
			}
			if (IntenseThemeSource != null)
			{
				if (!IntenseThemeSource.isPlaying)
				{
					IntenseThemeSource.Play();
				}
				IntenseThemeSource.volume += Time.deltaTime * 0.5f;
				if (IntenseThemeSource.time > IntenseOldToposFadeoffTime)
				{
					ToposThemeSource.volume -= Time.deltaTime * 0.5f;
				}
			}
		}
		else if (SoundtrackState == MenuSoundtrackState.Retro)
		{
			if (RetroThemeSource != null && !RetroThemeSource.isPlaying)
			{
				ToposThemeSource.Stop();
				IntenseThemeSource?.Stop();
				RetroThemeSource.Play();
			}
		}
		else
		{
			if (IntenseThemeSource != null)
			{
				IntenseThemeSource.volume -= Time.deltaTime / 6f;
			}
			if (SoundtrackState == MenuSoundtrackState.Muted || SoundtrackState == MenuSoundtrackState.PregameLobby)
			{
				fadeoffAnim += Time.deltaTime;
				if ((IntenseThemeSource == null || IntenseThemeSource.volume <= 0f) && FadeoffAnimationCurve != null && FadeoffAnimationCurve.length > 0)
				{
					ToposThemeSource.volume = FadeoffAnimationCurve.Evaluate(fadeoffAnim);
				}
			}
			else
			{
				ToposThemeSource.volume += Time.deltaTime * 0.5f;
			}
			if (SoundtrackState == MenuSoundtrackState.PregameLobby && LobbyThemeSource != null && (IntenseThemeSource == null || IntenseThemeSource.volume <= 0.01f))
			{
				if (!LobbyThemeSource.isPlaying)
				{
					LobbyThemeSource.Play();
				}
				LobbyThemeSource.volume = 1f - ToposThemeSource.volume;
			}
			else if (LobbyThemeSource != null)
			{
				LobbyThemeSource.volume = Mathf.Max(0f, LobbyThemeSource.volume - Time.deltaTime * 0.1f);
				if (LobbyThemeSource.volume == 0f)
				{
					LobbyThemeSource.Stop();
				}
			}
		}
		if (SoundtrackState == MenuSoundtrackState.PregameLobby && ReferenceHub.TryGetLocalHub(out var hub) && hub.isLocalPlayer)
		{
			SoundtrackState = MenuSoundtrackState.Muted;
		}
		if (SoundtrackState != MenuSoundtrackState.Muted && SoundtrackState != MenuSoundtrackState.PregameLobby)
		{
			fadeoffAnim = 0f;
		}
		if (SoundtrackState != MenuSoundtrackState.Retro && RetroThemeSource != null)
		{
			RetroThemeSource.Stop();
		}
	}
}
