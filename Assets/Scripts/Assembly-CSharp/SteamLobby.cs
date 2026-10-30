using System.Collections.Generic;
using GameCore;
using Mirror;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;
using UserSettings;
using UserSettings.OtherSettings;

// Rebuilt from the 14.2.8 client disassembly (the server build ships this class empty).
public class SteamLobby : MonoBehaviour
{
	public static SteamLobby singleton;

	public static List<string> FriendsServer = new List<string>();

	private Lobby _lobby;

	private Lobby _newLobby;

	private bool _waitingForScene;

	private bool _waitingForSafeTime;

	private float _safeTime;

	private string _serverIp;

	private string ClientIpAddress => string.Format("{0}:{1}", NetworkManager.singleton.networkAddress, Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorTransport.Singleton.port);

	public Lobby Lobby => _lobby;

	private void Awake()
	{
		if (singleton != null)
		{
			Object.DestroyImmediate(base.gameObject);
			return;
		}
		singleton = this;
		Object.DontDestroyOnLoad(base.gameObject);
		SceneManager.sceneLoaded += OnSceneLoaded;
		SteamFriends.OnGameLobbyJoinRequested += OnGameLobbyJoinRequested;
		SteamMatchmaking.OnLobbyCreated += OnLobbyCreated;
		SteamMatchmaking.OnLobbyEntered += OnLobbyEntered;
		SteamMatchmaking.OnLobbyMemberJoined += OnLobbyMemberJoined;
		SteamMatchmaking.OnLobbyMemberLeave += OnLobbyMemberLeave;
		SteamFriends.OnGameServerChangeRequested += OnGameServerChangeRequested;
		SteamFriends.OnGameRichPresenceJoinRequested += OnGameRichPresenceJoinRequested;
		UserSetting<int>.AddListener(MiscPrivacySetting.SteamLobbyPrivacy, SetLobbyPrivacy);
	}

