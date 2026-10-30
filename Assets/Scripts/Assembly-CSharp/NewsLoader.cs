using System;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using TMPro;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.UI;

// Client-only (bodies stripped from the server build); rebuilt from the 14.2.8 client disassembly.
// Loads the game's Steam news feed into the News tab.
public class NewsLoader : MonoBehaviour
{
	private class Announcement
	{
		public string Title;

		public string Content;

		public string Date;

		public string Link;

		public NewsElement Thumbnail;

		public Announcement(string title, string content, string date, string link, NewsElement thumbnail)
		{
			Title = title;
			Content = content;
			Date = date;
			Link = link;
			Thumbnail = thumbnail;
		}
	}

	private const string NewsUrl = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/?appid=700330&count=5";

	private const int MaxContentLength = 5000;

	private const string CustomLinkRegex = "[ |\\n]((http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?)";

	private static readonly Color SelectedColor = new Color(0.27f, 0.27f, 0.27f, 1f);

	private static readonly Color DeselectedColor = new Color(0.0784f, 0.0784f, 0.0784f, 1f);

	public TextMeshProUGUI ArticleText;

	public RectTransform ContentParent;

	public RectTransform Element;

	public Button OpenNewsUrlButton;

	private List<Announcement> _announcements;

	private string _curAnncUrl;

	private void Start()
	{
		_announcements = new List<Announcement>();
		if (OpenNewsUrlButton != null)
		{
			OpenNewsUrlButton.onClick.AddListener(OpenAnnouncementUrl);
		}
		StartCoroutine(_Request());
	}

	private IEnumerator _Request()
	{
		if (ArticleText != null)
		{
			ArticleText.text = "Fetching news...";
		}
		using UnityWebRequest www = UnityWebRequest.Get(NewsUrl);
		yield return www.SendWebRequest();
		if (www.result != UnityWebRequest.Result.Success)
		{
			Debug.LogWarning("[NewsLoader] Could not load news: " + www.error);
			if (ArticleText != null)
			{
				ArticleText.text = www.error;
			}
			yield break;
		}
		Debug.Log("Obtained news successfully!");
		try
		{
			TextProcessor(www.downloadHandler.text);
		}
		catch (Exception ex)
		{
			Debug.LogException(ex);
		}
	}

	private void DetectCustomLinks(ref string content)
	{
		MatchCollection matches = new Regex(CustomLinkRegex).Matches(content);
		// Back to front so earlier match indices stay valid after inserting tags.
		for (int i = matches.Count - 1; i >= 0; i--)
		{
			Group url = matches[i].Groups[1];
			content = content.Insert(url.Index + url.Length, "</link></u></color>");
			content = content.Insert(url.Index, "<color=#87CEFA><u><link=" + url.Value + ">");
		}
	}

	private void DetectImages(ref string content)
	{
		while (content.Contains("[img]"))
		{
			int start = content.IndexOf("[img]", StringComparison.Ordinal);
			int urlStart = start + "[img]".Length;
			int end = content.IndexOf("[", urlStart, StringComparison.Ordinal);
			if (end < 0)
			{
				break;
			}
			string url = content.Substring(urlStart, end - urlStart);
			int close = content.IndexOf("]", end, StringComparison.Ordinal);
			content = content.Remove(start, (close < 0 ? end : close + 1) - start);
			if (url.Contains("{STEAM_CLAN_IMAGE}"))
			{
				url = url.Replace("{STEAM_CLAN_IMAGE}", "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/clans");
			}
			content = content.Insert(start, "<color=#87CEFA><link=" + url + ">[ OPEN IMAGE ]</link></color>");
		}
	}

	private void DetectYoutubePreview(ref string content)
	{
		int start;
		while ((start = content.IndexOf("[previewyoutube=", StringComparison.Ordinal)) >= 0)
		{
			int idStart = start + "[previewyoutube=".Length;
			int end = content.IndexOf("[/previewyoutube]", idStart, StringComparison.Ordinal);
			if (end < 0)
			{
				break;
			}
			int idEnd = content.IndexOfAny(new char[2] { ';', ']' }, idStart);
			if (idEnd < 0 || idEnd > end)
			{
				idEnd = end;
			}
			content = content.Remove(idEnd, end - idEnd).Insert(idEnd, "\">[ OPEN YOUTUBE VIDEO ]");
			content = ReplaceFirst(content, "[previewyoutube=", "<color=#87CEFA><link=\"https://www.youtube.com/watch?v=");
			content = ReplaceFirst(content, "[/previewyoutube]", "</link></color>");
		}
	}

