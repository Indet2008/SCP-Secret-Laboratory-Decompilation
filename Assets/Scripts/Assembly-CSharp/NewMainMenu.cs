using System.Linq;
using Mirror.LiteNetLib4Mirror;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// The server build hollowed this class. The bodies follow the SL 12 CE client, adapted to the v14 API;
// the scene's Button events call these methods directly.
public class NewMainMenu : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.GameObject[] submenus;

	public global::UnityEngine.Audio.AudioMixer mainMixer;

	public global::UnityEngine.GameObject DirectConnectPopup;

	public global::TMPro.TMP_InputField DirectConnectTextField;

	public global::UnityEngine.UI.Text Version;

	public global::UnityEngine.GameObject Tabs;

	public global::UnityEngine.UI.Text RejoinText;

	public ButtonAudio RejoinButtonAudio;

	public global::UnityEngine.UI.RawImage RejoinIcon;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.GameObject _rentServerButton;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.GameObject _createServerButton;

	private static readonly Color RejoinEnabledColor = Color.white;

	private static readonly Color RejoinDisabledColor = new Color(1f, 1f, 1f, 0.3f);

	private CustomNetworkManager _mng;

	private static string _autoConnectIp;

	private static bool _alreadyJoined;

	public static NewMainMenu Singleton { get; private set; }

	private void Awake()
	{
		Singleton = this;
	}

	private void OnDestroy()
	{
		if (Singleton == this)
		{
			Singleton = null;
		}
	}

	private void Start()
	{
		_mng = FindObjectOfType<CustomNetworkManager>();
		if (_mng == null)
		{
			Debug.LogError("[NewMainMenu] CustomNetworkManager not found. Enter Play mode from the PreLoader or Loader scene.");
		}
		ChangeMenu(0);
		if (DirectConnectPopup != null)
		{
			DirectConnectPopup.SetActive(false);
		}
		if (Version != null)
		{
			Version.text = GameCore.Version.VersionString;
		}
		if (Tabs != null)
		{
			Tabs.SetActive(true);
		}
		CustomNetworkManager.LastIp = FavoriteAndHistory.IPHistory.LastOrDefault();
		UpdateRejoinButton();
		bool flag = false;
		foreach (string arg in StartupArgs.Args)
		{
			if (flag)
			{
				_autoConnectIp = arg;
				flag = false;
			}
			else if (arg == "+connect")
			{
				flag = true;
			}
		}
		Steamworks.SteamMatchmaking.OnLobbyGameCreated -= OnLobbyGameCreated;
		Steamworks.SteamMatchmaking.OnLobbyGameCreated += OnLobbyGameCreated;
	}

	private void Update()
	{
		UpdateRejoinButton();
		UpdateAutoJoin();
	}

	private void UpdateAutoJoin()
	{
		if (!_alreadyJoined && !string.IsNullOrEmpty(_autoConnectIp) && CentralAuth.CentralAuthManager.AuthStatusType != AuthStatusType.Connecting)
		{
			_alreadyJoined = true;
			string autoConnectIp = _autoConnectIp;
			_autoConnectIp = null;
			Connect(autoConnectIp);
		}
	}

	private void OnLobbyGameCreated(Steamworks.Data.Lobby lobby, uint ip, ushort port, Steamworks.SteamId serverId)
	{
		Connect(ip + ":" + port);
	}

	private void UpdateRejoinButton()
	{
		bool canRejoin = !string.IsNullOrEmpty(CustomNetworkManager.LastIp);
		Color color = canRejoin ? RejoinEnabledColor : RejoinDisabledColor;
		if (RejoinText != null)
		{
			RejoinText.color = color;
		}
		if (RejoinIcon != null)
		{
			RejoinIcon.color = color;
		}
		if (RejoinButtonAudio != null)
		{
			RejoinButtonAudio.enabled = canRejoin;
		}
	}

	public void ChangeMenu(int id)
	{
		if (submenus == null)
		{
			return;
		}
		for (int i = 0; i < submenus.Length; i++)
		{
			if (submenus[i] != null)
			{
				submenus[i].SetActive(i == id);
			}
		}
	}

	public void DirectConnectClick()
	{
		if (DirectConnectPopup == null)
		{
			return;
		}
		bool open = !DirectConnectPopup.activeSelf;
		DirectConnectPopup.SetActive(open);
		if (open && DirectConnectTextField != null)
		{
			if (string.IsNullOrEmpty(DirectConnectTextField.text))
			{
				DirectConnectTextField.text = CustomNetworkManager.LastIp ?? string.Empty;
			}
			DirectConnectTextField.ActivateInputField();
		}
	}

	public void QuitGame()
	{
		Shutdown.Quit();
	}

	public void Refresh()
	{
		// The public server list comes from Northwood's central servers, which this build cannot reach.
		Debug.Log("[NewMainMenu] The public server list needs the central server and is not available here.");
	}

	public void StartServer()
	{
		if (_mng != null)
		{
			_mng.ShowCreateServerPopup();
		}
	}

	public void ReJoin()
	{
		if (!string.IsNullOrEmpty(CustomNetworkManager.LastIp))
		{
			Connect(CustomNetworkManager.LastIp, skipValidation: true);
		}
	}

	public void Connect()
	{
		if (DirectConnectTextField != null)
		{
			Connect(DirectConnectTextField.text);
		}
	}

	public void Connect(string ip, bool skipValidation = false)
	{
		ip = ip?.Trim();
		if (string.IsNullOrEmpty(ip) || _mng == null)
		{
			return;
		}
		if (CrashDetector.singleton != null && CrashDetector.singleton.Show())
		{
			return;
		}
		if (!SetIPOrHost(ip, skipValidation))
		{
			return;
		}
		if (DirectConnectPopup != null)
		{
			DirectConnectPopup.SetActive(false);
		}
		CustomNetworkManager.LastIp = ip;
		FavoriteAndHistory.Modify(FavoriteAndHistory.StorageLocation.IPHistory, ip);
		_mng.StartClient();
	}

	// Accepts "[v6]:port", "host:port", a bare IPv6 address or a bare host.
	private bool SetIPOrHost(string ip, bool skipValidation)
	{
		string host = ip;
		ushort port = 7777;
		if (ip.StartsWith("["))
		{
			int close = ip.IndexOf(']');
			if (close < 0)
			{
				return Fail(ip);
			}
			host = ip.Substring(1, close - 1);
			if (close + 1 < ip.Length && (ip[close + 1] != ':' || !ushort.TryParse(ip.Substring(close + 2), out port)))
			{
				return Fail(ip);
			}
		}
		else if (ip.Count(c => c == ':') == 1)
		{
			int colon = ip.IndexOf(':');
			host = ip.Substring(0, colon);
			if (!ushort.TryParse(ip.Substring(colon + 1), out port))
			{
				return Fail(ip);
			}
		}
		if (!skipValidation && !Misc.ValidateIpOrHostname(host, out _))
		{
			return Fail(ip);
		}
		_mng.networkAddress = host;
		LiteNetLib4MirrorTransport.Singleton.clientAddress = host;
		LiteNetLib4MirrorTransport.Singleton.port = port;
		return true;
	}

	private bool Fail(string ip)
	{
		_mng.ShowLog(11, ip, string.Empty);
		return false;
	}
}