	private void OnGameRichPresenceJoinRequested(Friend friend, string ip)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			ProcessJoiningServerRuntime(ip);
		});
	}

	private void ProcessJoiningServerRuntime(string ip)
	{
		if (NetworkClient.active)
		{
			if (ip == ClientIpAddress)
			{
				Console.AddLog("[SteamServer] You are already connected to this server!", UnityEngine.Color.yellow);
				return;
			}
			if (SceneManager.GetActiveScene().name.ToLower().Contains("facility"))
			{
				Console.AddLog("[SteamServer] Exiting the current server...", UnityEngine.Color.yellow);
				_serverIp = ip;
				_waitingForScene = true;
				Console.AddLog("[SteamServer] Waiting for scene changed to connect...", UnityEngine.Color.yellow);
				Object.FindObjectOfType<GameMenu>()?.Disconnect();
				return;
			}
		}
		Console.AddLog("[SteamServer] Connect to server " + ip, UnityEngine.Color.yellow);
		ServerConnect(ip);
	}

	private void OnGameServerChangeRequested(string ip, string password)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			ProcessJoiningServerRuntime(ip);
		});
	}

	private void ServerConnect(string ip)
	{
		NewMainMenu newMainMenu = Object.FindObjectOfType<NewMainMenu>();
		if (newMainMenu != null)
		{
			newMainMenu.Connect(ip);
		}
	}

	private void FixedUpdate()
	{
		if (_waitingForSafeTime)
		{
			_safeTime -= Time.fixedDeltaTime;
			if (!(_safeTime > 0f))
			{
				_waitingForSafeTime = false;
				Console.AddLog("Scene changing finished. Connecting..." + _newLobby.Id.Value, UnityEngine.Color.yellow);
				if (string.IsNullOrEmpty(_serverIp))
				{
					Connect(_newLobby);
				}
				else
				{
					ServerConnect(_serverIp);
					_serverIp = null;
				}
			}
		}
	}

	private void SetLobbyPrivacy(int privacyType)
	{
		if (_lobby.Id.Value == 0L)
		{
			return;
		}
		SteamLobbyPrivacy steamLobbyPrivacy = (SteamLobbyPrivacy)privacyType;
		if (TrySetLobbyPrivacy(steamLobbyPrivacy))
		{
			Console.AddLog(string.Format("Setting Steam Lobby to {0}!", steamLobbyPrivacy), UnityEngine.Color.green);
		}
		else
		{
			Console.AddLog(string.Format("Failed to set Steam Lobby to {0}.", steamLobbyPrivacy), UnityEngine.Color.red);
		}
	}

	private bool TrySetLobbyPrivacy(SteamLobbyPrivacy privacyType)
	{
		return privacyType switch
		{
			SteamLobbyPrivacy.Private => _lobby.SetPrivate(),
			SteamLobbyPrivacy.Friends => _lobby.SetFriendsOnly(),
			SteamLobbyPrivacy.Public => _lobby.SetPublic(),
			_ => false,
		};
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		if (scene.name.Contains("Menu"))
		{
			if (_waitingForScene)
			{
				_waitingForScene = false;
				_waitingForSafeTime = true;
				_safeTime = 1f;
			}
		}
		else if (!scene.name.Contains("Facility"))
		{
			LeaveLobby();
		}
	}

	private async void OnGameLobbyJoinRequested(Lobby lobby, SteamId steamId)
	{
		if (_lobby.Id.Value != 0L)
		{
			LeaveLobby();
		}
		RoomEnter roomEnter = await lobby.Join();
		if (roomEnter != RoomEnter.Success)
		{
			Console.AddLog("[SteamLobby] Failed to join lobby: " + roomEnter, UnityEngine.Color.red);
			return;
		}
		_newLobby = lobby;
		if (NetworkClient.active && SceneManager.GetActiveScene().name.ToLower().Contains("facility"))
		{
			_waitingForScene = true;
			Object.FindObjectOfType<GameMenu>()?.Disconnect();
		}
		else
		{
			Connect(lobby);
		}
	}

	private void OnLobbyCreated(Result result, Lobby lobby)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			Console.AddLog("Lobby created:" + lobby.Id.Value + " Result:" + result, UnityEngine.Color.green);
		});
	}

	private void OnLobbyEntered(Lobby lobby)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			_lobby = lobby;
			SetLobbyPrivacy(UserSetting<int>.Get(MiscPrivacySetting.SteamLobbyPrivacy));
		});
	}

	private void OnLobbyMemberJoined(Lobby lobby, Friend friend)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			Console.AddLog(friend.Id.Value + " joined lobby:" + lobby.Id.Value, UnityEngine.Color.green);
			RefreshPreLobby(lobby, "OnMemberJoined");
		});
	}

	private void OnLobbyMemberLeave(Lobby lobby, Friend friend)
	{
		MainThreadDispatcher.Dispatch(delegate
		{
			Console.AddLog(friend.Id.Value + " left lobby:" + lobby.Id.Value, UnityEngine.Color.green);
			RefreshPreLobby(lobby, "OnMemberLeave");
		});
	}

	private static void RefreshPreLobby(Lobby lobby, string source)
	{
		if (!(lobby.GetData("IsPreLobby") != "true"))
		{
			SteamPreLobby steamPreLobby = Object.FindObjectOfType<SteamPreLobby>();
			if (steamPreLobby == null)
			{
				Console.AddLog("prelobby null:" + source, UnityEngine.Color.red);
			}
			else
			{
				steamPreLobby.RefreshList(lobby);
			}
		}
	}

	private void Connect(Lobby lobby)
	{
		if (lobby.GetData("IsPreLobby") == "true")
		{
			SteamPreLobby steamPreLobby = Object.FindObjectOfType<SteamPreLobby>();
			if (steamPreLobby != null)
			{
				steamPreLobby.RefreshList(lobby);
			}
			return;
		}
		string data = lobby.GetData("ipaddress");
		NewMainMenu newMainMenu = Object.FindObjectOfType<NewMainMenu>();
		if (newMainMenu == null)
		{
			Console.AddLog("[SteamLobby] Cannot connect to " + data + ". MainMenu is not loaded.", UnityEngine.Color.red);
			return;
		}
		Console.AddLog("[SteamLobby] Connecting to " + data, UnityEngine.Color.green);
		newMainMenu.Connect(data);
	}

	public async void CreateLobby(int maxMembers, bool preLobby = false)
	{
		if (_lobby.Id.Value != 0L)
		{
			LeaveLobby();
		}
		Lobby? lobby = await SteamMatchmaking.CreateLobbyAsync(maxMembers);
		if (!lobby.HasValue)
		{
			Console.AddLog("[SteamLobby] Failed to create lobby.", UnityEngine.Color.red);
			return;
		}
		_lobby = lobby.Value;
		if (preLobby)
		{
			_lobby.SetData("IsPreLobby", "true");
		}
		else
		{
			_lobby.SetData("ipaddress", ClientIpAddress);
			SteamFriends.SetRichPresence("connect", ClientIpAddress);
		}
		SetLobbyPrivacy(UserSetting<int>.Get(MiscPrivacySetting.SteamLobbyPrivacy));
	}

	public void LeaveLobby()
	{
		if (SteamManager.IsSteamReady())
		{
			SteamFriends.SetRichPresence("connect", null);
		}
		if (_lobby.Id.Value != 0L)
		{
			Console.AddLog("Leaving lobby:" + _lobby.Id.Value, UnityEngine.Color.yellow);
			_lobby.Leave();
			_lobby = default(Lobby);
		}
	}

	public void ShowLobbyInfo()
	{
		ShowLobbyInfo(_lobby);
	}

	public void ShowLobbyInfo(Lobby lobby)
	{
		bool flag = UserSetting<bool>.Get(UserSettings.UserInterfaceSettings.UISetting.HideIP);
		string text = "[Steam Lobby Info]\nLobbyId:" + lobby.Id.Value + "\nOwner:" + lobby.Owner.Name + " (" + lobby.Owner.Id.Value + ")\nIP Address:" + (flag ? "[HIDDEN]" : lobby.GetData("ipaddress")) + "\nMembers(" + lobby.MemberCount + "/" + lobby.MaxMembers + "):\n";
		foreach (Friend member in lobby.Members)
		{
			text = text + member.Name + "\n";
		}
		Console.AddLog(text, UnityEngine.Color.cyan);
	}

	public bool IsInLobby(Lobby lobby, string steamId)
	{
		foreach (Friend member in lobby.Members)
		{
			Console.AddLog("friend.id:" + member.Id.Value, UnityEngine.Color.gray);
			if (member.Id.Value.ToString() == steamId)
			{
				Console.AddLog("return true", UnityEngine.Color.gray);
				return true;
			}
		}
		return false;
	}

	public static async void RefreshFriendsServer()
	{
		FriendsServer.Clear();
		Lobby[] array = await SteamMatchmaking.LobbyList.RequestAsync();
		if (array == null)
		{
			return;
		}
		Lobby[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			string data = array2[i].GetData("ipaddress");
			if (!string.IsNullOrEmpty(data))
			{
				FriendsServer.Add(data);
			}
		}
	}
}
