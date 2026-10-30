using System.Collections.Generic;
using System.Linq;

public class ServerFilter : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.UI.InputField NameFilterField;

	public global::UnityEngine.Sprite[] SelectBoxes;

	public global::UnityEngine.UI.Image[] FilterImages;

	public ServerTab CurrentTab;

	public List<ServerListItem> FilteredListItems = new List<ServerListItem>();

	private static FilterSettings _curFilters;

	private NewServerBrowser _browser;

	public int ScrollStartPoint = 1;

	public ServerElementButton[] PremadeElements;

	private void Awake()
	{
		_browser = GetComponent<NewServerBrowser>();
		_curFilters = new FilterSettings
		{
			TabFilter = ServerTab.Internet,
			NameFilter = string.Empty,
			CheckboxFilters = new bool[3]
		};
	}

	public void ChangeTab(int tab)
	{
		ChangeTab((ServerTab)tab);
	}

	public void ReapplyFilters(bool forceCleanup = false)
	{
		FilteredListItems.Clear();
		if (_browser == null || forceCleanup || NewServerBrowser.Servers == null)
		{
			DisplayServers();
			return;
		}
		ServerListItem[] servers = NewServerBrowser.Servers;
		for (int i = 0; i < servers.Length; i++)
		{
			ServerListItem server = servers[i];
			if (!GameCore.Version.ListedServerCompatibilityCheck(server.version) || !CheckCheckboxes(server))
			{
				continue;
			}
			SetNameFilterPoints(i);
			string id = server.serverId.ToString();
			bool flag;
			switch (_curFilters.TabFilter)
			{
			case ServerTab.Internet:
				flag = true;
				break;
			case ServerTab.Favorites:
				flag = FavoriteAndHistory.IsInStorage(FavoriteAndHistory.StorageLocation.Favorites, id);
				break;
			case ServerTab.Official:
				flag = server.officialCode != 0;
				break;
			case ServerTab.History:
				flag = FavoriteAndHistory.IsInStorage(FavoriteAndHistory.StorageLocation.History, id);
				break;
			case ServerTab.Friends:
				flag = SteamLobby.FriendsServer.Contains(server.ip + ":" + server.port);
				break;
			default:
				flag = false;
				break;
			}
			if (flag)
			{
				FilteredListItems.Add(NewServerBrowser.Servers[i]);
			}
		}
		if (_curFilters.TabFilter == ServerTab.History)
		{
			FilteredListItems = FilteredListItems.OrderBy((ServerListItem x) => FavoriteAndHistory.History.IndexOf(x.serverId.ToString())).ToList();
		}
		if (!_curFilters.NameFilter.All(char.IsWhiteSpace))
		{
			int threshold = (int)global::UnityEngine.Mathf.Round((float)(_curFilters.NameFilter.Length + 1) * 0.5f);
			FilteredListItems = (from x in FilteredListItems
				where x.NameFilterPoints >= threshold
				orderby x.NameFilterPoints descending
				select x).ToList();
		}
		if (!NewServerBrowser.IsBusy)
		{
			_browser.LoadingText.text = ((FilteredListItems.Count == 0) ? TranslationReader.Get("MainMenu", 54) : string.Empty);
		}
		DisplayServers();
	}

	public void DisplayServers()
	{
		if (FilteredListItems.Count == 0)
		{
			ServerElementButton[] premadeElements = PremadeElements;
			for (int i = 0; i < premadeElements.Length; i++)
			{
				premadeElements[i].gameObject.SetActive(value: false);
			}
			return;
		}
		for (int j = ScrollStartPoint; j < PremadeElements.Length + ScrollStartPoint; j++)
		{
			ServerElementButton serverElementButton = PremadeElements[j - ScrollStartPoint];
			if (j < 0 || j >= FilteredListItems.Count)
			{
				serverElementButton.gameObject.SetActive(value: false);
				continue;
			}
			serverElementButton.gameObject.SetActive(value: true);
			PlayButton component = serverElementButton.GetComponent<PlayButton>();
			ServerListItem serverListItem = FilteredListItems[j];
			component.Ip = serverListItem.ip;
			component.AccountID = serverListItem.accountId;
			component.ServerID = serverListItem.serverId;
			component.Port = serverListItem.port.ToString();
			component.Motd.text = NorthwoodLib.StringUtils.Base64Decode(serverListItem.info);
			component.InfoType = (Misc.ValidatePastebin(serverListItem.pastebin) ? serverListItem.pastebin : "7wV681fT");
			component.Players.text = serverListItem.players;
			serverElementButton.icons[0].SetActive(serverListItem.officialCode != 0);
			serverElementButton.icons[1].SetActive(serverListItem.whitelist);
			serverElementButton.icons[2].SetActive(serverListItem.friendlyFire);
			serverElementButton.icons[3].SetActive(serverListItem.modded);
			serverElementButton.SetValues();
		}
	}

	private void ChangeTab(ServerTab tab)
	{
		if (CurrentTab != tab)
		{
			ScrollStartPoint = 0;
			_curFilters.TabFilter = tab;
			CurrentTab = tab;
			ReapplyFilters();
			if (tab == ServerTab.Friends)
			{
				_browser.Refresh();
			}
		}
	}

	public void ApplyNameFilter()
	{
		ApplyNameFilter(NameFilterField.text);
	}

	private void ApplyNameFilter(string nameFilter)
	{
		_curFilters.NameFilter = nameFilter.ToLowerInvariant();
		ReapplyFilters();
	}

	public void Filters(int id)
	{
		FilterImages[id].sprite = (_curFilters.CheckboxFilters[id] ? SelectBoxes[0] : SelectBoxes[1]);
		_curFilters.CheckboxFilters[id] = !_curFilters.CheckboxFilters[id];
		ReapplyFilters();
	}

	private static bool CheckCheckboxes(ServerListItem server)
	{
		if (_curFilters.CheckboxFilters[2] && server.whitelist)
		{
			return false;
		}
		if (!server.players.Contains("/"))
		{
			return true;
		}
		string[] array = server.players.Split('/');
		if (!int.TryParse(array[0], out var result) || !int.TryParse(array[1], out var result2))
		{
			return true;
		}
		if (_curFilters.CheckboxFilters[0] && result <= 0)
		{
			return false;
		}
		if (_curFilters.CheckboxFilters[1] && result >= result2)
		{
			return false;
		}
		return true;
	}

	private static void SetNameFilterPoints(int id)
	{
		if (_curFilters.NameFilter.All(char.IsWhiteSpace))
		{
			return;
		}
		string text = NorthwoodLib.StringUtils.Base64Decode(NewServerBrowser.Servers[id].info).ToLowerInvariant();
		text = NorthwoodLib.StringUtils.StripTags(Misc.ProcessSmallText(text, 35u, 75u));
		NewServerBrowser.Servers[id].NameFilterPoints = Misc.LongestCommonSubstring(text, _curFilters.NameFilter).Length;
	}
}
