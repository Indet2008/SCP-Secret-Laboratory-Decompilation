public class NewServerBrowser : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.RectTransform ServerInfo;

	public global::UnityEngine.UI.Text LoadingText;

	public global::UnityEngine.GameObject ServerTabs;

	private static bool _errorDirty;

	private static bool _refresh;

	private static bool _redownload;

	private static bool _threadStarted;

	private static string _errorMessage;

	private static readonly global::System.Threading.Thread _refreshThread;

	public static ServerListItem[] Servers;

	private ServerFilter _serverFilter;

	public static bool IsBusy => _redownload;

	private static string LoadingErrorMessage
	{
		set
		{
			_errorMessage = value;
			_errorDirty = true;
		}
	}

	private void Start()
	{
		_serverFilter = GetComponent<ServerFilter>();
		ServerTabs.SetActive(value: false);
		ServerTabs.SetActive(value: true);
		if (!_threadStarted)
		{
			_refreshThread.Start();
			_threadStarted = true;
		}
	}

	private void OnEnable()
	{
		if (_serverFilter == null)
		{
			_serverFilter = GetComponent<ServerFilter>();
		}
		Refresh();
	}

	private void OnDisable()
	{
		_redownload = false;
	}

	private void OnDestroy()
	{
		_redownload = false;
	}

	private void Update()
	{
		if (_errorDirty)
		{
			_errorDirty = false;
			LoadingText.text = _errorMessage;
		}
		if (_refresh)
		{
			_refresh = false;
			_serverFilter.ReapplyFilters();
		}
	}

	public void Refresh()
	{
		if (_serverFilter.CurrentTab == ServerTab.Friends)
		{
			SteamLobby.RefreshFriendsServer();
		}
		_redownload = true;
		_refresh = true;
	}

	public void AuthCompleted()
	{
		if (_errorMessage == TranslationReader.Get("NewMainMenu", 67, "AUTHENTICATING"))
		{
			LoadingErrorMessage = TranslationReader.Get("MainMenu", 53, "DOWNLOADING DATA");
		}
		LauncherCommunicator.NotifyPostAuth();
	}

	internal static void StopThread()
	{
		if (_threadStarted)
		{
			_threadStarted = false;
		}
	}

	private static void DownloadList()
	{
		bool flag = true;
		while (_threadStarted)
		{
			_redownload = flag;
			while (!_redownload && _threadStarted)
			{
				global::System.Threading.Thread.Sleep(150);
			}
			while (global::CentralAuth.CentralAuthManager.AuthStatusType != AuthStatusType.PlatformAuthFailure && global::CentralAuth.CentralAuthManager.AuthStatusType != AuthStatusType.Success)
			{
				LoadingErrorMessage = TranslationReader.Get("NewMainMenu", 67, "AUTHENTICATING");
				if (global::CentralAuth.CentralAuthManager.AuthStatusType == AuthStatusType.Success || !_redownload || !_threadStarted)
				{
					break;
				}
				global::System.Threading.Thread.Sleep(150);
			}
			if (!_threadStarted)
			{
				break;
			}
			flag = false;
			if (!_redownload)
			{
				continue;
			}
			GameCore.Console.AddLog("Loading server list...", global::UnityEngine.Color.gray);
			LoadingErrorMessage = TranslationReader.Get("MainMenu", 53, "DOWNLOADING DATA");
			Servers = null;
			for (byte b = 0; b < 2; b++)
			{
				string text = null;
				try
				{
					text = HttpQuery.Post(CentralServer.StandardUrl + "lobbylist.php?format=json-signed-unix&version=2&minimal=1", "token=" + global::CentralAuth.CentralAuthManager.ApiToken + "&nonce=" + global::CentralAuth.CentralAuthManager.Nonce, "application/x-www-form-urlencoded");
					try
					{
						ServerListSigned serverListSigned = JsonSerialize.FromJson<ServerListSigned>(text);
						if (!string.IsNullOrEmpty(serverListSigned.nonce))
						{
							global::CentralAuth.CentralAuthManager.Nonce = serverListSigned.nonce;
						}
						if (!string.IsNullOrEmpty(serverListSigned.error))
						{
							LoadingErrorMessage = "Server returned an error.\n" + serverListSigned.error;
						}
						else if (!Cryptography.ECDSA.Verify(serverListSigned.payload + "##" + serverListSigned.timestamp, serverListSigned.signature, ServerConsole.PublicKey))
						{
							GameCore.Console.AddLog("Server list has an invalid signature!", global::UnityEngine.Color.red);
							LoadingErrorMessage = "Server list has an invalid signature!";
						}
						else
						{
							int num = (int)(TimeBehaviour.CurrentUnixTimestamp - serverListSigned.timestamp);
							if (global::System.Math.Abs(num) > 14400)
							{
								int num2 = num / 60;
								ServerConsole.AddLog("Server list response has expired! Make sure that time and timezone set on your PC is correct. We recommend synchronizing the time. Offset: " + num2 + " minutes.", global::System.ConsoleColor.Red);
								LoadingErrorMessage = "Server list response has expired! Set correct time and timezone on your PC. Offset: " + num2 + " minutes.";
							}
							else
							{
								Servers = JsonSerialize.FromJson<ServerList>(NorthwoodLib.StringUtils.Base64Decode(serverListSigned.payload)).servers;
								_refresh = true;
							}
						}
					}
					catch (global::System.Exception ex)
					{
						GameCore.Console.AddLog("Server list deserialization error: " + ex.Message, global::UnityEngine.Color.red);
						GameCore.Console.AddLog(ex.StackTrace, global::UnityEngine.Color.red);
						LoadingErrorMessage = "Server list deserialization error";
						global::UnityEngine.Debug.LogError("Downloaded lobbylist: " + text);
					}
					break;
				}
				catch (global::System.Exception ex2)
				{
					if (!CentralServer.ChangeCentralServer(remove: true))
					{
						LoadingErrorMessage = "Failed to download servers list.\n" + ex2.Message;
						break;
					}
					LoadingErrorMessage = "Failed to download servers list.\n" + ex2.Message + "\nChecking other servers...";
				}
			}
			_redownload = false;
		}
	}

	static NewServerBrowser()
	{
		_errorMessage = string.Empty;
		_refreshThread = new global::System.Threading.Thread(DownloadList)
		{
			Name = "Server list download thread",
			Priority = global::System.Threading.ThreadPriority.BelowNormal,
			IsBackground = true
		};
	}
}
