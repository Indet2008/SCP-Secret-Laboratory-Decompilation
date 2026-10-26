using System;
using PlayerRoles;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Client-only (the server build ships every method empty). Ported from the SL 12 CE client onto the v14 signatures,
// using Facepunch.Steamworks. Needs the Steam client running and logged in.
public class SteamManager : MonoBehaviour
{
	private const uint SteamAppId = 700330u;

	private static AuthTicket _ticket;

	private static string _state = string.Empty;

	public static bool Running { get; private set; }

	public static ulong SteamId64 { get; private set; }

	public static bool IsSteamReady()
	{
		if (Running)
		{
			return SteamClient.IsValid;
		}
		return false;
	}

	private void Awake()
	{
		if (!Running && !ServerStatic.IsDedicated)
		{
			StartClient();
		}
	}

	private void Start()
	{
		SceneManager.sceneLoaded += OnLevelFinishedLoading;
		ReferenceHub.OnPlayerAdded += RefreshPlayerCount;
		ReferenceHub.OnPlayerRemoved += RefreshPlayerCount;
		PlayerRoleManager.OnRoleChanged += OnPlayerRoleChanged;
	}

	private void FixedUpdate()
	{
		if (Running)
		{
			SteamClient.RunCallbacks();
		}
	}

	private void OnApplicationQuit()
	{
		CancelTicket();
		StopClient();
	}

	private void OnDestroy()
	{
		SceneManager.sceneLoaded -= OnLevelFinishedLoading;
		ReferenceHub.OnPlayerAdded -= RefreshPlayerCount;
		ReferenceHub.OnPlayerRemoved -= RefreshPlayerCount;
		PlayerRoleManager.OnRoleChanged -= OnPlayerRoleChanged;
	}

	public static void StartClient()
	{
		if (SteamClient.IsValid)
		{
			Running = true;
			return;
		}
		Dispatch.OnException = OnSteamException;
		Dispatch.OnDebugCallback = OnDebugCallback;
		try
		{
			SteamClient.Init(SteamAppId, asyncCallbacks: false);
			if (!SteamClient.IsLoggedOn)
			{
				_state = "Client isn't logged-on.";
				Debug.LogWarning("[SteamManager] " + _state);
				StopClient();
				return;
			}
			SteamId64 = SteamClient.SteamId;
			Running = true;
			_state = "Loaded";
			GameCore.Console.AddLog("Steam client started: " + SteamClient.Name + " (" + SteamId64 + ")", UnityEngine.Color.green);
		}
		catch (Exception ex)
		{
			_state = "Steam init failed: " + ex.Message;
			Debug.LogWarning("[SteamManager] " + _state);
			StopClient();
		}
	}

	private static void OnDebugCallback(CallbackType arg1, string arg2, bool arg3)
	{
	}

	private static void OnSteamException(Exception ex)
	{
		Debug.LogWarning("[SteamManager] " + ex.Message);
	}

	public static void StopClient()
	{
		Running = false;
		_ticket = null;
		try
		{
			if (SteamClient.IsValid)
			{
				SteamClient.Shutdown();
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SteamManager] Shutdown failed: " + ex.Message);
		}
	}

	public static void RestartSteam()
	{
		StopClient();
		StartClient();
	}

	public static void SetAchievement(string key)
	{
		if (IsSteamReady())
		{
			new Achievement(key).Trigger();
		}
	}

	public static void ResetAchievement(string key)
	{
		if (IsSteamReady())
		{
			new Achievement(key).Clear();
		}
	}

	public static bool CheckAchievement(string key)
	{
		if (IsSteamReady())
		{
			return new Achievement(key).State;
		}
		return false;
	}

	public static void ChangePreset(int classId)
	{
		if (IsSteamReady())
		{
			SteamFriends.SetRichPresence("class", classId.ToString());
		}
	}

	public static void ChangeLobbyStatus(int cur, int max)
	{
		if (IsSteamReady())
		{
			SteamFriends.SetRichPresence("lobbystatus", cur + "/" + max);
		}
	}

	public static void ClearRichPresence()
	{
		if (IsSteamReady())
		{
			SteamFriends.ClearRichPresence();
		}
	}

	public static bool IndicateAchievementProgress(string name, int curProgress, int maxProgress)
	{
		if (IsSteamReady())
		{
			return SteamUserStats.IndicateAchievementProgress(name, curProgress, maxProgress);
		}
		return false;
	}

	public static void SetStat(string key, int value)
	{
		if (IsSteamReady())
		{
			SteamUserStats.SetStat(key, value);
		}
	}

	public static int GetStat(string key)
	{
		if (IsSteamReady())
		{
			return SteamUserStats.GetStatInt(key);
		}
		return 0;
	}

	public static string GetPersonaName(ulong steamid = 0uL)
	{
		if (!IsSteamReady())
		{
			return null;
		}
		if (steamid == 0L || steamid == SteamId64)
		{
			return SteamClient.Name;
		}
		return new Friend(steamid).Name;
	}

	public static AuthTicket GetAuthSessionTicket()
	{
		if (!IsSteamReady())
		{
			return null;
		}
		_ticket = SteamUser.GetAuthSessionTicket(default(NetIdentity));
		return _ticket;
	}

	public static void CancelTicket()
	{
		_ticket?.Cancel();
		_ticket = null;
	}

	public static void OpenProfile(ulong steamid = 0uL)
	{
		if (IsSteamReady())
		{
			SteamFriends.OpenUserOverlay((steamid == 0L) ? SteamId64 : steamid, "steamid");
		}
	}

	public static string GetApiState()
	{
		if (!IsSteamReady())
		{
			if (!string.IsNullOrEmpty(_state))
			{
				return _state;
			}
			return "Not loaded";
		}
		return "Loaded";
	}

	public static void RefreshToken()
	{
		CancelTicket();
		GetAuthSessionTicket();
	}

	private void OnUserAuthenticated(ReferenceHub hub, CentralAuth.ClientInstanceMode mode)
	{
		RefreshPlayerCount(hub);
	}

	private void RefreshPlayerCount(ReferenceHub hub)
	{
		ChangeLobbyStatus(ReferenceHub.AllHubs.Count, CustomNetworkManager.slots);
	}

	private void OnPlayerRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase curRole)
	{
		if (hub != null && hub.isLocalPlayer)
		{
			ChangePreset((int)curRole.RoleTypeId);
		}
	}

	private void OnRichPresenceChanged(bool val)
	{
		if (!val)
		{
			ClearRichPresence();
		}
	}

	private static void OnLevelFinishedLoading(Scene scene, LoadSceneMode mode)
	{
		if (scene.name.Contains("Menu"))
		{
			ChangePreset(-2);
		}
		else if (scene.name == "Facility")
		{
			ChangePreset(-1);
		}
	}
}
