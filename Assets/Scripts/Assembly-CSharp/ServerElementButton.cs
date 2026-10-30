public class ServerElementButton : global::UnityEngine.MonoBehaviour
{
	public static string HighlightedIp;

	public global::UnityEngine.GameObject[] icons;

	public global::UnityEngine.UI.Image FavorImage;

	public global::UnityEngine.Sprite[] FavorSprites;

	public string ServerName;

	public string IpAddress;

	public int Players;

	public uint ServerID;

	public uint AccountID;

	public int MaxPlayers;

	private NewMainMenu newMainMenu;

	private NewServerBrowser newServerBrowser;

	private global::UnityEngine.RectTransform serverInfo;

	private ReportServer reportServer;

	private global::TMPro.TextMeshProUGUI infoText;

	private global::UnityEngine.UI.Image bgColor;

	private void Awake()
	{
		bgColor = GetComponent<global::UnityEngine.UI.Image>();
		newMainMenu = GetComponentInParent<NewMainMenu>();
		newServerBrowser = GetComponentInParent<NewServerBrowser>();
		serverInfo = newServerBrowser.ServerInfo;
		infoText = serverInfo.GetComponentInChildren<global::TMPro.TextMeshProUGUI>();
		reportServer = newMainMenu.GetComponentInChildren<ReportServer>(includeInactive: true);
	}

	private void OnEnable()
	{
		SetValues();
	}

	public void SetValues()
	{
		PlayButton component = GetComponent<PlayButton>();
		IpAddress = component.Ip + ":" + component.Port;
		ServerID = component.ServerID;
		AccountID = component.AccountID;
		ServerName = component.Motd.text;
		string[] array = component.Players.text.Split('/');
		try
		{
			int.TryParse(array[0], out Players);
			int.TryParse(array[1], out MaxPlayers);
		}
		catch (global::System.Exception ex)
		{
			global::UnityEngine.Debug.LogError("Error at ServerElementButton:" + ex);
		}
		SwitchFavorIcon(FavoriteAndHistory.IsInStorage(FavoriteAndHistory.StorageLocation.Favorites, ServerID.ToString()));
	}

	public void SwitchFavorIcon(bool favored)
	{
		FavorImage.sprite = (favored ? FavorSprites[1] : FavorSprites[0]);
	}

	public void PlayButton()
	{
		newMainMenu.Connect(IpAddress);
		FavoriteAndHistory.Modify(FavoriteAndHistory.StorageLocation.IPHistory, IpAddress);
		FavoriteAndHistory.ServerIDLastJoined = ServerID.ToString();
		FavoriteAndHistory.AccountIDLastJoined = AccountID.ToString();
		FavoriteAndHistory.Modify(FavoriteAndHistory.StorageLocation.History, FavoriteAndHistory.ServerIDLastJoined);
	}

	public void ShowInfo()
	{
		MEC.Timing.RunCoroutine(_Show(GetComponent<PlayButton>().InfoType), MEC.Segment.FixedUpdate);
		HighlightedIp = IpAddress;
	}

	private void LateUpdate()
	{
		float num = ((HighlightedIp == IpAddress) ? 0.27f : 0.0784f);
		bgColor.color = new global::UnityEngine.Color(num, num, num, 1f);
	}

	public void MarkAsFavorite()
	{
		string id = ServerID.ToString();
		if (FavoriteAndHistory.IsInStorage(FavoriteAndHistory.StorageLocation.Favorites, id))
		{
			FavoriteAndHistory.Modify(FavoriteAndHistory.StorageLocation.Favorites, id, delete: true);
			FavorImage.sprite = FavorSprites[0];
		}
		else
		{
			FavoriteAndHistory.Modify(FavoriteAndHistory.StorageLocation.Favorites, id);
			FavorImage.sprite = FavorSprites[1];
		}
	}

	public void ReportForm()
	{
		reportServer.ipAddress.text = IpAddress;
		reportServer.root.SetActive(value: true);
		reportServer.report.SetActive(value: true);
	}

	private global::System.Collections.Generic.IEnumerator<float> _Show(string id)
	{
		serverInfo.gameObject.SetActive(value: true);
		infoText.text = string.Empty;
		if (id.IndexOf('/') != -1)
		{
			infoText.text = "The URL isn't directing to pastebin site. Please contact server owner.";
			yield break;
		}
		using HttpCoroutine coroutine = HttpQuery.GetCoroutine("https://pastebin.com/raw/" + id);
		yield return coroutine.Wait();
		string text;
		try
		{
			coroutine.CheckResult();
			text = coroutine.GetText();
		}
		catch (global::System.Exception ex)
		{
			infoText.text = ex.Message;
			yield break;
		}
		if (text.Contains("<title>Pastebin.com - Locked Paste</title>"))
		{
			infoText.text = "The provided paste is locked via password and cannot be displayed. Please contact the server owner.";
			yield break;
		}
		if (text.Length > 5000)
		{
			int num = text.LastIndexOf('\n', 5000);
			text = text.Substring(0, (num == -1) ? 5000 : num) + "...\n<i><color=#87CEFA><u><link=\"https://pastebin.com/" + id + "\">(Click here for full content)</link></u></color></i>";
		}
		infoText.text = text;
	}
}