	private static string ReplaceFirst(string text, string search, string replacement)
	{
		int index = text.IndexOf(search, StringComparison.Ordinal);
		if (index < 0)
		{
			return text;
		}
		return text.Remove(index, search.Length).Insert(index, replacement);
	}

	private void TextProcessor(string text)
	{
		NewsRaw raw = JsonSerialize.FromJson<NewsRaw>(text);
		NewsListItem[] items = raw.appnews.newsitems;
		if (items == null || Element == null || ContentParent == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			NewsListItem item = items[i];
			// The original adds the Unix seconds to 1970-01-01 without converting to local time.
			DateTime dateTime = new DateTime(1970, 1, 1).AddSeconds(item.date);
			string content = item.contents ?? string.Empty;
			if (content.Length > MaxContentLength)
			{
				int cut = content.LastIndexOf('\n', MaxContentLength - 1, MaxContentLength);
				content = content.Substring(0, (cut == -1) ? MaxContentLength : (cut + 1));
				content = content + "...\n<i><color=#87CEFA><u><link=\"" + item.url + "\">(Click here for full content)</link></u></color></i>";
			}
			content = content.Replace("[b]", "<b>").Replace("[/b]", "</b>").Replace("[i]", "<i>")
				.Replace("[/i]", "</i>")
				.Replace("[u]", "<u>")
				.Replace("[/u]", "</u>")
				.Replace("[h1]", "<size=21><color=#ffe2bd>")
				.Replace("[/h1]", "</color></size>")
				.Replace("[h2]", "<size=19><color=#ffe2bd>")
				.Replace("[/h2]", "</color></size>")
				.Replace("[h3]", "<size=17><color=#ffe2bd>")
				.Replace("[/h3]", "</color></size>")
				.Replace("[strike]", "<s>")
				.Replace("[/strike]", "</s>")
				.Replace("[code]", "<size=15><i>")
				.Replace("[/code]", "</i></size>")
				.Replace("[*]", "•")
				.Replace("[list]", string.Empty)
				.Replace("[/list]", string.Empty)
				.Replace("[olist]", string.Empty)
				.Replace("[/olist]", string.Empty);
			DetectYoutubePreview(ref content);
			int urlStart;
			while ((urlStart = content.IndexOf("[url=", StringComparison.Ordinal)) >= 0)
			{
				int close = content.IndexOf("]", urlStart, StringComparison.Ordinal);
				if (close < 0)
				{
					break;
				}
				content = content.Remove(close, 1).Insert(close, "\">");
				content = ReplaceFirst(content, "[url=", "<color=#87CEFA><u><link=\"");
			}
			content = content.Replace("[/url]", "</link></u></color>");
			string date = dateTime.ToString("D");
			DetectCustomLinks(ref content);
			DetectImages(ref content);
			RectTransform instance = UnityEngine.Object.Instantiate(Element, ContentParent, worldPositionStays: true);
			NewsElement element = instance.GetComponent<NewsElement>();
			element.Title.text = item.title;
			element.Date.text = date;
			element.Content.text = content;
			element.Id = i;
			_announcements.Add(new Announcement(item.title, content, date, item.url, element));
			element.gameObject.transform.localScale = Vector3.one;
		}
		ShowAnnouncement(0);
	}

	internal void OpenAnnouncementUrl()
	{
		if (!string.IsNullOrEmpty(_curAnncUrl))
		{
			Application.OpenURL(_curAnncUrl);
		}
	}

	internal void ShowAnnouncement(int id)
	{
		if (_announcements == null || id < 0 || id >= _announcements.Count)
		{
			return;
		}
		Announcement announcement = _announcements[id];
		_curAnncUrl = announcement.Link;
		ArticleText.text = "<size=30><b>" + announcement.Title + "</b></size>\n<size=23><i>" + announcement.Date + "</i></size>\n\n<size=17><color=#F0F8FF>" + announcement.Content + "</color></size>";
		announcement.Thumbnail.Background.color = SelectedColor;
		if (OpenNewsUrlButton != null)
		{
			OpenNewsUrlButton.interactable = true;
		}
		for (int i = 0; i < _announcements.Count; i++)
		{
			if (i != id)
			{
				_announcements[i].Thumbnail.Background.color = DeselectedColor;
			}
		}
	}
}
