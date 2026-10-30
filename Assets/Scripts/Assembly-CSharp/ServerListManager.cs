using System;
using System.Collections.Generic;
using MEC;
using UnityEngine;
using UnityEngine.UI;

public class ServerListManager : MonoBehaviour
{
	public RectTransform contentParent;

	public RectTransform element;

	public Text loadingText;

	private List<GameObject> spawns = new List<GameObject>();

	private ServerListItem[] _servers;

	private int _downloading;

	private static string _filter;

	private static int _filterTolerance;

	private void Awake()
	{
		_filter = string.Empty;
	}

	private GameObject AddRecord()
	{
		RectTransform rectTransform = UnityEngine.Object.Instantiate(element, contentParent, worldPositionStays: true);
		rectTransform.localScale = Vector3.one;
		rectTransform.localPosition = Vector3.zero;
		spawns.Add(rectTransform.gameObject);
		contentParent.sizeDelta = new Vector2(contentParent.sizeDelta.x, (float)(spawns.Count * 150) * element.localScale.y);
		return rectTransform.gameObject;
	}

	private void OnEnable()
	{
		Timing.RunCoroutine(DownloadList(), Segment.FixedUpdate);
	}

	public void ApplyNameFilter(string nameFilter)
	{
		string text = nameFilter.ToLower();
		if (!(text == _filter))
		{
			_filter = text;
			int length = _filter.Length;
			_filterTolerance = ((length < 5) ? length : ((length < 10) ? ((int)((double)length * 0.8)) : ((int)((double)length * 0.75))));
			Timing.RunCoroutine(DisplayList(), Segment.FixedUpdate);
		}
	}

	public void Refresh()
	{
		Timing.RunCoroutine(DownloadList(), Segment.FixedUpdate);
	}

	private IEnumerator<float> DownloadList()
	{
		GameCore.Console.AddLog("Loading server list...", Color.gray);
		loadingText.text = TranslationReader.Get("MainMenu", 53, "NO_TRANSLATION");
		foreach (GameObject spawn in spawns)
		{
			UnityEngine.Object.Destroy(spawn);
		}
		spawns.Clear();
		_servers = null;
		bool loaded = false;
		for (byte i = 0; i < 2; i++)
		{
			using HttpCoroutine coroutine = HttpQuery.PostCoroutine(CentralServer.StandardUrl + "lobbylist.php?format=json-signed-unix&version=2&minimal=1", "token=" + CentralAuth.CentralAuthManager.ApiToken + "&nonce=" + CentralAuth.CentralAuthManager.Nonce, "application/x-www-form-urlencoded");
			yield return coroutine.Wait();
			string text;
			try
			{
				text = coroutine.GetText();
			}
			catch (Exception ex)
			{
				if (!CentralServer.ChangeCentralServer(remove: true))
				{
					loadingText.text = "Failed to download servers list.\n" + ex.Message + "\nChecked all servers.";
					break;
				}
				loadingText.text = "Failed to download servers list.\n" + ex.Message + "\nChecking other servers...";
				continue;
			}
			try
			{
				ServerListSigned serverListSigned = JsonSerialize.FromJson<ServerListSigned>(text);
				if (!string.IsNullOrEmpty(serverListSigned.nonce))
				{
					CentralAuth.CentralAuthManager.Nonce = serverListSigned.nonce;
				}
				if (!Cryptography.ECDSA.Verify(string.Format("{0}##{1}", serverListSigned.payload, serverListSigned.timestamp), serverListSigned.signature, ServerConsole.PublicKey))
				{
					GameCore.Console.AddLog("Server list has an invalid signature!", Color.red);
					loadingText.text = "Server list has an invalid signature!";
				}
				else if (Math.Abs(TimeBehaviour.CurrentUnixTimestamp - serverListSigned.timestamp) > 14400)
				{
					ServerConsole.AddLog("Server list response has expired! Make sure that time and timezone set on your PC is correct. We recommend synchronizing the time.", ConsoleColor.Red);
					loadingText.text = "Server list response has expired! Set correct time and timezone on your PC.";
				}
				else
				{
					_servers = JsonSerialize.FromJson<ServerList>(NorthwoodLib.StringUtils.Base64Decode(serverListSigned.payload)).servers;
					loaded = true;
				}
			}
			catch (Exception ex2)
			{
				GameCore.Console.AddLog("Server list deserialization error: " + ex2.Message, Color.red);
				GameCore.Console.AddLog(ex2.StackTrace, Color.red);
				loadingText.text = "Server list deserialization error";
				Debug.LogError("Downloaded lobbylist: " + text);
			}
			break;
		}
		if (loaded)
		{
			GameCore.Console.AddLog("Servers list loaded", Color.gray);
			Timing.RunCoroutine(DisplayList(), Segment.FixedUpdate);
		}
		else
		{
			GameCore.Console.AddLog("Failed to load servers list loaded", Color.red);
		}
	}

	private IEnumerator<float> DisplayList()
	{
		int id = ++_downloading;
		if (_servers == null)
		{
			yield break;
		}
		bool noFilter = string.IsNullOrWhiteSpace(_filter);
		foreach (GameObject spawn in spawns)
		{
			UnityEngine.Object.Destroy(spawn);
		}
		spawns.Clear();
		loadingText.text = string.Empty;
		ServerListItem[] servers = _servers;
		for (int i = 0; i < servers.Length; i++)
		{
			if (id != _downloading)
			{
				yield break;
			}
			ServerListItem serverListItem = servers[i];
			if (!GameCore.Version.ListedServerCompatibilityCheck(serverListItem.version))
			{
				continue;
			}
			string text = NorthwoodLib.StringUtils.Base64Decode(serverListItem.info);
			if (!noFilter && Misc.LongestCommonSubstring(NorthwoodLib.StringUtils.StripTags(text.ToLower()), _filter).Length < _filterTolerance)
			{
				continue;
			}
			try
			{
				PlayButton component = AddRecord().GetComponent<PlayButton>();
				component.Motd.text = text;
				component.AccountID = serverListItem.accountId;
				component.ServerID = serverListItem.serverId;
				component.Ip = serverListItem.ip;
				component.Port = serverListItem.port.ToString();
				component.Players.text = serverListItem.players;
				component.InfoType = (Misc.ValidatePastebin(serverListItem.pastebin) ? serverListItem.pastebin : "7wV681fT");
			}
			catch (Exception ex)
			{
				GameCore.Console.AddLog("Error displaying server: " + ex.Message, Color.red);
				GameCore.Console.AddLog(ex.StackTrace, Color.red);
			}
			if (i % 5 == 0)
			{
				yield return 0f;
			}
		}
		if (spawns.Count == 0)
		{
			loadingText.text = TranslationReader.Get("MainMenu", 54, "NO_TRANSLATION");
		}
	}
}
